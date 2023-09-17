import { JMdictXML } from '@/jmdict'
import { ReadLine } from '@/util'

export async function defineXmlSelector() {
  const d = new JMdictXML()
  const rl = new ReadLine()

  while (true) {
    const sel = (await rl.question(`selector: `)).trim()
    if (!sel) {
      break
    }

    const ent = Array.from(d.$(sel).parents('entry'))

    console.log(ent.map((it) => d.$(it).html()).join('\n\n'))
    console.log(ent.length)
  }

  rl.close()
}

if (require.main === module) {
  defineXmlSelector()
}
