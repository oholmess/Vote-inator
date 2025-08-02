//
//  MetaMaskRepo.swift
//  Vote-inator
//
//  Created by Oliver Holmes on 12/11/24.
//

import Foundation
import Combine
import metamask_ios_sdk
import SwiftUI

class MetaMaskRepo: ObservableObject {
    
    // Published properties to notify observers of changes
    @Published var connectionStatus = "Offline" {
        didSet {
            NotificationCenter.default.post(name: .connection, object: nil, userInfo: ["value": connectionStatus])
        }
    }
    @Published var chainID = ""
    @Published var account = ""
    
    @Published var metamaskSDK: MetaMaskSDK
    
    private let dappName = "vote-inator"
    private let dappUrl = "https://vote-inator.com"
    var appMetadata: AppMetadata
    
    private var cancellables: Set<AnyCancellable> = []
    
    init() {
        // Initialize appMetadata first
        self.appMetadata = AppMetadata(name: dappName, url: dappUrl)
        
        // To use deeplinking as transport layer
        self.metamaskSDK = MetaMaskSDK.shared(
            appMetadata,
            transport: .deeplinking(dappScheme: "vote-inator"),
            sdkOptions: SDKOptions(infuraAPIKey: "6296df26da0c49ac8def8a31c1aed2b5", readonlyRPCMap: ["0x1": "hptts://www.testrpc.com"]) // for read-only RPC calls
        )
        observeConnectionStatus()
    }
    
    private func observeConnectionStatus() {
        metamaskSDK.$connected
            .sink { [weak self] connected in
                self?.connectionStatus = connected ? "Connected" : "Disconnected"
            }
            .store(in: &cancellables)
    }
    
    func connectToDapp() async {
        // Connect to MetaMask
        let result = await metamaskSDK.connect()
        
        switch result {
        case .success(let connectResult):
            // Update published properties on the main thread
            let chainResult = await metamaskSDK.getChainId()
            switch chainResult {
            case .success(let chainId):
                await MainActor.run { self.chainID = chainId }
            case .failure(let error):
                print("Error getting chain ID: \(error)")
            }
            DispatchQueue.main.async { [weak self] in
                self?.account = self?.metamaskSDK.account ?? ""
                self?.connectionStatus = "Connected"
                print("Connected to MetaMask: \(connectResult)")
            }
        case .failure(let error):
            DispatchQueue.main.async { [weak self] in
                self?.connectionStatus = "Disconnected"
                print("Error connecting to MetaMask: \(error)")
                // Optionally, update UI to reflect the error
            }
        }
        
    }
    
    // Additional methods to interact with MetaMaskSDK can be added here
}

