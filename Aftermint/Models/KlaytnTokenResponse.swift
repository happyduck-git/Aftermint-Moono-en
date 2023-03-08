//
//  KlaytnTokenResponse.swift
//  Aftermint
//
//  Created by Platfarm on 2023/01/20.
//

import Foundation

struct KlaytnTokenResponse: Decodable {
    
    let items: [Item]
    let cursor: String?
    
    struct Item: Decodable {
        
        let tokenId: String
        let owner: String
        let previousOwner: String?
        let tokenUri: String
        
    }
    
}




