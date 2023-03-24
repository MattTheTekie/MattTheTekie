<script setup lang="ts">
import Keyboard from './components/Keyboard.vue'
import SettingsView from './components/SettingsView.vue'
import ResultsView from './components/ResultsView.vue';
import { markRaw, ref, watch } from 'vue'
import { guessLimit, quizEnded } from './assets/quiz'
import TileView from './components/TileView.vue';

const isModalOpen = ref(false)
const modalName = ref<keyof typeof modalLookup>('SettingsView')
const modalComponent = ref<any>(null)

const modalLookup = {
  SettingsView,
  ResultsView
}

function changeModal(m: keyof typeof modalLookup) {
  modalName.value = m
  modalComponent.value = markRaw(modalLookup[m])
  isModalOpen.value = true
}

watch(isModalOpen, (v) => {
  if (!v && modalName.value === 'SettingsView') {
    console.log(guessLimit.value)
  }
})

watch(quizEnded, (r) => {
  if (r) {
    changeModal('ResultsView')
  }
})
</script>

<template>
  <nav>
    <div class="header">
      <h1>きれない言葉</h1>
    </div>
    <div style="flex-grow: 1"></div>
    <o-button icon-left="question" variant="outlined" rounded @click="changeModal('SettingsView')"></o-button>
    <o-button style="width: 2.5em" variant="outlined" rounded @click="changeModal('ResultsView')">
      <svg
        class="custom-svg"
        style="margin-top: 0.2em"
        width="1.5em"
        height="1.5em"
        viewBox="0 0 48 48"
        fill="none"
        xmlns="http://www.w3.org/2000/svg"
        data-source="https://www.svgrepo.com/svg/388373/ranking"
      >
        <rect width="48" height="48" fill="white" fill-opacity="0.01" />
        <rect
          x="4"
          y="18"
          width="13"
          height="24"
          stroke="#445e00"
          stroke-width="4"
          stroke-linecap="round"
          stroke-linejoin="round"
        />
        <rect
          x="17"
          y="6"
          width="13"
          height="36"
          stroke="#445e00"
          stroke-width="4"
          stroke-linejoin="round"
        />
        <rect
          x="30"
          y="26"
          width="13"
          height="16"
          stroke="#445e00"
          stroke-width="4"
          stroke-linecap="round"
          stroke-linejoin="round"
        />
      </svg>
    </o-button>
    <o-button icon-left="cog" variant="outlined" rounded @click="changeModal('SettingsView')"></o-button>
  </nav>
  <main>
    <TileView />
    <Keyboard />
  </main>
  <o-modal v-model:active="isModalOpen">
    <component :is="modalComponent" @submit="isModalOpen = false" @close="isModalOpen = false" />
  </o-modal>
</template>

<style scoped>
nav {
  background-color: rgb(238, 178, 144);
  display: flex;
  flex-direction: row;
  align-items: center;
}

nav > * {
  margin-left: 1em;
}

nav > :last-child {
  margin-right: 1em;
}

nav h1 {
  word-break: keep-all;
}

main {
  width: 100%;
  max-width: 1000px;
  height: calc(100vh - 50px);
  margin: 0 auto;
  display: grid;
  grid-template-rows: 1fr auto;
  position: relative;
}

.header h1 {
  margin: 0;
}

.o-btn:hover .custom-svg {
  filter: brightness(0) invert(1);
}
</style>
