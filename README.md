
Devcenter
==========

## Quick Setup

```
sh -c "$(curl -fsSL https://raw.githubusercontent.com/moquality/devcenter/master/install.sh)"
```

## Manual Setup

#### brew and node

On MacOS, we rely on [HomeBrew](https://brew.sh/) and [Node](https://nodejs.org/en/) to install dependencies. Install Homebrew with

```
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
```

After installing brew, you can install Node with

```
brew install node
```

**Note:** At no point during this installation process you need to use superuser priviliges. If any step in this setup requires you to do so, you probably need to fix your file permissions before continuing.

#### Barista

Barista is a low code test creating tool that MoQuality has built to help you to create tests easily. To install Barista

```
npm install -g barista-agent
```

The rest of the setup is needed for **Appium** to work with either Android or iOS devices.

#### Appium for Android

If you want to setup for Android, you only need to install the Android SDK and setup `ANDROID_HOME`. The easiest way to do this is to use brew

```
brew tap caskroom/cask
brew cask install android-sdk
```

Then install the required sdk tools like `adb` and `aapt` using
```
sdkmanager "build-tools;27.0.3"
sdkmanager "platform-tools" "platforms;android-28"
```

Setup `ANDROID_HOME` using
```
export ANDROID_HOME=/usr/local/share/android-sdk
```

#### Appium for iOS

If you want to setup for iOS, you need to install `libimobiledevice` to do "certain things" [[1](https://github.com/appium/appium-xcuitest-driver)]

```
brew install libimobiledevice --HEAD  # install from HEAD to get important updates
```

There is also a dependency, made necessary by Facebook's WebDriverAgent, for the Carthage dependency manager. If you do not have Carthage on your system, it can also be installed with Homebrew

```
brew install carthage
```

iOS 10 needs `ios-deploy` to interact with the device

```
npm install -g ios-deploy
```


## References

1: https://github.com/appium/appium-xcuitest-driver