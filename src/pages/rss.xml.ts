import rss, { type RSSFeedItem } from '@astrojs/rss'
import { getCollection } from 'astro:content'
import { SITE_TITLE, SITE_DESCRIPTION } from '../consts'

export async function get (context: { site: string | URL }): Promise<{ body: string }> {
  const posts = await getCollection('blog')
  const items = [] as RSSFeedItem[]
  for (const post of posts) {
    items.push({
      title: post.data.title,
      description: post.data.summary,
      pubDate: post.data.publishedAt,
      link: `/blog/${post.slug}/`,
      content: post.body
    })
  }

  return await rss({
    title: SITE_TITLE,
    description: SITE_DESCRIPTION,
    site: context.site,
    items
  })
}