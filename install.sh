#!/bin/bash
files=("teensy-x86-stubs"
"teensy-x86-spi-stubs"
"teensy-x86-sd-stubs"
"teensy-x86-twowire-stubs"
"teensy-audio-x86-stubs/src"
"teensy-audio-x86-stubs/extras/soundio"
"teensy-variable-playback/src"
"teensy-sample-flashloader"
"teensy-x86-keypad-stubs"
"teensy-x86-midi-stubs"
"teensy-x86-mpr121-stubs"
"teensy-x86-responsiveanalogread-stubs"
"teensy-x86-time-stubs"
"teensy-x86-tlc5947-stubs"
"teensy-x86-u8g2-stubs"
"teensy-x86-u8g2-stubs/extras/opengl"
"teensy-x86-uClock-stubs"
 )

cd dependencies || exit
baseDir=$(pwd)
for file in "${files[@]}"
do
  cd $file || (echo '!!!!!' & exit)
  echo "entering: $file"
    if [[ ! -d "cmake-build-debug" ]]; then
         echo "Cant find cmake-build-debug"
         exit 2
    fi
  cd cmake-build-debug
  cmake --build .
  es1=$?
  if ! (( es1 == 0 )); then
      echo "First: failure! (es1 = $es1)"
      exit 2
  fi
  #sudo cmake --install .

  cd $baseDir || exit
done