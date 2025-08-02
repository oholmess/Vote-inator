//
//  Vote_inatorApp.swift
//  Vote-inator
//
//  Created by Oliver Holmes on 12/11/24.
//

import SwiftUI
import metamask_ios_sdk

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        if URLComponents(url: url, resolvingAgainstBaseURL: true)?.host == "mmsdk" {
            MetaMaskSDK.sharedInstance?.handleUrl(url)
        } else {
            // handle other deeplinks
        }
        return true
    }
}

@main
struct Vote_inatorApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .onOpenURL { url in
                    if URLComponents(url: url, resolvingAgainstBaseURL: true)?.host == "mmsdk" {
                        MetaMaskSDK.sharedInstance?.handleUrl(url)
                    } else {
                        // handle other deeplinks
                    }
                }
        }
    }
}
