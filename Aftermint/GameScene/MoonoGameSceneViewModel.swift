//
//  MoonoGameSceneViewModel.swift
//  Aftermint
//
//  Created by Platfarm on 2023/03/20.
//

import Foundation

final class MoonoGameSceneViewModel {
    
    let fireStoreRepository = FirestoreRepository.shared
    ///TEMP: Using mock data
    let randomMoonoData: Card = MoonoMockMetaData().getOneMockData()
    
    /// Save increase touch count of a certain card to Firestore
    func increaseTouchCount(_ number: Int64) {
        saveCountNumberOfCard(imageUri: randomMoonoData.imageUri,
                              collectionId: randomMoonoData.collectionId,
                              tokenId: randomMoonoData.tokenId,
                              count: number)
    }
    
    func saveCountNumberOfCard(imageUri: String,
                               collectionId: String,
                               tokenId: String,
                               count: Int64)
    {
        
        let card: Card = Card(imageUri: imageUri,
                              collectionId: collectionId,
                              tokenId: tokenId,
                              count: count)
        let collection: NftCollection = NftCollection(collectionId: K.ContractAddress.moono,
                                                      collectionLogoImage: "N/A",
                                                      count: count)
        fireStoreRepository.saveCard(card)
        fireStoreRepository.saveCollection(collection)

    }
    
}
