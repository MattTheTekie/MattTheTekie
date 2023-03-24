<script setup lang="ts">
import { nextTick, ref, watch } from 'vue';
import { isKana } from 'wanakana';
import { setBgColor, currentInput, guessedWords, toKana, wordLength, quizEnded } from '../assets/quiz'

const elRoot = ref<HTMLDivElement>()

watch(guessedWords, () => {
  nextTick(() => {
    const el = elRoot.value!
    el.scrollTop = el.scrollHeight
  })
})

const fontSize = ref(20)

function setCharFontSize() {
  if (wordLength.value < 5) {
    fontSize.value = 70
  } else if (wordLength.value < 9) {
    fontSize.value = 50
  } else {
    fontSize.value = 35
  }

  const factor = screen.width > 900 ? 1.6 : screen.width > 600 ? 1.3 : 1
  fontSize.value = factor * fontSize.value
}

setCharFontSize()

addEventListener('resize', () => {
  setCharFontSize()
})

watch(wordLength, () => {
  setCharFontSize()
})

const colorMap: Record<number, string> = {
  1: 'gray', // gray
  2: '#fee440', // yellow
  3: '#70e000', // green
}

const currentOutput = ref(Array(wordLength.value).fill(' ').join(''))

watch(currentInput, () => {
  const v = toKana(currentInput.value, { immediate: true }).split('').map((c) => isKana(c) ? c : '').join('')
  currentOutput.value = v + Array(wordLength.value - v.length).fill(' ').join('')
})
</script>

<template>
  <div :ref="(el) => { elRoot = el as HTMLDivElement }" class="TileView">
    <div class="tile-row" v-for="(w, i) in guessedWords" :key="i">
      <div
        class="tile-char"
        v-for="(c, j) in toKana(w)"
        :key="j"
        :style="{ 'font-size': `${fontSize}px`, height: `${fontSize * 1.2}px`, width: `${fontSize * 1.2}px`, 'background-color': colorMap[setBgColor(c, j)] || 'gray' }"
      >
        <div>{{ c }}</div>
      </div>
    </div>
    <div v-if="!quizEnded" class="tile-row">
      <div
        class="tile-char"
        v-for="(c, j) in currentOutput"
        :key="j"
        :style="{ 'font-size': `${fontSize}px`, height: `${fontSize * 1.2}px`, width: `${fontSize * 1.2}px`, 'background-color': 'lightgray' }"
      >
        <div>{{ c }}</div>
      </div>
    </div>
  </div>
</template>

<style scoped>
.TileView {
  width: 100%;
  padding-top: 20px;
  margin-bottom: 20px;
  overflow: auto;
}

.tile-row {
  margin: 0 auto;
  width: fit-content;
  display: flex;
  flex-direction: row;
}

.tile-char {
  display: flex;
  justify-content: center;
  align-items: center;
  border: 3px solid white;
}
</style>