import Flutter

public class AudibleModePlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let _: FlutterHandler = FlutterHandler(binding: registrar)
  }
}
