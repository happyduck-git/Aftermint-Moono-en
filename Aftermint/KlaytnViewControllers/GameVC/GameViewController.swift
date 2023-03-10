//
//  GameViewController.swift
//  Aftermint
//
//  Created by Platfarm on 2023/03/09.
//

import UIKit

final class GameViewController: UIViewController {
    
    private let leaderBoardBottomSheetVC = LeaderBoardBottomSheetViewController()
    
    private let backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        
        return imageView
    }()
    
    private let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "game_user_info")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var gameImageView: UIImageView = {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped))
        
        let imageView = UIImageView()
        imageView.image = UIImage(named: "game_moono_mock")
        imageView.isUserInteractionEnabled = true
        imageView.addGestureRecognizer(tapGestureRecognizer)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        setLayout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationBarSetup()
        self.showLeaderBoardBottomSheetVC()
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
    
    // MARK: - Set UI & Layout
    private func setUI() {
        view.backgroundColor = AftermintColor.backgroundLightBlue
        view.addSubview(profileImageView)
        view.addSubview(gameImageView)
    }
    
    private func setLayout() {
        NSLayoutConstraint.activate([
            self.profileImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            self.profileImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20.0),
            self.gameImageView.topAnchor.constraint(equalTo: self.profileImageView.bottomAnchor, constant: 100.0),
            self.gameImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
            
        ])
    }
    
    // MARK: - Other functions
    
    /// Action when NftBackgroundImage is tapped
    @objc private func imageTapped() {

        UIView.animate(withDuration: 0.1) {
            self.gameImageView.alpha = 0.3
            self.gameImageView.alpha = 1.0
        }
    }
}

extension GameViewController {
    
    private func showLeaderBoardBottomSheetVC() {
        
        if #available(iOS 16.0, *) {

            let small = UISheetPresentationController.Detent.custom { context in
                return 300.0
            }
            
            if let sheet = self.leaderBoardBottomSheetVC.sheetPresentationController {
                
                sheet.detents = [.large(), small]
                sheet.largestUndimmedDetentIdentifier = .medium
                sheet.prefersScrollingExpandsWhenScrolledToEdge = false
                sheet.prefersEdgeAttachedInCompactHeight = true
                sheet.widthFollowsPreferredContentSizeWhenEdgeAttached = true
            }
            
            present(self.leaderBoardBottomSheetVC, animated: true, completion: nil)
            
        } else {
            
        }
    }
    
    private func hideBottomVC() {
        self.leaderBoardBottomSheetVC.dismiss(animated: true)
        
    }
    
}
