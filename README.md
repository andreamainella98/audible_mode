# AUDIBLE MODE

## DESCRIPTION
This plugin permitted to check a sound mode of device.
- Native android: [AudioManager]
- Native ios: [Mute] pod plugin

## PAY ATTENTION
- In the ios simulator it doesn't work

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
|  Iphone 12 Pro(iOS 14.7.1)<br> <img src="https://raw.githubusercontent.com/andreamainella98/audible_mode/master/screenshoot/ios.gif" width="300" height="600"/> |  Oneplus-5T(Android 10)<br> <img src="https://raw.githubusercontent.com/andreamainella98/audible_mode/master/screenshoot/android.gif" width="300" height="600"/>|

## NEXT FEATURE
- [x] Detect sound mode
- [ ] Stream of sound mode
- [ ] Change volume intensity
- [ ] Get actual volume intensity


[Mute]: https://cocoapods.org/pods/Mute "Mute"
[AudioManager]: https://developer.android.com/reference/android/media/AudioManager "AudioManager"
