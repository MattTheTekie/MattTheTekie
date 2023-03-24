import { execSync } from 'child_process'
import fs from 'fs'

import { Dict, DictElement, db, initDB } from '@/db/loki'
import {
  IDict,
  IDictElement,
  IDictMeaning,
  reJa,
  simplifySmall
} from '@/db/types'
import axios from 'axios'
import cheerio from 'cheerio'
import { toHiragana } from 'wanakana'
import flow, { toXml } from 'xml-flow'

const jmdictXml = 'cache/JMdict_e.xml'

export async function init() {
  if (!fs.existsSync(jmdictXml)) {
    execSync(
      `curl ftp://ftp.edrdg.org/pub/Nihongo//JMdict_e.gz | gunzip > ${jmdictXml}`
    )
  }

  const xmlFlow = flow(fs.createReadStream(jmdictXml))

  const batchSize = 1000
  const entries: (IDict & {
    slug: string
    values: IDictElement[]
  })[] = []

  xmlFlow.on('tag:entry', (ent) => {
    const xml = toXml(ent)
    const $ = cheerio.load(xml)

    const _id = $('ent_seq').text()
    const values: IDictElement[] = []

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

      const allChar = Array.from(toHiragana(value).matchAll(reJa)).map(
        (m) => m[0]!
      )
      const char = [...new Set(allChar)]
      const allCharX = simplifySmall(allChar)

      const v: IDictElement = {
        dict: _id,
        value,
        char,
        repeat: allChar.length - char.length,
        repeatx: allCharX.length - new Set(allCharX).size
      }

      if (primary) {
        v.primary = true
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

      const allChar = Array.from(toHiragana(value).matchAll(reJa)).map(
        (m) => m[0]!
      )
      const char = [...new Set(allChar)]
      const allCharX = simplifySmall(allChar)

      const v: IDictElement = {
        dict: _id,
        value,
        char,
        repeat: allChar.length - char.length,
        repeatx: allCharX.length - new Set(allCharX).size
      }

      if (primary) {
        v.primary = true
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
      values,
      meaning
    })
  })

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
        `http://localhost:18121/api/wordfreq?lang=ja`,
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

    await initDB(undefined, '')

    Dict.insert(
      currentEntries.map((it) => ({
        _id: it._id,
        frequency: it.frequency,
        meaning: it.meaning,
        tag: []
      }))
    )

    DictElement.insert(currentEntries.flatMap((it) => it.values))
  }

  await new Promise<void>((resolve, reject) => {
    db.save((err) => {
      err ? reject(err) : resolve()
    })
  })
}

export async function addPos() {
  const xmlFlow = flow(fs.createReadStream(jmdictXml))

  const posMap: Record<string, string[]> = {}

  xmlFlow.on('tag:entry', (ent) => {
    const xml = toXml(ent)
    const $ = cheerio.load(xml)

    const _id = $('ent_seq').text()
    const pos = Array.from($('pos'))
      .map((p) => $(p).text().replace(/[&;]/g, ''))
      .filter((s) => s)

    posMap[_id] = pos
  })

  await new Promise((resolve, reject) => {
    xmlFlow.once('end', resolve).once('error', reject)
  })

  await initDB()

  console.log(new Set(Object.values(posMap).flat()))

  Dict.updateWhere(
    (it) => !!posMap[it._id],
    (it) => ({
      ...it,
      tag: [...new Set([...(it.tag || []), ...(posMap[it._id] || [])])]
    })
  )

  Dict.ensureIndex('tag')

  await new Promise<void>((resolve, reject) => {
    db.save((err) => {
      err ? reject(err) : resolve()
    })
  })
}

export async function addModifiedPos() {
  await initDB()

  console.dir(Dict.find({ tag: { $containsAny: ['vt'] } }), { depth: null })
}

if (require.main === module) {
  addModifiedPos()
}
