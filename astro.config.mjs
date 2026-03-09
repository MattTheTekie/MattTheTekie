import { defineConfig } from 'astro/config';
import mdx from '@astrojs/mdx';
import react from '@astrojs/react';
import tailwind from '@astrojs/tailwind';
import remarkMath from 'remark-math';
import rehypeSlug from 'rehype-slug';
import rehypeAutolinkHeadings from 'rehype-autolink-headings';
import rehypeKatex from 'rehype-katex';
import sitemap from '@astrojs/sitemap';

// Safe sitemap wrapper to avoid _routes undefined crash
function safeSitemap() {
  const sitemapPlugin = sitemap();
  return {
    name: 'safe-sitemap',
    hooks: {
      'astro:build:done': (buildData) => {
        if (!buildData._routes) {
          console.warn('[safe-sitemap] _routes is undefined. Skipping sitemap generation.');
          return;
        }
        if (sitemapPlugin.hooks && sitemapPlugin.hooks['astro:build:done']) {
          sitemapPlugin.hooks['astro:build:done'](buildData);
        }
      },
    },
  };
}

// https://astro.build/config
export default defineConfig({
  site: 'https://home.veltron.net',
  integrations: [
    mdx({ extendMarkdownConfig: true }),
    safeSitemap(),
    react(),
    tailwind(),
  ],
  markdown: {
    shikiConfig: {
      theme: 'min-dark',
      wrap: true,
    },
    remarkPlugins: [remarkMath],
    rehypePlugins: [
      rehypeKatex,
      rehypeSlug,
      [
        rehypeAutolinkHeadings,
        {
          behavior: 'wrap',
          properties: {
            className: ['anchor'],
          },
        },
      ],
    ],
    gfm: true,
  },
});
