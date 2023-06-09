#!/usr/bin/env bash

VERSION="0.6.1"
BUILD_DATE="19 November 2021"
AUTHOR="xShin"

function banner() {

  echo -e "
    ┌────────────────────────────────────────────────────────────────┐
    │                    _______                                     │
    │                   (_______)                                    │
    │           ____  _   _ _ _____  ____ ____  _   _ _   _          │
    │          |    \| | | | | ___ |/ ___)    \| | | ( \ / )         │
    │          | | | | |_| | | ____| |   | | | | |_| |) X (          │
    │          |_|_|_|\__  |_|_____)_|   |_|_|_|____/(_/ \_)         │
    │                (____/                                          │
    │                                                                │
    │                  🚀 Version    : ${VERSION}                         │
    │                  📅 Build Date : ${BUILD_DATE}              │
    │                  ⚙️ Author     : ${AUTHOR}                          │
    │                                                                │
    ╰────────────────────────────────────────────────────────────────╯
  "
}
