import UIKit
import Flutter
import GoogleMobileAds

@main
@objc class AppDelegate: FlutterAppDelegate {
  
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    // Register Flutter plugins
    GeneratedPluginRegistrant.register(with: self)
    
    // Initialize Google Mobile Ads SDK
    GADMobileAds.sharedInstance().start(completionHandler: nil)

    // For iOS 13+ using SceneDelegate, no need to manually set the window
    if #available(iOS 13.0, *) {
      // iOS 13+ uses SceneDelegate to manage the window
    } else {
      // For iOS versions before 13, manually configure the window
      self.window = UIWindow(frame: UIScreen.main.bounds)
      self.window?.rootViewController = FlutterViewController()
      self.window?.makeKeyAndVisible()
    }

    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
