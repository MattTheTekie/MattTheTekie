import axios from 'axios'

export interface JishoSearchResult {
  data: {
    slug: string
    tags: string[]
    jlpt: string[]
    japanese: {
      word?: string
      reading: string
    }[]
  }[]
}

export class Jisho {
  api = axios.create({
    baseURL: 'https://jisho.org/api/v1/'
  })

  async *search(keyword: string) {
    let current: JishoSearchResult = {
      data: []
    }
    let page = 1

    while (true) {
      current = await this.api
        .get<JishoSearchResult>('/search/words', {
          params: { keyword, page }
        })
        .then((r) => r.data)

      if (!current.data.length) {
        break
      }

      console.log(`Received page ${page}`)

      for (const d of current.data) {
        yield d
      }

      page++
    }
  }
}

if (require.main === module) {
  console.log(process.argv.slice(2).join(' '))
}
