//
//  KlaytnNft.swift
//  Aftermint
//
//  Created by Hank on 2023/01/27.
//

import Foundation

struct KlaytnNfts: Decodable {
    let items: [KlaytnNft]
    let cursor: String
}

struct KlaytnNft: Decodable {
    let owner: String
    let previousOwner: String
    let tokenId: String
    let tokenUri: String
    let transactionHash: String
    let createdAt: Int64
    let updatedAt: Int64
}
