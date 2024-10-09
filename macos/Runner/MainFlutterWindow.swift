import Cocoa
import FlutterMacOS

class MainFlutterWindow: NSWindow {
  override func awakeFromNib() {
    let flutterViewController = FlutterViewController()
    let windowFrame = self.frame
    self.contentViewController = flutterViewController
    self.setFrame(windowFrame, display: true)

    RegisterGeneratedPlugins(registry: flutterViewController)
    FlutterMethodChannel(
        name: "launch_at_startup", binaryMessenger: flutterViewController.engine.binaryMessenger
      )
      .setMethodCallHandler { (_ call: FlutterMethodCall, result: @escaping FlutterResult) in
        switch call.method {
        case "launchAtStartupIsEnabled":
          result(LaunchAtLogin.isEnabled)
        case "launchAtStartupSetEnabled":
          if let arguments = call.arguments as? [String: Any] {
            LaunchAtLogin.isEnabled = arguments["setEnabledValue"] as! Bool
          }
          result(nil)
        default:
          result(FlutterMethodNotImplemented)
        }
      }
    super.awakeFromNib()
  }
}
