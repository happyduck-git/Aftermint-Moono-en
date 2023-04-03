//
//  BasicTabBarController.swift
//  Aftermint
//
//  Created by Platfarm on 2023/02/06.
//

import UIKit

class BasicTabBarController: UITabBarController, UITabBarControllerDelegate {
    
    //MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setBarButtonItem()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setTabBarItems()
        
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.changeTabBarHeight()
        setUpTabBarShadow()
        changeTabBarRadius()
    }
    
    //TabBar Items
    private func setTabBarItems() {
        
        let marketNftViewContoller = MarketDetailViewController()
        marketNftViewContoller.tabBarItem.image = UIImage(named: MarketAsset.openseaButton.rawValue)?.withRenderingMode(.alwaysOriginal)
        marketNftViewContoller.tabBarController?.tabBar.tintColor = AftermintColor.backgroundNavy
        self.viewControllers = [marketNftViewContoller]
        
    }
    
    private func changeTabBarHeight() {
        var tabFrame = tabBar.frame
        let tabBarHeight = view.frame.size.height / 7
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
    
    private func setBarButtonItem() {
        let backButtonImage: UIImage? = UIImage(named: "back")?.withRenderingMode(.alwaysOriginal)
        let buttonItem = UIBarButtonItem(image: backButtonImage, style: .plain, target: self, action: #selector(backToMarketVC))
        self.navigationItem.leftBarButtonItem = buttonItem
    }
    
    @objc private func backToMarketVC() {
        self.navigationController?.popViewController(animated: true)
    }
}
