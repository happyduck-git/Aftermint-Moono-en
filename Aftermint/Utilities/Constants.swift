//
//  Constants.swift
//  Aftermint
//
//  Created by HappyDuck on 2023/02/25.
//

import Foundation

struct K {
    
    struct ContractAddress {
        static let moono = "0x29421a3c92075348fcbcb04de965e802ed187302"
    }
    
    /// Wallet related constants
    struct Wallet {
        static let temporaryAddress = "0x6a5fe8B4718bC147ba13BD8Dfb31eC6097bfabcB"
    }

    /// Firebase firestore related constants
    struct FStore {
        static let nftCardCollectionName: String = "Card"
        static let collectionIdFieldKey: String = "collectionId"
        static let imageUriFieldKey: String = "imageUri"
        static let collectionLogoImageFieldKey: String = "collectionLogoImage"
        static let tokenIdFieldKey: String = "tokenId"
        static let countFieldKey: String = "count"
        static let totalDocumentName: String = "Total Count"
    }
    
}

/// GameViewController Bottom LeaderBoard related constants
enum LeaderBoard: String {
    case title = "Leader board"
    case markImageName = "leader-board-mark"
}

enum GameSceneAsset: String {
    case particles = "SparkParticle.sks"
    case moonoImage = "game_moono_mock"
}
