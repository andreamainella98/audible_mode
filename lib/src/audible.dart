part of audible_mode;

class Audible {
  static const MethodChannel _channel = const MethodChannel(_METHOD_CHANNEL);

  static Future<AudibleProfile?> get getDeviceMode async {
    String temp = await _channel.invokeMethod(_GET_AUDIBLE_MODE);
    await Future.delayed(Duration(milliseconds: 500)).then((value) async {
      temp = await _channel.invokeMethod(_GET_AUDIBLE_MODE);
    });
    debugPrint("AUDIBLE MODE: $temp");
    return EnumToString.fromString<AudibleProfile>(AudibleProfile.values, temp);
  }
}
