//
//  MoonoGameSceneViewModel.swift
//  Aftermint
//
//  Created by Platfarm on 2023/03/20.
//

import Foundation

protocol MoonoGameSceneViewModelDelegate: AnyObject {
    func fetchCurrentNftData(nft: Card)
}

final class MoonoGameSceneViewModel {
    
    var delegate: MoonoGameSceneViewModelDelegate?
    var delegateDidSet: Bool {
        if delegate != nil {
            print("delegate has been set")
            return true
        }
        return false
    }
    let fireStoreRepository = FirestoreRepository.shared
    let randomMoonoData: Card = MoonoMockMetaData().getRandomData()
    
    init() {
        delegate?.fetchCurrentNftData(nft: self.randomMoonoData)
    }
    
    //TODO: Need to change from dummy data to realtime data
    var count: Int64 = 0 {
        willSet {
            
            print("Current Moono NFT in Game: \(randomMoonoData.tokenId)")
            saveCountNumberOfCard(imageUri: randomMoonoData.imageUri,
                                  collectionId: randomMoonoData.collectionId,
                                  tokenId: randomMoonoData.tokenId,
                                  count: newValue)
        }
    }
    
    func increaseTouchCountByOne() {
        self.count += 1
    }
    
    func testFunction() {
        print("Called")
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
        #if DEBUG
        fireStoreRepository.saveCard(card)
        #endif
    }
    
}
