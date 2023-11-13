import { defineConfig } from 'astro/config';
import mdx from '@astrojs/mdx';
import sitemap from '@astrojs/sitemap';
import react from '@astrojs/react';
import tailwind from '@astrojs/tailwind';
import remarkMath from 'remark-math';
import rehypeSlug from 'rehype-slug';
import rehypeAutolinkHeadings from 'rehype-autolink-headings';
import rehypeKatex from 'rehype-katex';

export default defineConfig({
  experimental: {
    viewTransitions: true,
  },
  site: 'https://example.com',
  integrations: [
    mdx({
      extendMarkdownConfig: true,
    }),
    sitemap(),
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
