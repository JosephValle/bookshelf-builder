import Cocoa
import FlutterMacOS
import UniformTypeIdentifiers

class MainFlutterWindow: NSWindow {
  override func awakeFromNib() {
    let flutterViewController = FlutterViewController()
    let windowFrame = self.frame
    self.contentViewController = flutterViewController
    self.setFrame(windowFrame, display: true)

    RegisterGeneratedPlugins(registry: flutterViewController)
    registerFileChannel(flutterViewController)

    super.awakeFromNib()
  }

  /// Lets Dart save a PDF through the system save panel and show it in Finder.
  ///
  /// `savePdf` takes `bytes` and a suggested `name`, and returns the saved path
  /// (or nil if the user cancels). `reveal` takes a `path` and selects it in
  /// Finder.
  private func registerFileChannel(_ controller: FlutterViewController) {
    let channel = FlutterMethodChannel(
      name: "shelf_planner/files",
      binaryMessenger: controller.engine.binaryMessenger
    )
    channel.setMethodCallHandler { call, result in
      guard let args = call.arguments as? [String: Any] else {
        result(FlutterError(code: "bad_args", message: "Missing arguments", details: nil))
        return
      }
      switch call.method {
      case "savePdf":
        guard let data = args["bytes"] as? FlutterStandardTypedData else {
          result(FlutterError(code: "bad_args", message: "Missing bytes", details: nil))
          return
        }
        let panel = NSSavePanel()
        panel.allowedContentTypes = [.pdf]
        panel.canCreateDirectories = true
        panel.nameFieldStringValue = (args["name"] as? String) ?? "shelf_planner.pdf"
        guard panel.runModal() == .OK, let url = panel.url else {
          result(nil)
          return
        }
        do {
          try data.data.write(to: url)
          result(url.path)
        } catch {
          result(FlutterError(code: "write_failed", message: error.localizedDescription, details: nil))
        }
      case "reveal":
        guard let path = args["path"] as? String else {
          result(FlutterError(code: "bad_args", message: "Missing path", details: nil))
          return
        }
        NSWorkspace.shared.activateFileViewerSelecting([URL(fileURLWithPath: path)])
        result(nil)
      default:
        result(FlutterMethodNotImplemented)
      }
    }
  }
}
