#!/bin/bash

function checkAndInstallNode() {
  echo "Checking if Node is installed ..."
  if ! command node --version &>/dev/null; then
    echo "Installing Node ..."
    brew install node
    echo "Node has been installed."
    sleep 1
  else
    echo "node $(node --version) has already been installed."
    sleep 1
  fi
}

function checkAndInstallBrew() {
  echo "Checking if brew is installed ..."
  if ! command brew --version &>/dev/null; then
    echo "Installing brew ..."
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
    sleep 1
  else
    echo "brew $(brew --version) has already been installed."
    sleep 1
  fi
}

function installiOSDependencies() {
  echo "Installing iOS Dependencies ..."
  if command brew ls --versions libimobiledevice &>/dev/null; then
    echo "libimobiledevice is installed."
  else
    echo "Installing libimobiledevice ..."
    brew install libimobiledevice --HEAD
  fi
  if command brew ls --versions carthage &>/dev/null; then
    echo "carthage is installed."
  else
    echo "Installing carthage ..."
    brew install carthage
  fi
  if command ios-deploy --version &>/dev/null; then
    echo "ios-deploy $(ios-deploy --version) has already been installed."
  else
    echo "Installing ios-deploy ..."
    npm install -g ios-deploy
  fi
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
  if ! command appium --version &>/dev/null; then
    echo "Installing Appium ..."
    npm install -g appium
  else
    echo "appium $(appium --version) is installed."
  fi
  echo "Installing Barista Agent ..."
  npm install -g barista-agent
}

checkAndInstallBrew
checkAndInstallNode
installiOSDependencies
installAppiumAndBarista
