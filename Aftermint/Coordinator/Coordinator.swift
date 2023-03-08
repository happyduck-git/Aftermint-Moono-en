//
//  Coordinator.swift
//  Aftermint
//
//  Created by HappyDuck on 2023/02/23.
//

import Foundation
import UIKit


enum Event {
    case buttonTapped
}

protocol Coordinator {
    var navigationController: UINavigationController? { get set }
    
    func eventOccurred(with type: Event)
    func start()
}

protocol Coordinating {
    var coordinator: Coordinator? { get set }
}


