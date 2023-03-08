//
//  NFTCardViewModel.swift
//  Aftermint
//
//  Created by HappyDuck on 2023/02/25.
//

import Foundation

struct NFTCardViewModel {
    
    var bellyGomNfts: Box<[BellyGomNft]> = Box([])
    
    func numberOfItems() -> Int {
        return 0
    }
    
    func getNfts(of wallet: String, completion: @escaping ([BellyGomNft])->()) {

        _ = KlaytnNftRequester.requestToGetBellyGomNfts(
            walletAddress: wallet
        ) { nfts in
            completion(nfts)
            
        }
    }
    
}
