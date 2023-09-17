<script setup lang="ts">
import { watch, ref } from "vue"
import { currentInput, doSubmit, isObsolete, isSmallKana, obsolete, smallKana, toKana, bgColor, guessedWords, quizEnded } from "../assets/quiz"

const props = defineProps<{
  value?: string
  icon?: string
  action?: 'submit' | 'backspace'
  stats?: boolean
}>()

const status = ref('')

function setVisibility() {
  if (!props.value && !props.icon) {
    status.value = ''
    return
  }

  if (props.value) {
    if (!isSmallKana.value && (smallKana as any)[props.value]) {
      status.value = ''
      return
    }

    if (!isObsolete.value && (obsolete as any)[props.value]) {
      status.value = ''
      return
    }
  }

  status.value = 'available'
}

watch([isSmallKana, isObsolete], () => {
  setVisibility()
})


setVisibility()

function onClick() {
  if (props.stats) return
  if (quizEnded.value) return

  if (props.action === 'submit') {
    doSubmit()
  } else if (props.action === 'backspace') {
    currentInput.value = currentInput.value.substring(0, currentInput.value.length - 1)
  } else if (props.value) {
    currentInput.value += toKana(props.value)
  }
}

const colorMap: Record<number, string> = {
  1: 'gray', // gray
  2: '#fee440', // yellow
  3: '#70e000', // green
}

const currentColor = ref('')
function setColor() {
  currentColor.value = props.value ? colorMap[bgColor.value[toKana(props.value)]] || '' : ''
}

watch(bgColor, () => {
  setColor()
})

setColor()
</script>

<template>
  <button
    class="KeyboardButton"
    type="button"
    :style="{ visibility: (status && !(icon && stats)) ? 'visible' : 'hidden', 'background-color': currentColor }"
    :key="guessedWords.length"
    @click="onClick()"
    :disabled="stats || quizEnded"
  >
    <FontAwesomeIcon class="kana" v-if="icon && !stats" :icon="icon" />
    <div v-else-if="value" :class="{ kana: true, stats }">{{ toKana(value) }}</div>
  </button>
</template>

<style scoped>
.KeyboardButton {
  flex: 1 1 0;
  min-width: 1em;
  width: 100%;
  display: flex;
  position: relative;
  justify-content: center;
  align-items: center;
}

.kana {
  width: 1em;
  height: 1em;
  margin: 0.5em;
  font-size: 12px;
}

@media screen and (min-width: 600px) {
  .kana {
    font-size: 16px;
  }
}

@media screen and (min-width: 900px) {
  .kana {
    font-size: 20px;
  }
}

.kana.stats {
  font-size: 12px;
}
</style>