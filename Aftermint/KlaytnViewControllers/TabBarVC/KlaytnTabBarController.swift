//
//  KlaytnTabBarController.swift
//  Aftermint
//
//  Created by Platfarm on 2023/01/20.
//

import UIKit

class KlaytnTabViewController: UITabBarController, UITabBarControllerDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setTabBarItems()
        changeTabBarRadius()
        tabBar.backgroundColor = AftermintColor.tabBarNavy
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.changeTabBarHeight()
        setUpTabBarShadow()
    }
    
    //TabBar Items
    private func setTabBarItems() {
        tabBar.backgroundColor = .white
        
        let klaytnHomeVC = KlaytnHomeViewController()
        klaytnHomeVC.tabBarItem.image = UIImage(named: "main_off")?.withRenderingMode(.alwaysOriginal)
        klaytnHomeVC.tabBarItem.selectedImage = UIImage(named: "main_on")?.withRenderingMode(.alwaysOriginal)
        
        let benefitVC = BenefitViewController()
        let benefitNaviVC = UINavigationController(rootViewController: benefitVC)
        benefitNaviVC.tabBarItem.image = UIImage(named: "gift_off")?.withRenderingMode(.alwaysOriginal)
        benefitNaviVC.tabBarItem.selectedImage = UIImage(named: "gift_on")?.withRenderingMode(.alwaysOriginal)
        
        let marketVC = MarketViewController()
        let marketNaviVC = UINavigationController(rootViewController: marketVC)
        
        marketVC.tabBarItem.image = UIImage(named: "market_off")?.withRenderingMode(.alwaysOriginal)
        marketVC.tabBarItem.selectedImage = UIImage(named: "market_on")?.withRenderingMode(.alwaysOriginal)

        let gameVC = GameViewController()
        gameVC.tabBarItem.image = UIImage(named: "game_off")?.withRenderingMode(.alwaysOriginal)
        gameVC.tabBarItem.selectedImage = UIImage(named: "game_on")?.withRenderingMode(.alwaysOriginal)
        
        let settingVC = SettingViewController()
        settingVC.tabBarItem.image = UIImage(named: "setting_off")?.withRenderingMode(.alwaysOriginal)
        settingVC.tabBarItem.selectedImage = UIImage(named: "setting_on")?.withRenderingMode(.alwaysOriginal)

        self.viewControllers = [klaytnHomeVC, benefitNaviVC, marketVC, gameVC, settingVC]

    }
    
    private func changeTabBarHeight() {
        var tabFrame = tabBar.frame
        let tabBarHeight = view.frame.size.height / 8.2
        tabFrame.size.height = tabBarHeight
        tabFrame.origin.y = view.frame.height - tabBarHeight
        tabBar.frame = tabFrame
    }
    
    private func changeTabBarRadius() {
        tabBar.isTranslucent = true
        tabBar.layer.cornerRadius = 16
        tabBar.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
    }
        
    private func setUpTabBarShadow() {
        tabBar.layer.masksToBounds = false
        tabBar.layer.shadowColor = UIColor.black.cgColor
        tabBar.layer.shadowOpacity = 0.2
        tabBar.layer.shadowOffset = CGSize(width: 0, height: -3)
        tabBar.layer.shadowRadius = 16
    }
    
}

