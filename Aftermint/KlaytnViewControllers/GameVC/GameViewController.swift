//
//  GameViewController.swift
//  Aftermint
//
//  Created by Platfarm on 2023/03/09.
//

import UIKit

final class GameViewController: UIViewController {
    
    private let backgroundImageView: UIImageView = {
       let imageView = UIImageView()
        
        return imageView
    }()
    
    private let profileImageView: UIImageView = {
        let imageView = UIImageView()
         
         return imageView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = AftermintColor.backgroundLightBlue
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationBarSetup()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    private func navigationBarSetup() {
        
        self.tabBarController?.navigationItem.setHidesBackButton(true, animated: false)
        
        self.tabBarController?.navigationItem.title = ""
        
        /* Left bar item */
        let logo = UIImage(named: "game_logo")
        let myImageView = UIImageView(image: logo)
        let leftBar: UIBarButtonItem = UIBarButtonItem(customView: myImageView)
        self.tabBarController?.navigationItem.leftBarButtonItem = leftBar
        
        /* Right bar item */
        self.tabBarController?.navigationItem.rightBarButtonItems = nil
    }
    
}
