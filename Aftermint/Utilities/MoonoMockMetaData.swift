//
//  MoonoMockMetaData.swift
//  Aftermint
//
//  Created by Platfarm on 2023/03/20.
//

import Foundation

/// Moono Mock MetaData Only for Game Demo
/// Will be removed
struct MoonoMockMetaData {
    
    private let moonoList: [Card] = [
        
        Card(imageUri: "https://firebasestorage.googleapis.com/v0/b/moono-aftermint-storage.appspot.com/o/Moono%2381.jpeg?alt=media",
             collectionId: K.ContractAddress.moono,
             tokenId: "Moono #81",
             count: 0),
        
        Card(imageUri: "https://firebasestorage.googleapis.com/v0/b/moono-aftermint-storage.appspot.com/o/Moono%231126.jpeg?alt=media",
             collectionId: K.ContractAddress.moono,
             tokenId: "Moono #1126",
             count: 0),
        
        Card(imageUri: "https://firebasestorage.googleapis.com/v0/b/moono-aftermint-storage.appspot.com/o/Moono%23618.jpeg?alt=media",
             collectionId: K.ContractAddress.moono,
             tokenId: "Moono #618",
             count: 0),
        
        Card(imageUri: "https://firebasestorage.googleapis.com/v0/b/moono-aftermint-storage.appspot.com/o/Moono%23659.jpeg?alt=media",
             collectionId: K.ContractAddress.moono,
             tokenId: "Moono #659",
             count: 0),
        
        Card(imageUri: "https://firebasestorage.googleapis.com/v0/b/moono-aftermint-storage.appspot.com/o/Moono%231202.jpeg?alt=media",
             collectionId: K.ContractAddress.moono,
             tokenId: "Moono #1202",
             count: 0),
        
        Card(imageUri: "https://firebasestorage.googleapis.com/v0/b/moono-aftermint-storage.appspot.com/o/Moono%23924.jpeg?alt=media",
             collectionId: K.ContractAddress.moono,
             tokenId: "Moono #924",
             count: 0)
        
    ]
    
    func getRandomData() -> Card {
        let randomIndex = Int.random(in: 0..<self.moonoList.count)
        return self.moonoList[randomIndex]
    }
    
}

