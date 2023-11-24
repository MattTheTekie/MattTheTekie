import { test, expect } from '@playwright/test'

test('Page should exist', async ({ page }) => {
  await page.goto('http://localhost:4321/blog')
  expect(page).toBeDefined()
})

test('Page should have a title', async ({ page }) => {
  await page.goto('http://localhost:4321/blog')
  const title = await page.title()
  expect(title).toBe('Filipe Lima')
})

test('Page should have valid links', async ({ page }) => {
  await page.goto('http://localhost:4321/blog')

  const links = await page.$$eval('main a', (as) =>
    as.map((a) => a.getAttribute('href'))
  )

  for (const link of links) {
    if (link === null) continue

    expect(link).toBeDefined()
    await page.goto(`http://localhost:4321${link}`)
    expect(page.url()).toBe(`http://localhost:4321${link}`)
  }
})