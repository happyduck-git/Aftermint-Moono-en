//
//  LeaderBoardTableViewCellViewModel.swift
//  Aftermint
//
//  Created by Platfarm on 2023/03/17.
//

import Foundation

struct LeaderBoardTableViewCellListViewModel {
    
    var viewModelList: [LeaderBoardTableViewCellViewModel] = []
    
    func numberOfRowsInSection(at section: Int) -> Int {
        return self.viewModelList.count
    }
    
    func modelAt(_ index: Int) -> LeaderBoardTableViewCellViewModel {
        return self.viewModelList[index]
    }
}

struct LeaderBoardTableViewCellViewModel {
    
    let rankImage: String
    let nftImage: String
    let nftName: String
    let touchScore: Int
    
}
