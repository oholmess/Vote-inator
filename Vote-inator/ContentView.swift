//
//  ContentView.swift
//  Vote-inator
//
//  Created by Oliver Holmes on 12/11/24.
//

import SwiftUI
import metamask_ios_sdk
import Combine

struct ContentView: View {
    @State var loginStatus = "Offline"
    @StateObject var metaMaskRepo = MetaMaskRepo()
    
    var body: some View {
        ZStack {
            if loginStatus == "Connected" {
                HomePageView(metaMaskRepo: metaMaskRepo)
            } else {
                LoginView(metaMaskRepo: metaMaskRepo)
            }
        }
        .onReceive(NotificationCenter.default.publisher(for: .connection)) { notification in
            print("Received notification")
            print(notification.userInfo?["value"] as? String ?? "Offline")
            loginStatus = notification.userInfo?["value"] as? String ?? "Offline"
        }
        .preferredColorScheme(.light)
    }
}

#Preview {
    ContentView()
}
