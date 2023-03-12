//
//  NFTCardViewModel.swift
//  Aftermint
//
//  Created by HappyDuck on 2023/02/25.
//

import Foundation

struct NFTCardViewModel {
    
    var moonoNfts: Box<[MoonoNft]> = Box([])
    
    func numberOfItemsInSection() -> Int {
        guard let numberOfItems = self.moonoNfts.value?.count else {
            return 0
        }
        print("numberofNfts: \(numberOfItems)")
        return numberOfItems
    }
    
    func itemAtIndex(_ index: Int) -> MoonoNft? {
        guard let moonoNft: MoonoNft = self.moonoNfts.value?[index] else { return nil }
        return moonoNft
    }
    
    func getNfts(of wallet: String, completion: @escaping ([MoonoNft])->()) {
        
        _ = KlaytnNftRequester.requestToGetMoonoNfts(walletAddress: wallet,
                                                     nftsHandler: { nfts in
            completion(nfts)
        })
        
    }
    
}
