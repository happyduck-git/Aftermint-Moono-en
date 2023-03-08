//
//  AppDelegate.swift
//  Aftermint
//
//  Created by GG, Hank on 2023/01/19.
//

import UIKit

import Nuke
import Firebase

// Legacy from Gall3ry3
let scale = UIScreen.main.bounds.width / 375

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        
        
        // Legacy from Gall3ry3
        LLog.i("Legacy Gall3ry3 : FileManager.cacheFolderURL.path: \(FilesManager.cacheFolderURL.path).")
        ImageDecoderRegistry.shared.register { context in
            if context.urlResponse?.url?.absoluteString.hasSuffix(".svg") ?? false,
               context.urlResponse?.url?.absoluteString.hasSuffix(".SVG") ?? false,
               context.urlResponse?.url?.absoluteString.hasSuffix(".webp") ?? false,
               context.urlResponse?.url?.absoluteString.hasSuffix(".WEBP") ?? false,
               context.urlResponse?.url?.absoluteString.hasSuffix(".WebP") ?? false {
                LLog.w("Legacy Gall3ry3 : ImageDecoderRegistry loading failed.")
                return ImageDecoders.Empty()
            } else {
                return nil
            }
        }
        
        FirebaseApp.configure()
        
        FilesManager.checkDirectory(url: FilesManager.cacheFolderURL)
        LLog.i("Legacy Gall3ry3 : FontService.shared: \(FontService.shared), TemplateService.shared: \(TemplateService.shared).")
        sleep(1)
        
        
        
        LLog.v()
        return true
    }
    
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        
        LLog.v()
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
        LLog.v()
    }
    
    // Legacy from Gall3ry3
    func application(_ application: UIApplication, supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask {
        LLog.v()
        return .portrait
    }
}
