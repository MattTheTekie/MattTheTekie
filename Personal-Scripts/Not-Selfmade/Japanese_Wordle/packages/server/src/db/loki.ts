import fs from 'fs'

import axios from 'axios'
import Loki from 'lokijs'

import { IDict, IDictElement } from './types'

export let db: Loki
export let Dict: Collection<IDict>
export let DictElement: Collection<IDictElement>

export async function initDB(
  filename = 'cache/jmdict.loki',
  source = 'https://github.com/patarapolw/kirenai-kotoba/releases/download/v0.1.1-server/jmdict.loki'
) {
  return new Promise<Loki>(async (resolve, reject) => {
    let isNew = !fs.existsSync(filename)
    if (isNew && source) {
      await axios
        .get(source, {
          transformResponse: (d) => d
        })
        .then((r) => fs.writeFileSync(filename, r.data))
    }

    db = new Loki(filename, {
      autoload: true,
      autoloadCallback: async (err) => {
        if (err) {
          reject(err)
          return
        }

        if (isNew) {
          Dict = db.addCollection('Dict', {
            indices: ['frequency', 'tag'],
            unique: ['_id']
          })

          DictElement = db.addCollection('DictElement', {
            indices: [
              'dict',
              'value',
              'length',
              'char',
              'repeat',
              'repeatx',
              'primary'
            ]
          })
        } else {
          Dict = db.getCollection('Dict')
          DictElement = db.getCollection('DictElement')
        }

        resolve(db)
      }
    })
  })
}
