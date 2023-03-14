//
//  SceneDelegate.swift
//  Aftermint
//
//  Created by GG, Hank on 2023/01/19.
//

import UIKit
import ReactorKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {

        if let windowScene = scene as? UIWindowScene {
            var path: [AnyObject] = NSSearchPathForDirectoriesInDomains(.libraryDirectory, .userDomainMask, true) as [AnyObject]
            let folder: String = path[0] as! String
            print("Your NSUserDefaults are stored in this folder: %@/Preferences", folder)
            /* Gallery3 */
            /*
             let appDependency = AppDependency.resolve()
             let homeVC = HomeViewController(reactor: appDependency.homeViewReactor)
             let homeNaviVC = UINavigationController(rootViewController: homeVC)
             homeNaviVC.setNavigationBarHidden(true, animated: false)
             let window = UIWindow(windowScene: windowScene)
             window.rootViewController = homeNaviVC
             */
            
            let window = UIWindow(windowScene: windowScene)
            window.backgroundColor = AftermintColor.backgroundNavy
            UINavigationBar.appearance().backIndicatorImage = UIImage(named: "back")
            UINavigationBar.appearance().backIndicatorTransitionMaskImage = UIImage(named: "back")
            
            /* From LoginVC */

            let token = UserDefaults.standard.string(forKey: KasWalletRepository.shared.getWalletKey())
            var rootNaviVC: UINavigationController?
            
            /* Temp Comment: LogincVC */
            if token == nil {
                let reactor: LoginViewReactor = LoginViewReactor()
                let loginVC = LoginViewController(reactor: reactor)
                rootNaviVC = UINavigationController(rootViewController: loginVC)
            } else {
                let homeVC = KlaytnTabViewController()
                rootNaviVC = UINavigationController(rootViewController: homeVC)
            }
            
            /* Temp: StartVC */
//            rootNaviVC = UINavigationController(rootViewController: KlaytnTabViewController())
           
            
//            rootNaviVC?.setNavigationBarHidden(true, animated: false)
            
            window.rootViewController = rootNaviVC
            self.window = window
            window.makeKeyAndVisible()
            
            LLog.v()
        }
    }
        
        func sceneDidDisconnect(_ scene: UIScene) {
            LLog.v()
        }
        
        func sceneDidBecomeActive(_ scene: UIScene) {
            LLog.v()
        }
        
        func sceneWillResignActive(_ scene: UIScene) {
            LLog.v()
        }
        
        func sceneWillEnterForeground(_ scene: UIScene) {
            LLog.v()
        }
        
        func sceneDidEnterBackground(_ scene: UIScene) {
            // Save changes in the application's managed object context when the application transitions to the background.
            // Legacy from Gall3ry3
            // (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
            LLog.v()
        }
        
        // Legacy from Gall3ry3
        func scene(_ scene: UIScene, openURLContexts URLContexts: Set<UIOpenURLContext>) {
            handleOpenURL(notificationName: .twitterCallback, callbackScheme: TwitterService.twitterURLScheme, url: URLContexts.first?.url)
            LLog.v()
        }
        
        // Legacy from Gall3ry3
        private func handleOpenURL(notificationName: Notification.Name, callbackScheme scheme: String, url: URL?) {
            guard let url = url,
                  let urlScheme = url.scheme,
                  let callbackURL = URL(string: "\(scheme)://"),
                  let callbackScheme = callbackURL.scheme else {
                LLog.w("Legacy Gall3ry3 : notificationName: \(notificationName), scheme: \(scheme), url: \(String(describing: url)).")
                return
            }
            
            guard urlScheme.caseInsensitiveCompare(callbackScheme) == .orderedSame else { return }
            
            let notification = Notification(name: notificationName, object: url, userInfo: nil)
            NotificationCenter.default.post(notification)
            LLog.v("Legacy Gall3ry3 : notificationName: \(notificationName), url: \(url), urlScheme: \(urlScheme), callbackURL: \(callbackURL), callbackScheme: \(callbackScheme).")
        }
    
}
