import Flutter
import UIKit
import Mute

public class SwiftAudibleModePlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    Mute.shared.checkInterval = 0.2;
    let channel = FlutterMethodChannel(
        name: Constants.METHOD_CHANNEL,
        binaryMessenger: registrar.messenger()
    )
    let instance = SwiftAudibleModePlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    switch call.method {
        case Constants.GET_AUDIBLE_MODE:
            Mute.shared.check()
            if(Mute.shared.isMute) {
                result(AudibleMode.SILENT_MODE.rawValue)
            } else {
                result(AudibleMode.NORMAL_MODE.rawValue)
            }
            break;
        default:
            result("Method not found")
        }
  }
}
