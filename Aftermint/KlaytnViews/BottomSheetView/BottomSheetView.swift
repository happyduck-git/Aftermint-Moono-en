//
//  BottomSheetView.swift
//  Aftermint
//
//  Created by Platfarm on 2023/03/20.
//

import UIKit

final class BottomSheetView: PassThroughView {
    
    var viewModel: LeaderBoardTableViewCellListViewModel = LeaderBoardTableViewCellListViewModel()

    // MARK: - UI Elements
    
    let bottomSheetView: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let barView: UIView = {
        let view = UIView()
        view.backgroundColor = .darkGray
        view.clipsToBounds = true
        view.isUserInteractionEnabled = false
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let leaderBoardStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 15
        stack.distribution = .fillProportionally
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private let leaderBoardLogoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: LeaderBoard.markImageName.rawValue)
        return imageView
    }()
    
    private let leaderBoardLabel: UILabel = {
        let label = UILabel()
        label.font = BellyGomFont.header03
        label.textColor = .white
        label.text = LeaderBoard.title.rawValue
        return label
    }()
    
    private let leaderBoardTableView: UITableView = {
        let table = UITableView()
        table.backgroundColor = AftermintColor.backgroundNavy
        table.register(LeaderBoardTableViewCell.self, forCellReuseIdentifier: LeaderBoardTableViewCell.identifier)
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()

    // MARK: - Properties
    var mode: Mode = .tip {
        didSet {
            switch self.mode {
            case .tip:
                break
            case .full:
                break
            }
            self.updateConstraint(offset: Const.bottomSheetYPosition(self.mode))
        }
    }
    
    var bottomSheetColor: UIColor? {
        didSet { self.bottomSheetView.backgroundColor = self.bottomSheetColor }
    }
    
    var barViewColor: UIColor? {
        didSet { self.barView.backgroundColor = self.barViewColor }
    }
    
 // MARK: - Initializer
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init() has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = .clear
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(didPan))
        self.addGestureRecognizer(panGesture)
        
        self.bottomSheetView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        self.bottomSheetView.layer.cornerRadius = Const.cornerRadius
        self.bottomSheetView.clipsToBounds = true
        
        setUI()
        setLayout()
        setDelegate()
        dummyViewModelGenerator()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let height = self.barView.bounds.size.height
        self.barView.layer.cornerRadius = height / 2
    }
    
    // MARK: - SetUI & Layout
    
    private func setUI() {
        
        self.addSubview(self.bottomSheetView)
        self.bottomSheetView.addSubview(self.barView)
        self.bottomSheetView.addSubview(leaderBoardStackView)
        self.bottomSheetView.addSubview(leaderBoardTableView)
        self.leaderBoardStackView.addArrangedSubview(leaderBoardLogoImageView)
        self.leaderBoardStackView.addArrangedSubview(leaderBoardLabel)
        
        leaderBoardTableView.separatorColor = AftermintColor.separatorNavy
    }
    
    private func setLayout() {
        
        NSLayoutConstraint.activate([
            self.bottomSheetView.topAnchor.constraint(equalTo: self.topAnchor, constant: Const.bottomSheetYPosition(.tip)),
            self.bottomSheetView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.bottomSheetView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.bottomSheetView.bottomAnchor.constraint(equalTo: self.bottomAnchor),

            self.barView.topAnchor.constraint(equalTo: self.bottomSheetView.topAnchor, constant: Const.barViewTopSpacing),
            self.barView.widthAnchor.constraint(equalToConstant: 100),
            self.barView.heightAnchor.constraint(equalToConstant: Const.barViewSize),
            self.barView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            
            self.leaderBoardStackView.topAnchor.constraint(equalToSystemSpacingBelow: barView.bottomAnchor, multiplier: 4),
            self.leaderBoardStackView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            
            self.leaderBoardTableView.topAnchor.constraint(equalToSystemSpacingBelow: self.leaderBoardStackView.bottomAnchor, multiplier: 2),
            self.leaderBoardTableView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.leaderBoardTableView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.leaderBoardTableView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
        
    }
    
    // MARK: Methods
    @objc private func didPan(_ recognizer: UIPanGestureRecognizer) {
        let translationY = recognizer.translation(in: self).y
        let minY = self.bottomSheetView.frame.minY
        let offset = translationY + minY
        
        if Const.bottomSheetYPosition(.full)...Const.bottomSheetYPosition(.tip) ~= offset {
            self.updateConstraint(offset: offset)
            recognizer.setTranslation(.zero, in: self)
        }
        
        UIView.animate(
            withDuration: 0,
            delay: 0,
            options: .curveEaseOut,
            animations: self.layoutIfNeeded,
            completion: nil
        )
        
        guard recognizer.state == .ended else { return }
        UIView.animate(
            withDuration: Const.duration,
            delay: 0,
            options: .allowUserInteraction,
            animations: {
                // velocity를 이용하여 위로 스와이프인지, 아래로 스와이프인지 확인
                self.mode = recognizer.velocity(in: self).y >= 0 ? Mode.tip : .full
            },
            completion: nil
        )
    }
    
    private func updateConstraint(offset: Double) {
        
        NSLayoutConstraint.activate([
            self.bottomSheetView.topAnchor.constraint(equalTo: self.topAnchor, constant: offset),
            self.bottomSheetView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.bottomSheetView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.bottomSheetView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
        
    }
}

// MARK: - TableView Delegate & DataSource
extension BottomSheetView: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.numberOfRowsInSection(at: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: LeaderBoardTableViewCell.identifier) as? LeaderBoardTableViewCell else { fatalError("Unsupported Cell") }
        
        let vm = self.viewModel.modelAt(indexPath.row)
        cell.configure(with: vm)
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    
    /* TEMP */
    private func dummyViewModelGenerator() {
        let vm = LeaderBoardTableViewCellViewModel(rankImage: "1st_place_medal",
                                                   nftImage: "nftimage1",
                                                   nftName: "Moono #100",
                                                   touchScore: 10)
        for _ in 0...10 {
            self.viewModel.viewModelList.append(vm)
        }
        
        DispatchQueue.main.async {
            self.leaderBoardTableView.reloadData()
        }
    }
    
    private func setDelegate() {
        leaderBoardTableView.delegate = self
        leaderBoardTableView.dataSource = self
    }
    
}

// MARK: - Enums
extension BottomSheetView {
    // MARK: Constants
    enum Mode {
        case tip
        case full
    }
    
    private enum Const {
        static let duration = 0.5
        static let cornerRadius = 12.0
        static let barViewTopSpacing = 5.0
        static let barViewSize = CGSize(width: UIScreen.main.bounds.width * 0.2, height: 5.0)
        static let bottomSheetRatio: (Mode) -> Double = { mode in
            switch mode {
            case .tip:
                return 0.5 // 위에서 부터의 값 (밑으로 갈수록 값이 커짐)
            case .full:
                return 0.1
            }
        }
        static let bottomSheetYPosition: (Mode) -> Double = { mode in
            Self.bottomSheetRatio(mode) * UIScreen.main.bounds.height
        }
    }
}
