//
//  LeaderBoardTableViewCellViewModel.swift
//  Aftermint
//
//  Created by Platfarm on 2023/03/17.
//

import UIKit.UIImage

final class LeaderBoardTableViewCellListViewModel {
    
    var viewModelList: Box<[LeaderBoardTableViewCellViewModel]>  = Box([])
    var touchCount: Box<Int> = Box(0)
    
    let fireStoreRepository = FirestoreRepository.shared
    
    func numberOfRowsInSection(at section: Int) -> Int {
         return self.viewModelList.value?.count ?? 0
    }
    
    func modelAt(_ index: Int) -> LeaderBoardTableViewCellViewModel? {
        guard let viewModel: LeaderBoardTableViewCellViewModel = self.viewModelList.value?[index] else { return nil }
        return viewModel
    }
    
    func getAllNftRankCellViewModels(completion: @escaping (Result<[LeaderBoardTableViewCellViewModel], Error>) -> ()) {
        
        self.fireStoreRepository.getAllCard { cardsList in
            
            guard let cards = cardsList,
                  let rankImage = UIImage(named: LeaderBoard.firstPlace.rawValue)
            else { return }
            
            let initialRank = 1
            let viewModels = cards.map { card in
                
                let viewModel: LeaderBoardTableViewCellViewModel = LeaderBoardTableViewCellViewModel(rankImage: rankImage,
                                                                                                     rank: initialRank, // Set initial rank as 1
                                                                                                     nftImage: card.imageUri,
                                                                                                     nftName: card.tokenId,
                                                                                                     touchScore: card.count)
                return viewModel
            }
            completion(.success(viewModels))
            return
        }
        completion(.failure(LeaderBoardTableViewCellListError.nftFetchError))
    }
    
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
// MARK: - Custom Error type
extension LeaderBoardTableViewCellListViewModel {
    
    enum LeaderBoardTableViewCellListError: Error {
        case nftFetchError
        case collectionFetchError
    }
    
}

final class LeaderBoardTableViewCellViewModel {
    
    var rankImage: UIImage
    var rank: Int
    let nftImage: String
    let nftName: String
    let touchScore: Int64
    
    //MARK: - Initializer
    init(rankImage: UIImage, rank: Int, nftImage: String, nftName: String, touchScore: Int64) {
        self.rankImage = rankImage
        self.rank = rank
        self.nftImage = nftImage
        self.nftName = nftName
        self.touchScore = touchScore
    }
    
    //MARK: - Internal function
    func setRankImage(with image: UIImage?) {
        guard let image = image else { return }
        self.rankImage = image
    }
    
    func setRankNumberWithIndexPath(_ indexPathRow: Int) {
        self.rank = indexPathRow
    }
    
}


