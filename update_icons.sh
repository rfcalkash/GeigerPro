#!/bin/bash
mkdir -p android/res/drawable-ldpi/
mkdir -p android/res/drawable-mdpi/
mkdir -p android/res/drawable-hdpi/
mkdir -p android/res/drawable-xhdpi/
mkdir -p android/res/drawable-xxhdpi/
mkdir -p android/res/drawable-xxxhdpi/
rsvg-convert -w 36 -h 36 icon.svg -o android/res/drawable-ldpi/ic_launcher.png
rsvg-convert -w 48 -h 48 icon.svg -o android/res/drawable-mdpi/ic_launcher.png
rsvg-convert -w 72 -h 72 icon.svg -o android/res/drawable-hdpi/ic_launcher.png
rsvg-convert -w 96 -h 96 icon.svg -o android/res/drawable-xhdpi/ic_launcher.png
rsvg-convert -w 144 -h 144 icon.svg -o android/res/drawable-xxhdpi/ic_launcher.png
rsvg-convert -w 192 -h 192 icon.svg -o android/res/drawable-xxxhdpi/ic_launcher.png