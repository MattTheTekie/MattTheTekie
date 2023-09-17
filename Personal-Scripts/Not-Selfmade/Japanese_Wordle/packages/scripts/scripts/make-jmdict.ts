import fs from 'fs'

import createConnectionPool, { sql } from '@databases/pg'
import axios from 'axios'
import cheerio from 'cheerio'
import flow, { toXml } from 'xml-flow'

export const JMDICT_RAW = './cache/JMdict_e.xml'

export async function populate() {
  const db = createConnectionPool({
    bigIntMode: 'number'
  })

  const xmlFlow = flow(fs.createReadStream(JMDICT_RAW))

  const entries: {
    id: string
    xml: string
  }[] = []

  let vocab: string[] = []

  xmlFlow.on('tag:entry', (ent) => {
    const xml = toXml(ent)
    const $ = cheerio.load(xml)

    const id = $('ent_seq').text()

    $('k_ele').each((_, k_ele) => {
      const $k_ele = $(k_ele)

      let value = $k_ele.find('keb').text()

      if (!value) {
        value = $k_ele.text().trim()
        if (!value || /[a-z]/i.test(value)) return
      }

      vocab.push(value)
    })

    $('r_ele').each((_, r_ele) => {
      const $r_ele = $(r_ele)

      let value = $r_ele.find('reb').text()
      if (!value) {
        value = $r_ele.text().trim()
        if (!value || /[a-z]/i.test(value)) return
      }

      vocab.push(value)
    })

    entries.push({ id, xml })
  })

  await new Promise((resolve, reject) => {
    xmlFlow.once('end', resolve).once('error', reject)
  })

  const batchSize = 1000

  for (let i = 0; i < entries.length; i += batchSize) {
    await db.query(
      sql`INSERT INTO jmdict ("id", "entry") VALUES ${sql.join(
        entries.slice(i, i + batchSize).map((it) => sql`(${it.id}, ${it.xml})`),
        ','
      )}`
    )
  }

  vocab = [...new Set(vocab)]

  for (let i = 0; i < vocab.length; i += batchSize) {
    await axios
      .post<Record<string, number>>(
        `https://cdn.zhquiz.cc/api/wordfreq?lang=ja`,
        {
          q: vocab.slice(i, i + batchSize)
        }
      )
      .then(({ data }) =>
        db.query(
          sql`INSERT INTO jfreq ("entry", "frequency") VALUES ${sql.join(
            Object.entries(data).map(([slug, f]) => sql`(${slug}, ${f})`),
            ','
          )}`
        )
      )
  }
}

if (require.main === module) {
  populate()
}
