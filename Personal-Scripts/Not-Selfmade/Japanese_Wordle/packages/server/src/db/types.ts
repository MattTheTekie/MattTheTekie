import S from 'jsonschema-definer'
import { toHiragana } from 'wanakana'

export const sDictMeaning = S.shape({
  pos: S.string().optional(),
  xref: S.list(S.string()).minItems(1).optional(),
  gloss: S.list(S.string())
})

export type IDictMeaning = typeof sDictMeaning.type

export const sDict = S.shape({
  _id: S.string(),
  frequency: S.number().optional(),
  meaning: S.list(sDictMeaning),
  tag: S.list(S.string()).optional()
})

export type IDict = typeof sDict.type

export const reKana = /[\p{sc=Katakana}\p{sc=Hiragana}ー]/gu
export const reJa = /[\p{sc=Han}\p{sc=Katakana}\p{sc=Hiragana}ー]/gu

export const sDictElement = S.shape({
  dict: S.string(),
  value: S.string(),
  length: S.integer().optional(),
  char: S.list(
    S.string().pattern(/^[\p{sc=Han}\p{sc=Katakana}\p{sc=Hiragana}ー]$/u)
  ),
  repeat: S.integer(),
  repeatx: S.integer(),
  primary: S.boolean().optional()
})

export type IDictElement = typeof sDictElement.type

const smallKana = {
  ぁ: 'あ',
  ぃ: 'い',
  ぅ: 'う',
  ぇ: 'え',
  ぉ: 'お',
  っ: 'つ',
  ゃ: 'や',
  ゅ: 'ゆ',
  ょ: 'よ'
}

const expandMap = Object.entries(smallKana).reduce(
  (prev, [c1, c2]) => ({ ...prev, [c1]: [c1, c2], [c2]: [c1, c2] }),
  {} as Record<string, string[]>
)

export function expandSmall(s: string[]) {
  return s.flatMap((c) => expandMap[c] || [c])
}

export function simplifySmall(s: string[]) {
  return s.map((c) => (smallKana as Record<string, string>)[c] || c)
}

export function simplifyJa(s: string[], noSmall?: boolean) {
  if (noSmall) {
    s = simplifySmall(s)
  }

  return s.map((c) => toHiragana(c))
}
