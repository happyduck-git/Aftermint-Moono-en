//
//  LeaderBoardTableViewCellViewModel.swift
//  Aftermint
//
//  Created by Platfarm on 2023/03/17.
//

import UIKit.UIImage

enum RankImage: String {
    case firstPlace = "1st_place_medal"
    case secondPlace = "2nd_place_medal"
    case thirdPlace = "3rd_place_medal"
    case others = "leader-board-mark"
}

class LeaderBoardTableViewCellListViewModel {
    
    var viewModelList: [LeaderBoardTableViewCellViewModel] = []
    let fireStoreRepository = FirestoreRepository.shared
    
    func numberOfRowsInSection(at section: Int) -> Int {
        return self.viewModelList.count
    }
    
    func modelAt(_ index: Int) -> LeaderBoardTableViewCellViewModel {
        return self.viewModelList[index]
    }
    
    func getAllNftRankCellViewModels(completion: @escaping (Result<[LeaderBoardTableViewCellViewModel], Error>) -> ()) {
        
        self.fireStoreRepository.getAllCard { cardsList in
            
            guard let cards = cardsList,
                  let rankImage = UIImage(named: RankImage.firstPlace.rawValue)
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
}
// MARK: - Custom Error type
extension LeaderBoardTableViewCellListViewModel {
    
    enum LeaderBoardTableViewCellListError: Error {
        case nftFetchError
        case collectionFetchError
    }
    
}

class LeaderBoardTableViewCellViewModel {
    
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


