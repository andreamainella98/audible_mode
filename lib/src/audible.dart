import 'package:audible_mode/src/utils/audible_profile.dart';
import 'package:audible_mode/src/utils/constants.dart';
import 'package:enum_to_string/enum_to_string.dart';
import 'package:flutter/services.dart';

/// Audible is a helper class that is used to be able to call the
/// various methods within it, without having to declare a special variable.
class Audible {
  static const MethodChannel _channel = MethodChannel(Constants.METHOD_CHANNEL);
  static const EventChannel _currentProfileEvent =
      EventChannel(Constants.CURRENT_PROFILE_EVENT);
  static const EventChannel _currentVolumeEvent =
      EventChannel(Constants.CURRENT_VOLUME_EVENT);

  /// This method allows you to get the AudibleProfile without having to create a stream
  static Future<AudibleProfile?> get getAudibleProfile async {
    String temp = await _channel.invokeMethod(Constants.GET_AUDIBLE_PROFILE);
    return EnumToString.fromString<AudibleProfile>(AudibleProfile.values, temp);
  }

  /// This method lets you know the volume level of the system
  static Future<double> get getCurrentVolume async {
    double temp = await _channel.invokeMethod(Constants.GET_CURRENT_VOLUME);
    return double.parse(temp.toStringAsFixed(1));
  }

  /// This method lets you know the max volume level of the system
  /// Android -> Android max Volume
  /// iOS -> 1.0
  static Future<double> get getMaxVolume async {
    double temp = await _channel.invokeMethod(Constants.GET_MAX_VOLUME);
    return double.parse(temp.toStringAsFixed(1));
  }

  /// This method allows you to set a value for the system volume
  /// In Android you can put a value from 0.0 to Android max Volume
  /// In iOS you can put a value from 0.0 to 1.0
  static Future<bool> setVolume(double volume) async {
    return await _channel
        .invokeMethod(Constants.SET_VOLUME, {'volume': volume});
  }

  /// This method allows you to have a stream of the system audio profile change
  static Stream<AudibleProfile?> get currentProfileStream {
    return _currentProfileEvent.receiveBroadcastStream().distinct().map(
        (dynamic event) => EnumToString.fromString<AudibleProfile>(
            AudibleProfile.values, event));
  }

  /// This method allows you to have a stream of the system audio volume level when change
  static Stream<double> get currentVolumeStream {
    return _currentVolumeEvent
        .receiveBroadcastStream()
        .distinct()
        .map((dynamic event) => double.parse(event.toString()));
  }
}
