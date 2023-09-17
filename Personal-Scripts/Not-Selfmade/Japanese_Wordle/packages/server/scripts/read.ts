import { DictElement, initDB } from '@/db/loki'

async function main() {
  await initDB()
  console.log(DictElement.findOne({ repeat: { $gt: 0 } }))
}

if (require.main === module) {
  main()
}
