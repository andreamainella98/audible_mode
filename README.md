<div align="center">
    <img src="https://raw.githubusercontent.com/andreamainella98/audible_mode/master/images/icon.png">
</div>

## DESCRIPTION
This plugin lets you know when the Android or iOS device changes its audio profile and lets you know some more information about it.
This plugin use this dependecy:
- Native android: [AudioManager]
- Native ios: [Mute] pod plugin

## PAY ATTENTION
- In the ios simulator it doesn't work

## HOW TO INSTALL
```yaml
dependencies:
  flutter:
    sdk: flutter
  audible_mode: ^1.0.1
```
## HOW TO USE

### Get stream audible profile
```dart
StreamBuilder<AudibleProfile?>(
  initialData: AudibleProfile.UNDEFINED,
  stream: Audible.audibleStream,
  ...
```
### Get current audible profile
```dart
Audible.getAudibleProfile
```
### Get current volume
```dart
Audible.getCurrentVolume
```
### Set volume
```dart
/// In Android you can put a value from 0.0 to max volume returned from plugin (use Audible.getMaxVolume)
/// In iOS you can put a value from 0.0 to 1.0
Audible.setVolume(0.2)
```
## SCREENSHOT

| iOS (Iphone 12 Pro - 15.2)                                                                                   | Android (Oneplus 5T - Pixel Experience 11)                                                                       |
|--------------------------------------------------------------------------------------------------------------|------------------------------------------------------------------------------------------------------------------|
| <img src="https://raw.githubusercontent.com/andreamainella98/audible_mode/master/images/ios.gif" width=300/> | <img src="https://raw.githubusercontent.com/andreamainella98/audible_mode/master/images/android.gif" width=300/> |

## NEXT FEATURE

|      Feature       | Dscription                  |
|:------------------:|-----------------------------|
| :white_check_mark: | Detect sound mode           |
| :white_check_mark: | Stream of AudioProfile      |
| :white_check_mark: | Change volume intensity     |
| :white_check_mark: | Get actual volume intensity |


Write me in the [GitHub](https://github.com/andreamainella98/audible_mode/issues) issues the new features you need and, if they are approved of course, I will implement them as soon as I can.


[Mute]: https://cocoapods.org/pods/Mute "Mute"
[AudioManager]: https://developer.android.com/reference/android/media/AudioManager "AudioManager"
