//
//  MoonoNftMetadata.swift
//  Aftermint
//
//  Created by Hank on 2023/03/08.
//

import Foundation

struct MoonoNftMetadata: Decodable {
    let name: String
    let description: String
    let image: String
    let attributes: [Attributes]
    
    struct Attributes: Decodable {
        let value: String
        let trait_type: String
    }
}
