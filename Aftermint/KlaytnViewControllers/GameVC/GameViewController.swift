//
//  GameViewController.swift
//  Aftermint
//
//  Created by Platfarm on 2023/03/09.
//

import UIKit
import SpriteKit

final class GameViewController: UIViewController {
    
    private let leaderBoardBottomSheetVC = LeaderBoardBottomSheetViewController()
    private let gameVCViewModel: GameViewControllerViewModel = GameViewControllerViewModel()
    
    private let gameSceneViewModel: MoonoGameSceneViewModel = MoonoGameSceneViewModel()
    var leaderBoardViewModel: LeaderBoardTableViewCellListViewModel = LeaderBoardTableViewCellListViewModel()
    
    // MARK: - UI Elements
    private let nftImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .tertiarySystemFill
        imageView.contentMode = .scaleAspectFit
        imageView.layer.borderColor = UIColor(ciColor: .white).cgColor
        imageView.layer.borderWidth = 1.0
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let nftDataAndScoreStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 5
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private let nftDataStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private let nftNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = BellyGomFont.header06
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let nftGradeLabel: UILabel = {
        let label = UILabel()
        label.text = "/ Moono week"
        label.textColor = .white
        label.font = BellyGomFont.header06
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let touchCountLabel: UILabel = {
        let label = UILabel()
        label.text = "129"
        label.textColor = .white
        label.font = BellyGomFont.header03
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var gameSKView: SKView = {
        let view = SKView()
        view.backgroundColor = AftermintColor.secondaryBackgroundNavy
        view.showsFPS = false
        view.showsNodeCount = false
        view.ignoresSiblingOrder = true
        return view
    }()
    
    private lazy var bottomSheetView: BottomSheetView = {
        let bottomSheet = BottomSheetView(frame: .zero, vm: leaderBoardViewModel)
        bottomSheet.bottomSheetColor = AftermintColor.backgroundNavy
        bottomSheet.barViewColor = .darkGray
        bottomSheet.translatesAutoresizingMaskIntoConstraints = false
        return bottomSheet
    }()
    
    private var tempTouchCountList: [String: Int64] {
        print("\(self.bottomSheetView.tempTouchCountList)")
        return self.bottomSheetView.tempTouchCountList
    }
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        setLayout()
        setGameScene()
        configureProfileInfo()
        
        self.bottomSheetView.bottomSheetDelegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationBarSetup()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    override func viewWillLayoutSubviews() {
        nftImageView.layer.cornerRadius = nftImageView.frame.size.width / 2
    }
    
    private func navigationBarSetup() {
        
        self.tabBarController?.navigationItem.setHidesBackButton(true, animated: false)
        self.tabBarController?.navigationItem.title = ""
        
        let logo = UIImage(named: "game_logo")
        let myImageView = UIImageView(image: logo)
        let leftBar: UIBarButtonItem = UIBarButtonItem(customView: myImageView)
        self.tabBarController?.navigationItem.leftBarButtonItem = leftBar
        self.tabBarController?.navigationItem.rightBarButtonItems = nil
    }
    
    // MARK: - Set UI & Layout
    private func setUI() {
        view.backgroundColor = AftermintColor.backgroundLightBlue
        view.addSubview(gameSKView)
        view.addSubview(nftImageView)
        view.addSubview(nftDataAndScoreStackView)
        view.addSubview(bottomSheetView)
        
        nftDataAndScoreStackView.addArrangedSubview(nftDataStackView)
        nftDataAndScoreStackView.addArrangedSubview(touchCountLabel)
        nftDataStackView.addArrangedSubview(nftNameLabel)
        nftDataStackView.addArrangedSubview(nftGradeLabel)
    }
    
    private func setLayout() {
        let viewHeight = view.frame.size.height
        gameSKView.frame = view.bounds
        NSLayoutConstraint.activate([
            self.nftImageView.topAnchor.constraint(equalToSystemSpacingBelow: view.safeAreaLayoutGuide.topAnchor, multiplier: 2),
            self.nftImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20.0),
            self.nftImageView.heightAnchor.constraint(equalToConstant: viewHeight / 14),
            self.nftImageView.widthAnchor.constraint(equalTo: self.nftImageView.heightAnchor),
            
            
            self.nftDataAndScoreStackView.leadingAnchor.constraint(equalToSystemSpacingAfter: self.nftImageView.trailingAnchor, multiplier: 1),
            self.nftDataAndScoreStackView.centerYAnchor.constraint(equalTo: self.nftImageView.centerYAnchor),
            
            self.bottomSheetView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            self.bottomSheetView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            self.bottomSheetView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            self.bottomSheetView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
}

// MARK: - Set GameScene
extension GameViewController {
    
    private func setGameScene() {
        let width = view.frame.size.width
        let height = view.frame.size.height
        let scene: MoonoGameScene = MoonoGameScene(size: CGSize(width: width, height: height), vm: gameSceneViewModel)
        scene.backgroundColor = AftermintColor.backgroundLightBlue
        scene.scaleMode = .aspectFit
        gameSKView.presentScene(scene)
    }
    
    private func configureProfileInfo() {
        let card = gameSceneViewModel.randomMoonoData
        let url = URL(string: card.imageUri)
        NukeImageLoader.loadImageUsingNuke(url: url) { image in
            self.nftImageView.image = image
        }
        self.nftNameLabel.text = "\(card.tokenId) "
    }
}

extension GameViewController: BottomSheetViewDelegate {
    
    func tempFetchData(data: [String : Int64]) {

        let count = data["Moono #81"]
        
        self.touchCountLabel.text = "\(count ?? 0)"
    } 
    
}
