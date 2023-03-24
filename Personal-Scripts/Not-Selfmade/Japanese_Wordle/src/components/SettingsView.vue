<script setup lang="ts">
import { NotificationProgrammatic } from '@oruga-ui/oruga-next';
import { onMounted, ref, watch, } from 'vue'
import {
  isSmallKana, katakanaMode, filter,
  guessLimit, guessLimitMin, guessLimitDefault,
  wordLength, wordLengthMin, wordLengthDefault,
  minWords, minWordsMin, minWordsDefault,
  rawSource, isRaw, rawSourceDefault
} from '../assets/quiz'

const emit = defineEmits(['submit', 'close'])

const rawTmp = ref('')
const isRawTmp = ref(false)
const filterTmp = ref('')

function initRaw() {
  rawTmp.value = rawSource.value
  isRawTmp.value = isRaw.value
  filterTmp.value = filter.value
}

function updateRaw() {
  rawTmp.value = isRawTmp.value ? '' : rawSourceDefault
  filterTmp.value = (!isRawTmp.value && rawTmp.value === rawSourceDefault) ? 'N5 or N4 or N3' : ''
}

async function setRaw(): Promise<string> {
  rawSource.value = rawTmp.value
  isRaw.value = isRawTmp.value
  filter.value = filterTmp.value

  return ''
}

watch(isRaw, () => {
  updateRaw()
})

const wordLengthText = ref(wordLength.value.toString())
const wordLengthErrorMessage = ref('')
const wordLengthErrorMessageDefault = `Please enter a number of at least ${wordLengthMin}.`
const wordLengthTmp = ref(wordLength.value)

function initWordLength() {
  wordLengthText.value = wordLength.value.toString()
  wordLengthErrorMessage.value = ''
  wordLengthTmp.value = wordLength.value
}

function updateWordLength() {
  wordLengthErrorMessage.value = ''

  if (!wordLengthText.value) {
    wordLengthErrorMessage.value = wordLengthErrorMessageDefault
    return
  }

  if (!/^\d{1,2}$/.test(wordLengthText.value)) {
    wordLengthErrorMessage.value = wordLengthErrorMessageDefault
    return
  }

  const n = Number(wordLengthText.value)
  if (n < wordLengthMin) {
    wordLengthErrorMessage.value = wordLengthErrorMessageDefault
    return
  }

  wordLengthTmp.value = n
}

function setWordLength() {
  wordLength.value = wordLengthTmp.value
}

watch(wordLengthText, () => {
  updateWordLength()
})

const minWordsText = ref(minWords.value.toString())
const minWordsErrorMessage = ref('')
const minWordsErrorMessageDefault = `Please enter a number of at least ${minWordsMin}.`
const minWordsTmp = ref(minWords.value)

function initMinWords() {
  minWordsText.value = minWords.value.toString()
  minWordsErrorMessage.value = ''
  minWordsTmp.value = minWords.value
}

function updateMinWords() {
  minWordsErrorMessage.value = ''

  if (!minWordsText.value) {
    minWordsErrorMessage.value = minWordsErrorMessageDefault
    return
  }

  if (!/^\d+$/.test(minWordsText.value)) {
    minWordsErrorMessage.value = minWordsErrorMessageDefault
    return
  }

  const n = Number(minWordsText.value)
  if (n < minWordsMin) {
    minWordsErrorMessage.value = minWordsErrorMessageDefault
    return
  }

  minWordsTmp.value = n
}

function setMinWords() {
  minWords.value = minWordsTmp.value
}

watch(minWordsText, () => {
  updateMinWords()
})

const guessLimitText = ref((guessLimit.value || '').toString())
const guessLimitErrorMessage = ref('')
const guessLimitErrorMessageDefault = `Please enter a number of at least ${guessLimitMin}.`
const guessLimitTmp = ref(guessLimit.value)

function initGuessLimit() {
  guessLimitText.value = (guessLimit.value || '').toString()
  guessLimitTmp.value = guessLimit.value
}

function updateGuessLimit() {
  guessLimitErrorMessage.value = ''

  if (!guessLimitText.value) {
    guessLimit.value = 0
    return
  }

  if (!/^\d{1,2}$/.test(guessLimitText.value)) {
    guessLimitErrorMessage.value = guessLimitErrorMessageDefault
    return
  }

  const n = Number(guessLimitText.value)
  if (n < guessLimitMin) {
    guessLimitErrorMessage.value = guessLimitErrorMessageDefault
    return
  }

  guessLimitTmp.value = n
}

function setGuessLimit() {
  guessLimit.value = guessLimitTmp.value
}

watch(guessLimitText, () => {
  updateGuessLimit()
})

