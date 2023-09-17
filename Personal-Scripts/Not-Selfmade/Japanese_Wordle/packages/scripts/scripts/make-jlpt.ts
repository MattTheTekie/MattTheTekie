import fs from 'fs'

import { Jisho } from '@/jisho'

async function main() {
  const stream = fs.createWriteStream('assets/jlpt.txt', 'utf-8')

  for await (const it of new Jisho().search('#jlpt #words')) {
    stream.write(
      `${it.slug} [${[...new Set(it.japanese.map((j) => j.reading))].join(
        ' '
      )}] ${[...it.jlpt.map((j) => j.substring(j.length - 2)), ...it.tags].join(
        ' '
      )}\n`
    )
  }

  stream.end()
}

main()
