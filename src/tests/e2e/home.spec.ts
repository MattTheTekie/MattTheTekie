import { test, expect } from '@playwright/test'

test('Page should exist', async ({ page }) => {
  await page.goto('http://localhost:4321/')
  expect(page).toBeDefined()
})

test('Page should have a title', async ({ page }) => {
  await page.goto('http://localhost:4321/')
  const title = await page.title()
  expect(title).toBe('Filipe Lima')
})

test('Header should have valid links', async ({ page }) => {
  await page.goto('http://localhost:4321/')

  const links = await page.$$eval('header a', (as) =>
    as.map((a) => a.getAttribute('href'))
  )

  for (const link of links) {
    if (link === null) continue
    if (link.startsWith('http')) continue
    if (link.endsWith('.pdf')) continue

    expect(link).toBeDefined()
    await page.goto(`http://localhost:4321${link}`)
    expect(page.url()).toBe(`http://localhost:4321${link}`)
  }
})

test('Page should have valid links', async ({ page }) => {
  await page.goto('http://localhost:4321/')

  const links = await page.$$eval('main a', (as) =>
    as.map((a) => a.getAttribute('href'))
  )

  const urlRegex = /^(http:\/\/localhost:4321|https?:\/\/[^\s/$.?#].[^\s]*)$/

  for (const link of links) {
    if (link !== null) {
      expect(
        link.startsWith('http')
          ? link
          : `http://localhost:4321${link}`
      ).toMatch(urlRegex)
    }
  }
})