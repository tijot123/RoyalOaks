import UIKit
import Flutter
import GoogleMaps
import Firebase
import FirebaseAnalytics
import Siren

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    let siren = Siren.shared
    siren.rulesManager = RulesManager(globalRules: .critical)
    siren.wail()
    if #available(iOS 10.0, *) {
          UNUserNotificationCenter.current().delegate = self as UNUserNotificationCenterDelegate
        }
    GMSServices.provideAPIKey("AIzaSyB2P8gNlFvFCqp3SFe2iwAJQbtU80gditg")
    FirebaseApp.configure()
    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
