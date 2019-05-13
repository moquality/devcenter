#!/bin/bash

function checkAndInstallNode() {
  echo "Checking if Node is installed ..."
  if command --version node &>/dev/null; then
    echo "Installing Node ..."
    brew install node
    echo "Node has been installed."
    sleep 1
  else
    echo "$(node --version) has already been installed."
    sleep 1
  fi
}

function checkAndInstallBrew() {
  echo "Checking if brew is installed ..."
  if command --version brew &>/dev/null; then
    echo "Installing brew ..."
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
    sleep 1
  else
    echo "$(brew --version) has already been installed."
    sleep 1
  fi
}

function installiOSDependencies() {
  echo "Installing iOS Dependencies ..."
  brew install libimobiledevice --HEAD
  brew install carthage
  npm install -g ios-deploy
}

function installAndroidDependencies() {
  echo "Installing Android Dependencies ..."
  brew tap caskroom/cask
  brew cask install android-sdk
  sdkmanager "build-tools;27.0.3"
  sdkmanager "platform-tools" "platforms;android-28"
  export ANDROID_HOME=/usr/local/share/android-sdk
}

function installAppiumAndBarista() {
  echo "Installing Appium ..."
  npm install -g appium
  echo "Installing Barista Agent ..."
  npm install -g barista-agent
}

checkAndInstallBrew
checkAndInstallNode
installiOSDependencies
installAppiumAndBarista
