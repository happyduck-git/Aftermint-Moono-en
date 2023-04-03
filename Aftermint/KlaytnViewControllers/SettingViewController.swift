//
//  SettingsViewController.swift
//  Aftermint
//
//  Created by Platfarm on 2023/01/20.
//

import UIKit

class SettingViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.tabBarController?.navigationController?.setNavigationBarHidden(true, animated: false)
    }
}
