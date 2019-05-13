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
  if [[ -z "${ANDROID_HOME}" ]]; then
    echo "$ANDROID_HOME is not set"
    echo -n "Do you want to install Android SDK (y/n)? "
    read answer
    if [ "$answer" != "${answer#[Yy]}" ] ;then
      brew tap caskroom/cask
      brew cask install android-sdk
      echo "Add export ANDROID_HOME=/usr/local/share/android-sdk to you shell"
    else
      echo "You need Android SDK to continue"
    fi

  else
    ADB="$(find $ANDROID_HOME -name adb)"
    AAPT="$(find $ANDROID_HOME -name aapt)"

    if [[ -z "$ADB" ]]; then
      SDKMANAGER="$(find $ANDROID_HOME -name sdkmanager)"
      if [[ -z "$SDKMANAGER" ]]; then
        echo "Cannot find sdkmanager. Install adb. [ERROR]"
      else
        echo "Installing platform-tools ..."
        ($SDKMANAGER "platform-tools")
        ADB="$(find $ANDROID_HOME -name adb)"
        echo "adb is in $ADB"
      fi
    else
      echo "Found adb"
    fi

    if [[ -z "$AAPT" ]]; then
      SDKMANAGER="$(find $ANDROID_HOME -name sdkmanager)"
      if [[ -z "$SDKMANAGER" ]]; then
        echo "Cannot find sdkmanager. Install aapt. [ERROR]"
      else
        echo "Installing build-tools ..."
        ($SDKMANAGER "build-tools;28.0.3")
        AAPT="$(find $ANDROID_HOME -name aapt)"
        echo "aapt is in $AAPT"
      fi
    else
      echo "Found aapt"
    fi

  fi
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

function findWDA() {
  APPIUMPATH="$(which appium)"
  APPIUMDIR="$(echo $APPIUMPATH | sed -e "s/\/bin\/appium//g" )"
  WDAPATH="$(find $APPIUMDIR -name WebDriverAgent.xcodeproj)"
  echo "WebDriverAgent is at $WDAPATH"
  echo -n "Do you want to open WebDriverAgent in Xcode (y/n)? "
  read answer
  if [ "$answer" != "${answer#[Yy]}" ] ;then
    open $WDAPATH
  fi
}

checkAndInstallBrew
checkAndInstallNode
installiOSDependencies
installAppiumAndBarista
findWDA
