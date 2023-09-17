<script setup lang="ts">
import KeyboardButton from './KeyboardButton.vue'
import { toKana, currentInput, doSubmit, quizEnded } from '../assets/quiz'

defineProps<{
  stats?: boolean
}>()
</script>

<template>
  <div class="Keyboard">
    <form v-if="!stats" class="keyboard-input o-ctrl-input" @submit.prevent="doSubmit()">
      <input
        class="o-input"
        :value="currentInput"
        @input="currentInput = toKana(($event.target as HTMLInputElement).value)"
        placeholder="入力できる"
        :disabled="quizEnded"
      />
    </form>
    <div class="kana-set">
      <div class="kana-row">
        <KeyboardButton value="あ" :stats="stats" />
        <KeyboardButton value="い" :stats="stats" />
        <KeyboardButton value="う" :stats="stats" />
        <KeyboardButton value="え" :stats="stats" />
        <KeyboardButton value="お" :stats="stats" />
      </div>
      <div class="kana-row">
        <KeyboardButton value="か" :stats="stats" />
        <KeyboardButton value="き" :stats="stats" />
        <KeyboardButton value="く" :stats="stats" />
        <KeyboardButton value="け" :stats="stats" />
        <KeyboardButton value="こ" :stats="stats" />
      </div>
      <div class="kana-row">
        <KeyboardButton value="さ" :stats="stats" />
        <KeyboardButton value="し" :stats="stats" />
        <KeyboardButton value="す" :stats="stats" />
        <KeyboardButton value="せ" :stats="stats" />
        <KeyboardButton value="そ" :stats="stats" />
      </div>
      <div class="kana-row">
        <KeyboardButton value="た" :stats="stats" />
        <KeyboardButton value="ち" :stats="stats" />
        <KeyboardButton value="つ" :stats="stats" />
        <KeyboardButton value="て" :stats="stats" />
        <KeyboardButton value="と" :stats="stats" />
      </div>
      <div class="kana-row">
        <KeyboardButton value="な" :stats="stats" />
        <KeyboardButton value="に" :stats="stats" />
        <KeyboardButton value="ぬ" :stats="stats" />
        <KeyboardButton value="ね" :stats="stats" />
        <KeyboardButton value="の" :stats="stats" />
      </div>
      <div class="kana-row">
        <KeyboardButton value="は" :stats="stats" />
        <KeyboardButton value="ひ" :stats="stats" />
        <KeyboardButton value="ふ" :stats="stats" />
        <KeyboardButton value="へ" :stats="stats" />
        <KeyboardButton value="ほ" :stats="stats" />
      </div>
      <div class="kana-row">
        <KeyboardButton value="ま" :stats="stats" />
        <KeyboardButton value="み" :stats="stats" />
        <KeyboardButton value="む" :stats="stats" />
        <KeyboardButton value="め" :stats="stats" />
        <KeyboardButton value="も" :stats="stats" />
      </div>
      <div class="kana-row">
        <KeyboardButton value="や" :stats="stats" />
        <KeyboardButton :stats="stats" />
        <KeyboardButton value="ゆ" :stats="stats" />
        <KeyboardButton :stats="stats" />
        <KeyboardButton value="よ" :stats="stats" />
      </div>
      <div class="kana-row">
        <KeyboardButton value="ら" :stats="stats" />
        <KeyboardButton value="り" :stats="stats" />
        <KeyboardButton value="る" :stats="stats" />
        <KeyboardButton value="れ" :stats="stats" />
        <KeyboardButton value="ろ" :stats="stats" />
      </div>
      <div class="kana-row">
        <KeyboardButton value="わ" :stats="stats" />
        <KeyboardButton value="ゐ" :stats="stats" />
        <KeyboardButton :stats="stats" />
        <KeyboardButton value="ゑ" :stats="stats" />
        <KeyboardButton value="を" :stats="stats" />
      </div>
    </div>
    <div class="kana-set">
      <div class="kana-row">
        <KeyboardButton value="ぁ" :stats="stats" />
        <KeyboardButton value="ぃ" :stats="stats" />
        <KeyboardButton value="ぅ" :stats="stats" />
        <KeyboardButton value="ぇ" :stats="stats" />
        <KeyboardButton value="ぉ" :stats="stats" />
      </div>
      <div class="kana-row">
        <KeyboardButton value="が" :stats="stats" />
        <KeyboardButton value="ぎ" :stats="stats" />
        <KeyboardButton value="ぐ" :stats="stats" />
        <KeyboardButton value="げ" :stats="stats" />
        <KeyboardButton value="ご" :stats="stats" />
      </div>
      <div class="kana-row">
        <KeyboardButton value="ざ" :stats="stats" />
        <KeyboardButton value="じ" :stats="stats" />
        <KeyboardButton value="ず" :stats="stats" />
        <KeyboardButton value="ぜ" :stats="stats" />
        <KeyboardButton value="ぞ" :stats="stats" />
      </div>
      <div class="kana-row">
        <KeyboardButton value="だ" :stats="stats" />
        <KeyboardButton value="ぢ" :stats="stats" />
        <KeyboardButton value="づ" :stats="stats" />
        <KeyboardButton value="で" :stats="stats" />
        <KeyboardButton value="ど" :stats="stats" />
      </div>
      <div class="kana-row">
        <KeyboardButton :stats="stats" />
        <KeyboardButton :stats="stats" />
        <KeyboardButton value="っ" :stats="stats" />
        <KeyboardButton :stats="stats" />
        <KeyboardButton :stats="stats" />
      </div>
      <div class="kana-row">
        <KeyboardButton value="ば" :stats="stats" />
        <KeyboardButton value="び" :stats="stats" />
        <KeyboardButton value="ぶ" :stats="stats" />
        <KeyboardButton value="べ" :stats="stats" />
        <KeyboardButton value="ぼ" :stats="stats" />
      </div>
      <div class="kana-row">
        <KeyboardButton value="ぱ" :stats="stats" />
        <KeyboardButton value="ぴ" :stats="stats" />
        <KeyboardButton value="ぷ" :stats="stats" />
        <KeyboardButton value="ぺ" :stats="stats" />
        <KeyboardButton value="ぽ" :stats="stats" />
      </div>
      <div class="kana-row">
        <KeyboardButton value="ゃ" :stats="stats" />
        <KeyboardButton :stats="stats" />
        <KeyboardButton value="ゅ" :stats="stats" />
        <KeyboardButton :stats="stats" />
        <KeyboardButton value="ょ" :stats="stats" />
      </div>
      <div class="kana-row">
        <KeyboardButton value="ん" :stats="stats" />
        <KeyboardButton :stats="stats" />
        <KeyboardButton value="ー" :stats="stats" />
        <KeyboardButton :stats="stats" />
        <KeyboardButton value="ゔ" :stats="stats" />
      </div>
      <div class="kana-row">
        <KeyboardButton :stats="stats" />
        <KeyboardButton :stats="stats" />
        <KeyboardButton :stats="stats" />
        <KeyboardButton icon="backspace" action="backspace" :stats="stats" />
        <KeyboardButton icon="check-circle" action="submit" :stats="stats" />
      </div>
    </div>
  </div>
</template>

<style scoped>
.Keyboard {
  display: flex;
  flex-direction: column;
  width: 100%;
  padding-bottom: 1em;
}

.kana-set {
  display: flex;
  flex-direction: row-reverse;
}

.kana-row {
  display: flex;
  flex-direction: column;
  flex: 1 1 0;
}

.keyboard-input {
  margin-bottom: 1em;
}

.keyboard-input input {
  text-align: center;
  font-size: 24px;
}

.keyboard-input input:disabled {
  background-color: lightgray;
}
</style>