//
//  TestViewController.swift
//  Aftermint
//
//  Created by HappyDuck on 2023/03/05.
//

import UIKit

final class TestViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemPink
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("\(#file) -- \(#function) called")
        navigationController?.navigationItem.hidesBackButton = false
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print(navigationController?.viewControllers)
    }
    
}
