//
//  KasWalletRepository.swift
//  Aftermint
//
//  Created by Platfarm on 2023/02/01.
//

import Foundation

class KasWalletRepository {
    
    static let shared: KasWalletRepository = .init()
    private let currentWalletKey = "KasWalletRepository.CurrentKey"
    
    private init() {}
    
    func setCurrentWallet(walletAddress: String) {
        UserDefaults.standard.set(walletAddress, forKey: currentWalletKey)
    }
    
    func getCurrentWallet() -> String {
        let address: String = UserDefaults.standard.string(forKey: currentWalletKey) ?? "0xBEeBb41496BE8385291886928725d1c2bD9aBA42"
        return address
    }
    
    func getWalletKey() -> String {
        return self.currentWalletKey
    }
}
