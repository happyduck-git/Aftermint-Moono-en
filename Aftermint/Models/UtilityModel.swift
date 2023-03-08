//
//  UtilityModel.swift
//  Aftermint
//
//  Created by HappyDuck on 2023/01/25.
//

import Foundation

struct UtilityModel {

    let companyName: String
    let benefit: String
    let valid: IsValid
    
}

enum IsValid: String {
    
    case valid = "Valid"
    case invalid = "Invalid"
    case soon = "Soon"
    
}