async function doSubmit() {
  const errorMessage = wordLengthErrorMessage.value || minWordsErrorMessage.value || guessLimitErrorMessage.value || (await setRaw())

  if (errorMessage) {
    NotificationProgrammatic.open({
      message: errorMessage,
      rootClass: 'toast-notification',
      position: 'top',
      duration: 4000
    })
    return
  }

  setWordLength()
  setMinWords()
  setGuessLimit()

  emit('submit')
}

onMounted(() => {
  initRaw()
  initGuessLimit()
  initMinWords()
  initWordLength()
})
</script>

<template>
  <div class="SettingsView">
    <h1>Settings</h1>

    <section>
      <o-field>
        <o-switch v-model="isSmallKana">Include small Kana</o-switch>
      </o-field>
      <o-field>
        <o-switch v-model="katakanaMode">Katakana mode</o-switch>
      </o-field>
      <o-field>
        <template v-slot:label>
          Word length
          <o-tooltip
            append-to-body
            multiline
            :auto-close="['inside']"
            label="Number of Kana in guessed words"
          >
            <o-icon size="small" icon="question-circle"></o-icon>
          </o-tooltip>
        </template>
        <o-input
          v-model="wordLengthText"
          type="number"
          pattern="[0-9]{,2}"
          :min="wordLengthMin"
          expanded
        ></o-input>
        <o-button
          icon-right="undo-alt"
          @click="wordLengthText = wordLengthDefault.toString()"
          :variant="wordLengthText === wordLengthDefault.toString() ? 'disabled' : 'warning'"
        ></o-button>
      </o-field>
      <o-field>
        <template v-slot:label>
          Mininum number of words in list
          <o-tooltip
            append-to-body
            multiline
            :auto-close="['inside']"
            label="Minimum number of words in list, for the specified word length to work"
          >
            <o-icon size="small" icon="question-circle"></o-icon>
          </o-tooltip>
        </template>
        <o-input v-model="minWordsText" type="number" pattern="[0-9]+" :min="minWordsMin" expanded></o-input>
        <o-button
          icon-right="undo-alt"
          @click="minWordsText = minWordsDefault.toString()"
          :variant="minWordsText === minWordsDefault.toString() ? 'disabled' : 'warning'"
        ></o-button>
      </o-field>
      <o-field :variant="guessLimitErrorMessage ? 'danger' : ''" :message="guessLimitErrorMessage">
        <template v-slot:label>
          Guess limit
          <o-tooltip
            append-to-body
            multiline
            :auto-close="['inside']"
            label="Number of times you can guess. Leave it empty for unlimited tries."
          >
            <o-icon size="small" icon="question-circle"></o-icon>
          </o-tooltip>
        </template>
        <o-input
          v-model="guessLimitText"
          type="number"
          pattern="[0-9]{,2}"
          :min="guessLimitMin"
          expanded
        ></o-input>
        <o-button
          icon-right="undo-alt"
          @click="guessLimitText = guessLimitDefault.toString()"
          :variant="guessLimitText === guessLimitDefault.toString() ? 'disabled' : 'warning'"
        ></o-button>
      </o-field>
    </section>

    <section>
      <h3>Vocabulary list</h3>

      <o-field>
        <o-switch v-model="isRaw">
          Raw (See
          <a
            :href="rawSourceDefault"
            target="_blank"
            rel="noopener noreferrer"
          >{{ rawSourceDefault }}</a>
          for the format)
        </o-switch>
      </o-field>

      <o-field>
        <o-input
          v-model="rawTmp"
          :placeholder="isRaw ? '' : rawSourceDefault"
          :type="isRaw ? 'textarea' : 'text'"
          expanded
        ></o-input>
        <o-button
          icon-right="undo-alt"
          @click="isRaw = false; rawTmp = rawSourceDefault"
          :variant="rawTmp === rawSource ? 'disabled' : 'warning'"
        ></o-button>
      </o-field>
      <o-field>
        <template v-slot:label>
          Filter
          <o-tooltip
            append-to-body
            multiline
            :auto-close="['inside']"
            label="Filter down vocabulary list, powered by SQLite FTS5"
          >
            <o-icon size="small" icon="question-circle"></o-icon>
          </o-tooltip>
        </template>
        <o-input v-model="filter" type="search"></o-input>
      </o-field>
    </section>

    <div class="button-area flex-row">
      <div style="flex-grow: 1"></div>
      <o-button @click="doSubmit">Update</o-button>
      <o-button variant="danger" @click="$emit('close')">Close</o-button>
    </div>
  </div>
</template>

<style scoped>
.SettingsView {
  width: 600px;
  max-width: 95vw;
  overflow: auto;
}

section + section {
  margin-bottom: 50px;
}

.button-area .o-btn + .o-btn {
  margin-left: 0.5em;
}
</style>