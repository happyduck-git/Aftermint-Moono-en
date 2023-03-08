//
//  BellyGomNftMetadata.swift
//  Aftermint
//
//  Created by Hank on 2023/01/27.
//

import Foundation

struct BellyGomNftMetadata: Decodable {
    private static let TOKEN__ATTRIBUTE__KEY__RANK = "Rank"
    
    let name: String
    let description: String
    let image: String
    let score: Int
    let attributes: [Attribute]
    
    struct Attribute: Decodable {
        let value: Any
        let trait_type: String
        
        enum CodingKeys: CodingKey {
            case value
            case trait_type
        }
        
        init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: BellyGomNftMetadata.Attribute.CodingKeys.self)
            
            self.trait_type = try container.decode(
                String.self,
                forKey: BellyGomNftMetadata.Attribute.CodingKeys.trait_type
            )
            
            let value: Any
            if self.trait_type == TOKEN__ATTRIBUTE__KEY__RANK {
                value = try container.decode(
                    Int.self,
                    forKey: BellyGomNftMetadata.Attribute.CodingKeys.value
                )
            } else {
                value = try container.decode(
                    String.self,
                    forKey: BellyGomNftMetadata.Attribute.CodingKeys.value
                )
            }
            self.value = value
        }
    }
}
