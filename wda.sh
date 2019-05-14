APPIUMPATH="$(which appium)"
APPIUMDIR="$(echo $APPIUMPATH | sed -e "s/\/bin\/appium//g" )"
WDAPATH="$(find $APPIUMDIR -name WebDriverAgent.xcodeproj)"
open $WDAPATH
