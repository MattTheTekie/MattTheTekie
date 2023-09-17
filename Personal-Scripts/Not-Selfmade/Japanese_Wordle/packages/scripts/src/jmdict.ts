import fs from 'fs'

import axios from 'axios'
import sqlite3 from 'better-sqlite3'
import cheerio from 'cheerio'
import flow, { toXml } from 'xml-flow'

export const JMDICT_RAW = './cache/JMdict_e.xml'

interface IEntryValue {
  value: string
  isKanji?: number
  length?: number
  primary?: number
}

interface IDictMeaning {
  pos?: string
  xref?: string[]
  gloss: string[]
}

export class JMdictXML {
  $: ReturnType<typeof cheerio.load>

  constructor(public filename = JMDICT_RAW) {
    this.$ = cheerio.load(fs.readFileSync(this.filename), {
      decodeEntities: true
    })
  }

  lookup(v: string) {
    const type = /\p{sc=Han}/u.test(v) ? 'keb' : 'reb'
    return this.$(`${type}:contains("${v}")`).parents('entry')
  }
}

export class JMDictSQLite {
  static async build(xml = JMDICT_RAW, filename?: string) {
    const xmlFlow = flow(fs.createReadStream(xml))
    const db = new JMDictSQLite(filename, false)

    db.sql.exec(/* sql */ `
    CREATE TABLE dict (
      id          TEXT NOT NULL PRIMARY KEY,
      frequency   FLOAT,
      meaning     JSON NOT NULL,
      "xml"       TEXT NOT NULL
    );

    CREATE INDEX idx_dict_frequency ON dict(frequency);

    CREATE TABLE element (
      dictId      TEXT NOT NULL REFERENCES dict(id),
      "value"     TEXT NOT NULL,
      isKanji     BOOLEAN,
      "primary"   BOOLEAN
    );

    CREATE INDEX idx_element_dictId ON element(dictId);
    CREATE INDEX idx_element_value ON element("value");
    CREATE INDEX idx_element_length ON element((length("value")));
    CREATE INDEX idx_element_isKanji ON element(isKanji);
    CREATE INDEX idx_element_primary ON element("primary");
    `)

    const entries: {
      _id: string
      slug: string
      xml: string
      values: IEntryValue[]
      frequency?: number
      meaning: IDictMeaning[]
    }[] = []

    xmlFlow.on('tag:entry', (ent) => {
      const xml = toXml(ent)
      const $ = cheerio.load(xml)

      const _id = $('ent_seq').text()
      const values: IEntryValue[] = []

      $('k_ele').each((_, k_ele) => {
        const $k_ele = $(k_ele)

        let value = $k_ele.find('keb').text()
        let primary = false

        if (value) {
          primary = !!$k_ele.find('ke_pri').length
        } else {
          value = $k_ele.text().trim()
          if (!value || /[a-z]/i.test(value)) return
        }

        const v: IEntryValue = {
          value,
          isKanji: 1
        }

        if (primary) {
          v.primary = 1
        }

        values.push(v)
      })

      $('r_ele').each((_, r_ele) => {
        const $r_ele = $(r_ele)

        let value = $r_ele.find('reb').text()
        let primary = !!$r_ele.find('re_pri').length
        if (value) {
          primary = !!$r_ele.find('re_pri').length
        } else {
          value = $r_ele.text().trim()
          if (!value || /[a-z]/i.test(value)) return
        }

        const v: IEntryValue = {
          value
        }

        if (primary) {
          v.primary = 1
          v.length = value.length
        }

        values.push(v)
      })

      if (!values.length) return

      const meaning: IDictMeaning[] = []

      $('sense').each((_, sense) => {
        const $sense = $(sense)
        const m: IDictMeaning = {
          gloss: Array.from($sense.find('gloss')).map((g) => $(g).text())
        }

        const pos = $sense.find('pos').text()
        if (pos.length) {
          m.pos = pos
        }

        const xref = Array.from($sense.find('xref')).map((g) => $(g).text())
        if (xref.length) {
          m.xref = xref
        }

        meaning.push(m)
      })

      entries.push({
        _id,
        slug: (values.filter((v) => v.primary)[0] || values[0])!.value,
        xml,
        values,
        meaning
      })
    })

    const batchSize = 1000

    await new Promise((resolve, reject) => {
      xmlFlow.once('end', resolve).once('error', reject)
    })

    for (let i = 0; i < entries.length; i += batchSize) {
      const map = new Map<string, typeof entries>()
      entries.slice(i, i + batchSize).map((it) => {
        const vs = map.get(it.slug) || []
        vs.push(it)
        map.set(it.slug, vs)
      })

      await axios
        .post<Record<string, number>>(
          `https://cdn.zhquiz.cc/api/wordfreq?lang=ja`,
          {
            q: [
              ...new Set(
                Array.from(map.values()).flatMap((vs) => vs.map((v) => v.slug))
              )
            ]
          }
        )
        .then(({ data }) => {
          Object.entries(data).map(([slug, f]) => {
            const vs = (map.get(slug) || []).map((v) => {
              v.frequency = f
              return v
            })
            map.set(slug, vs)
          })
        })

      const currentEntries = Array.from(map.values()).flat()

      {
        const stmt = db.sql.prepare(/* sql */ `
        INSERT INTO dict (id, frequency, meaning, "xml")
        VALUES (:id, :frequency, :meaning, :xml)
        `)

        db.sql.transaction(() => {
          currentEntries.map((it) =>
            stmt.run({
              id: it._id,
              frequency: it.frequency,
              xml: it.xml,
              meaning: JSON.stringify(it.meaning)
            })
          )
        })()
      }

      {
        const stmt = db.sql.prepare(/* sql */ `
        INSERT INTO element (dictId, "value", isKanji, "primary")
        VALUES (:id, :value, :isKanji, :primary)
        `)

        db.sql.transaction(() => {
          currentEntries.map((it) =>
            it.values.map((v) =>
              stmt.run({
                ...v,
                id: it._id,
                value: v.value,
                isKanji: v.isKanji,
                primary: v.primary
              })
            )
          )
        })()
      }
    }

    return db
  }

  sql: sqlite3.Database

  constructor(public filename = './cache/jmdict2.sqlite', readonly = true) {
    this.sql = sqlite3(filename, { readonly })
  }

  lookup(v: string) {
    return this.sql
      .prepare(
        /* sql */ `
    SELECT * FROM jmdict(@v)
    `
      )
      .all({ v })
  }
}

if (require.main === module) {
  JMDictSQLite.build()
}
