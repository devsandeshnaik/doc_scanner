import UIKit
import Flutter

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
    override func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        
        let controller = window?.rootViewController as! FlutterViewController
        let batteryChannel = FlutterMethodChannel(name: "com.triviatribe.scanner/native", binaryMessenger: controller.binaryMessenger)

        batteryChannel.setMethodCallHandler(handle)
        
        GeneratedPluginRegistrant.register(with: self)
        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }

    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    if let viewController = UIApplication.shared.delegate?.window??.rootViewController as? FlutterViewController {
        let destinationViewController = HomeViewController()
        destinationViewController.modalPresentationStyle = .fullScreen
        destinationViewController._result = result
        viewController.present(destinationViewController,animated: true,completion: nil);
    }
  }
}
