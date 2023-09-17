<script setup lang="ts">
import { NotificationProgrammatic } from '@oruga-ui/oruga-next';
import { ref } from 'vue';
import { quizEnded, currentWordOriginal, frequentlyGuessedWords, numberOfAttempts } from '../assets/quiz'
import Keyboard from './Keyboard.vue'

defineEmits(['close'])

const isShownKeyboardHeatmap = ref(true)
const isShownFrequentlyGuessedWords = ref(true)
const isShownNumberOfAttempts = ref(true)

function doShare() {
  NotificationProgrammatic.open({
    message: 'Quiz report copied to the clipboard',
    rootClass: 'toast-notification',
    position: 'top',
    duration: 4000
  })
}
</script>

<template>
  <div class="ResultsView">
    <h1>Summary</h1>

    <section>
      <div class="flex-row" v-if="quizEnded">
        <span>
          The answer is
          <a
            class="correct-word"
            :href="'https://jisho.org/search/' + currentWordOriginal"
            target="_blank"
            rel="noopener noreferrer"
          >{{ currentWordOriginal }}</a>.
        </span>
        <div style="flex-grow: 1"></div>
        <o-button icon-right="share" @click="doShare()">Share</o-button>
      </div>
    </section>

    <section>
      <h3>
        Keyboard heatmap
        <o-button
          :icon-right="isShownKeyboardHeatmap ? 'caret-down' : 'caret-up'"
          @click="isShownKeyboardHeatmap = !isShownKeyboardHeatmap"
        ></o-button>
      </h3>
      <Keyboard v-if="isShownKeyboardHeatmap" stats style="max-width: 500px; margin: 0 auto" />
    </section>

    <section>
      <h3>
        Frequently guessed words
        <o-button
          :icon-right="isShownFrequentlyGuessedWords ? 'caret-down' : 'caret-up'"
          @click="isShownFrequentlyGuessedWords = !isShownFrequentlyGuessedWords"
        ></o-button>
      </h3>
      <section v-if="isShownFrequentlyGuessedWords">
        <section v-if="frequentlyGuessedWords.length"></section>
        <section v-else>Frequently guessed words will be shown here.</section>
      </section>
    </section>

    <section>
      <h3>
        Number of attempts to win
        <o-button
          :icon-right="isShownNumberOfAttempts ? 'caret-down' : 'caret-up'"
          @click="isShownNumberOfAttempts = !isShownNumberOfAttempts"
        ></o-button>
      </h3>
      <section v-if="isShownNumberOfAttempts">
        <section v-if="numberOfAttempts.length"></section>
        <section v-else>Your track record will be shown here.</section>
      </section>
    </section>

    <div class="button-area flex-row">
      <div style="flex-grow: 1"></div>
      <o-button variant="danger" @click="$emit('close')">Close</o-button>
    </div>
  </div>
</template>

<style scoped>
.ResultsView {
  width: 600px;
  max-width: 95vw;
  overflow: auto;
}

section {
  width: 100%;
}

h3 > .o-btn {
  margin-right: 1em;
}
</style>