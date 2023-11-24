import { test, expect, type ElementHandle } from '@playwright/test'

test('Page should exist', async ({ page }) => {
  await page.goto('http://localhost:4321/brain')
  expect(page).toBeDefined()
})

test('Page should have a title', async ({ page }) => {
  await page.goto('http://localhost:4321/brain')
  const title = await page.title()
  expect(title).toBe('Fork My Brain')
})

test('Page should have valid links', async ({ page }) => {
  await page.goto('http://localhost:4321/brain')

  const links: string[] = []
  const ul = await page.$('aside ul')

  const collectLinks = async (ul: ElementHandle): Promise<void> => {
    const lis = await ul.$$('li')
    let nextUl
    if (lis.length === 0) return
    for (const li of lis) {
      const a = await li.$('a')
      const buttons = await li.$$('div > button')
      if (a !== null) {
        const href = await a.getAttribute('href')
        if (href !== null) links.push(href)
      }
      if (buttons.length > 0) {
        for (const button of buttons) {
          await button.click()

          await page.waitForTimeout(1000)
          nextUl = await li.$('ul')
          if (nextUl !== null) await collectLinks(nextUl)
        }
      }
    }
  }

  if (ul !== null) await collectLinks(ul)

  const urlRegex = /^(http:\/\/localhost:4321|https?:\/\/[^\s/$.?#].[^\s]*)$/

  for (const link of links) {
    if (link !== null) {
      expect(`http://localhost:4321${link}`).toMatch(urlRegex)
    }
  }
})