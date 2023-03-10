//
//  LeaderBoardBottomSheetViewController.swift
//  Aftermint
//
//  Created by Platfarm on 2023/03/10.
//

import UIKit

final class LeaderBoardBottomSheetViewController: UIViewController {
    
    let leaderBoardMockUpImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "game_leaderboard_mock")
        imageView.contentMode = .center
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        setLayout()
    }
    
    private func setUI() {
        view.backgroundColor = AftermintColor.backgroundNavy
        view.addSubview(leaderBoardMockUpImageView)
    }
    
    private func setLayout() {
        NSLayoutConstraint.activate([
            self.leaderBoardMockUpImageView.topAnchor.constraint(equalTo: view.topAnchor),
            self.leaderBoardMockUpImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            self.leaderBoardMockUpImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),

        ])
    }
}
