//
//  KlaytnAuthResult.swift
//  Aftermint
//
//  Created by Platfarm on 2023/01/20.
//

import Foundation

struct KlaytnAuthResult: Decodable {
    
    var status: String
    var type: String
    var chainId: String
    var requestKey: String
    var expirationTime: Int
    var result: KlaytnAddress?
    
    enum CodingKeys: String, CodingKey {
        case status
        case type
        case chainId = "chain_id"
        case requestKey = "request_key"
        case expirationTime = "expiration_time"
        case result
    }
    
}

struct KlaytnAddress: Codable {
    var klaytnAddress: String
    
    enum CodingKeys: String, CodingKey {
        case klaytnAddress = "klaytn_address"
    }
}



