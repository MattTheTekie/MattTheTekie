import { ref, watch } from 'vue'
import { WanakanaOptions, isKana, toHiragana, toKatakana } from 'wanakana'

export const availableWords = ref<string[]>([])
export const currentWordOriginal = ref('あいづち')
export const currentWord = ref('あいづち')
export const currentInput = ref('')
export const quizEnded = ref(false)
export const heatMap = ref<Record<string, number>>({})
export const frequentlyGuessedWords = ref<
  {
    word: string
    count: number
  }[]
>([])
export const numberOfAttempts = ref<
  {
    attempts: number
    count: number
  }[]
>([])

export const rawSourceDefault = location.origin + '/JLPT.txt'
export const rawSource = ref(rawSourceDefault)
export const isRawDefault = false
export const isRaw = ref(isRawDefault)

export const wordLengthDefault = 4
export const wordLength = ref(wordLengthDefault)
export const wordLengthMin = 3

export const guessLimitDefault = 8
export const guessLimit = ref(guessLimitDefault)
export const guessLimitMin = 4

export const minWordsDefault = 50
export const minWords = ref(minWordsDefault)
export const minWordsMin = 50

export const filter = ref('')

export const guessedWords = ref<string[]>([])

export const smallKana = {
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
export const isSmallKana = ref(false)

export const obsolete = {
  ゐ: 'い',
  ゑ: 'え'
}
export const isObsolete = ref(false)

export const katakanaMode = ref(false)

watch([isSmallKana, isObsolete, katakanaMode], () => {
  currentWord.value = toKana(currentWord.value)
})

watch(
  [wordLength, guessLimit, filter, isSmallKana, isObsolete, katakanaMode],
  () => {
    guessedWords.value = []
    quizEnded.value = false
  }
)

export function toKana(
  v: string,
  additionalOpts: {
    immediate?: boolean
    hiragana?: boolean
  } = {}
) {
  const opts: WanakanaOptions = {
    useObsoleteKana: isObsolete.value,
    IMEMode: !additionalOpts.immediate
  }
  return !additionalOpts.hiragana && katakanaMode.value
    ? toKatakana(v, opts)
    : toHiragana(v, opts)
}

export function doSubmit() {
  if (guessLimit.value > 0 && guessedWords.value.length >= guessLimit.value) {
    return
  }

  currentInput.value = toKana(currentInput.value, {
    immediate: true,
    hiragana: true
  })

  if (
    isKana(currentInput.value) &&
    currentInput.value.length === wordLength.value
  ) {
    if (!isSmallKana.value) {
      currentInput.value = currentInput.value
        .split('')
        .map((c) => (smallKana as any)[c] || c)
        .join('')
    }

    if (!isObsolete.value) {
      currentInput.value = currentInput.value
        .split('')
        .map((c) => (obsolete as any)[c] || c)
        .join('')
    }

    guessedWords.value = [...guessedWords.value, toKana(currentInput.value)]
    currentInput.value = ''

    if (
      guessLimit.value > 0 &&
      guessedWords.value.length === guessLimit.value
    ) {
      quizEnded.value = true
    }
  }
}

const charPosition = ref<Record<string, number>>({})

function setCharPosition() {
  charPosition.value = currentWord.value
    .split('')
    .reduceRight((prev, c, i) => ({ ...prev, [c]: i }), {})
}

watch(currentWord, () => {
  setCharPosition()
})

setCharPosition()

export const bgColor = ref<Record<string, number>>({})

export function setBgColor(c: string, i0: number) {
  const map = bgColor.value
  const i = charPosition.value[c]

  let newVal = 0
  if (typeof i === 'undefined') {
    newVal = 1 // not found
  } else {
    newVal = i === i0 ? 3 : 2
  }

  if (newVal > (map[c] || 0)) {
    map[c] = newVal
    bgColor.value = JSON.parse(JSON.stringify(map))
  }

  return newVal
}
