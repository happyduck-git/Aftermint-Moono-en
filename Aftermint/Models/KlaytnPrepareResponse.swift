//
//  KlaytnPrepareResponse.swift
//  Aftermint
//
//  Created by Platfarm on 2023/01/20.
//

import Foundation

struct KlaytnPrepareResponse: Decodable {
    
    let chainId: String
    let requestKey: String
    let status: String
    let expirationTime: Int

    enum CodingKeys: String, CodingKey {
        case chainId = "chain_id"
        case requestKey = "request_key"
        case status
        case expirationTime = "expiration_time"
    }
    
}
