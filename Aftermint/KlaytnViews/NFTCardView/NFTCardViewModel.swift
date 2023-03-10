//
//  NFTCardViewModel.swift
//  Aftermint
//
//  Created by HappyDuck on 2023/02/25.
//

import Foundation

struct NFTCardViewModel {
    
    var moonoNfts: Box<[MoonoNft]> = Box([])
    
    func numberOfItems() -> Int {
        return 0
    }
    
    func getNfts(of wallet: String, completion: @escaping ([MoonoNft])->()) {
        
        _ = KlaytnNftRequester.requestToGetMoonoNfts(walletAddress: wallet,
                                                     nftsHandler: { nfts in
            completion(nfts)
        })
        
    }
    
}
