import Flutter

public class SwiftAudibleModePlugin: NSObject, FlutterPlugin {
    public static func register(with registrar: FlutterPluginRegistrar) {
        let _: FlutterHandler = FlutterHandler(binding: registrar)
    }
}
