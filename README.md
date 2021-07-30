# AUDIBLE MODE

## DESCRIPTION
This plugin permitted to check a sound mode of device.
- Native android: [AudioManager]
- Native ios: [Mute] pod plugin


## HOW TO INSTALL
```yaml
dependencies:
  flutter:
    sdk: flutter
  audible_mode: ^1.0.0
```
## HOW TO USE
```dart
AudibleProfile audibleProfile = await Audible.getDeviceMode;
//  AudibleProfile:
//  SILENT_MODE -> iOS/Android,
//  VIBRATE_MODE -> Android,
//  NORMAL_MODE -> iOS/Android,
//  UNDEFINED,
```
## SCREENSHOT
| iOS  |  Android |
| ------------ | ------------ |
|  Iphone 12 Pro(iOS 14.7.1) ![ios](https://raw.githubusercontent.com/andreamainella98/audible_mode/master/screenshoot/ios.gif) |  Oneplus-5T(Android 10) ![android](https://raw.githubusercontent.com/andreamainella98/audible_mode/master/screenshoot/android.gif)|

## FEATURE
- <input type="checkbox" disabled checked /> Detect sound mode
- <input type="checkbox" disabled unchecked /> Stream of sound mode
- <input type="checkbox" disabled unchecked /> Change volume intensity
- <input type="checkbox" disabled unchecked /> Get actual volume intensity


[Mute]: https://cocoapods.org/pods/Mute "Mute"
[AudioManager]: https://developer.android.com/reference/android/media/AudioManager "AudioManager"