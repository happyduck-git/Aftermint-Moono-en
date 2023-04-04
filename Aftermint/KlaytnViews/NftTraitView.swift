//
//  NftNameAndButtonView.swift
//  Aftermint
//
//  Created by HappyDuck on 2023/01/21.
//

import UIKit

protocol NftTraitViewDelegate: AnyObject {
    func didTapTemplateButton()
}

final class NftTraitView: UIView {
    
    weak var delegate: NftTraitViewDelegate?
        
    //MARK: - UI elements
    
    // Nft name and level
    private let nameAndLevelStack: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.spacing = 8.0
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let levelImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "level_belly")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let nftName: UILabel = {
        let label = UILabel()
        label.text = "Bellygom #1920"
        label.font = BellyGomFont.header04
        label.textColor = AftermintColor.bellyTitleGrey
        return label
    }()
    
    private lazy var frontButton: UIButton = {
        let button = UIButton()
        let image = UIImage(named: HomeAsset.decoButton.rawValue)
        button.setImage(image, for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        button.addTarget(self, action: #selector(presentTemplateVC), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var backButton: UIButton = {
        let button = UIButton()
        let image = UIImage(named: HomeAsset.openseaButton.rawValue)
        button.isHidden = true
        button.setImage(image, for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        button.addTarget(self, action: #selector(goToOpensea), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    //nft traits
    private let withMeStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let withMeLabel: UILabel = {
        let label = UILabel()
        label.text = "With me"
        label.font = BellyGomFont.header06
        label.textColor = AftermintColor.traitGrey
        return label
    }()
    
    private let withMeNumLabel: UILabel = {
        let label = UILabel()
        label.text = "D+ 291"
        label.font = BellyGomFont.header05
        label.textColor = AftermintColor.titleBlue
        return label
    }()
    
    private let verticalLine1: UIView = {
        let view = UIView()
        view.backgroundColor = AftermintColor.backgroundGrey
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    //MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)

        setUI()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// Change cardButton
    /// - Parameter front: Value to check if the card view is front
    public func changeCardButton(isCardFront front: Bool) {
        if front {
            self.frontButton.isHidden = false
            self.backButton.isHidden = true
        } else {
            self.frontButton.isHidden = true
            self.backButton.isHidden = false
        }
    }
    
    //MARK: - Set up UI and Layout
    private func setUI() {
        
        self.addSubview(nameAndLevelStack)
        self.addSubview(frontButton)
        self.addSubview(backButton)
        nameAndLevelStack.addArrangedSubview(levelImageView)
        nameAndLevelStack.addArrangedSubview(nftName)

        self.addSubview(withMeStackView)
        withMeStackView.addArrangedSubview(withMeLabel)
        withMeStackView.addArrangedSubview(withMeNumLabel)
        
        self.addSubview(verticalLine1)
        
    }
    
    private func setLayout() {
        
        NSLayoutConstraint.activate([
            
            nameAndLevelStack.topAnchor.constraint(equalTo: self.topAnchor),
            nameAndLevelStack.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            
            frontButton.topAnchor.constraint(equalTo: nameAndLevelStack.topAnchor),
            frontButton.leadingAnchor.constraint(equalTo: nameAndLevelStack.trailingAnchor, constant: 44),
            frontButton.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            frontButton.bottomAnchor.constraint(equalTo: nameAndLevelStack.bottomAnchor),
            
            backButton.topAnchor.constraint(equalTo: frontButton.topAnchor),
            backButton.leadingAnchor.constraint(equalTo: frontButton.leadingAnchor),
            backButton.trailingAnchor.constraint(equalTo: frontButton.trailingAnchor),
            backButton.bottomAnchor.constraint(equalTo: frontButton.bottomAnchor),

            withMeStackView.topAnchor.constraint(equalTo: nameAndLevelStack.bottomAnchor, constant: 15),
            withMeStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            withMeStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
            verticalLine1.topAnchor.constraint(equalTo: nameAndLevelStack.bottomAnchor, constant: 23),
            verticalLine1.widthAnchor.constraint(equalToConstant: 1),
            verticalLine1.leadingAnchor.constraint(equalTo: withMeStackView.trailingAnchor, constant: 11.5),
            verticalLine1.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -5),

        ])
        
        withMeLabel.setContentHuggingPriority(.defaultLow, for: .vertical)
        
        verticalLine1.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        
    }
    
    @objc private func presentTemplateVC() {
        delegate?.didTapTemplateButton()
    }
    
    @objc private func goToOpensea() {
        print("Add logic to open OpenSea website...")
    }
    
    public func configure(name: String?,
                          updatedAt: Int64?
                       ) {
        
        self.nftName.text = name ?? "Moono #618"
        self.withMeNumLabel.text = "D+ " + String(calculateNumberOfDays(since: updatedAt ?? 0))
        self.levelImageView.image = UIImage(named: HomeAsset.levelLogo.rawValue)
        
    }
    
    private func calculateNumberOfDays(since endDate: Int64) -> Int {
        let currentDate: Int = Int(Date().timeIntervalSince1970)
        let numberOfDays: Int = (currentDate - Int(endDate)) / 3600 / 24
        return numberOfDays
    }
}
