//
//  KlaytnNFT.swift
//  Aftermint
//
//  Created by Platfarm on 2023/01/20.
//

import Foundation

struct KlaytnNFT: Decodable {
    let name: String
    let description: String
    let image: String
    let score: Int
    let attributes: [Attribute]

    struct Attribute: Decodable {
        let traitType: String

        enum CodingKeys: String, CodingKey {
            case traitType = "trait_type"
        }
    }
}
