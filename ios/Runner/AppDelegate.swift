


import UIKit
import Flutter
import GoogleMaps
import FirebaseMessaging

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {




  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {




   // For Firebse FCM
//      if #available(iOS 10.0, *) {
//    UNUserNotificationCenter.current().delegate = self as? UNUserNotificationCenterDelegate

//  }
  // HERE

    GMSServices.provideAPIKey("AIzaSyB2TvUvkaaKAWAejqlikg3xqpicJq-vD28")
    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }


}
