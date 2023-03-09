//
//  MarketDetailViewController.swift
//  Aftermint
//
//  Created by HappyDuck on 2023/02/06.
//

import UIKit

class MarketDetailViewController: UIViewController {
    
    
    // MARK: - UI Elements
    
    private let scrollView: UIScrollView = {
        let view = UIScrollView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var nftImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 16.0
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "nftimage1")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let nameStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 8.0
        stack.distribution = .fillProportionally
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private let levelLabel: UILabel = {
        let label = UILabel()
        label.font = BellyGomFont.header04
        label.text = "Belly"
        label.textColor = AftermintColor.bellyPink
        return label
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = BellyGomFont.header03
        label.text = "Bellygom #6517"
        label.textColor = AftermintColor.bellyTitleGrey
        return label
    }()
    
    private let priceStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 8.0
        stack.distribution = .fillProportionally
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private let priceLabel: UILabel = {
        let label = UILabel()
        label.font = BellyGomFont.header02
        label.textColor = AftermintColor.bellyGreen
        label.text = "1,651,699 KLAY"
        return label
    }()
    
    private let onSaleLabel: UILabel = {
        let label = UILabel()
        label.font = BellyGomFont.header04
        label.textColor = AftermintColor.bellyGreen
        label.text = "에 판매 중"
        return label
    }()
    
    private let monetaryStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 8.0
        stack.distribution = .fillProportionally
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    
    private let dollarLabel: UILabel = {
        let label = UILabel()
        label.textColor = AftermintColor.traitGrey
        label.font = UIFont.systemFont(ofSize: 12.0)
        label.text = "$346,468.64"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let verticalLineShort: UIView = {
        let view = UIView()
        view.backgroundColor = AftermintColor.backgroundGrey
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let wonLabel: UILabel = {
        let label = UILabel()
        label.textColor = AftermintColor.traitGrey
        label.font = UIFont.systemFont(ofSize: 12.0)
        label.text = "₩425,913,899"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let verticalLineLong1: UIView = {
        let view = UIView()
        view.backgroundColor = AftermintColor.backgroundGrey
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let rankingStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private let rankingLabel: UILabel = {
        let label = UILabel()
        label.text = "Ranking"
        label.font = BellyGomFont.header06
        label.textColor = AftermintColor.traitGrey
        return label
    }()
    
    private let rankingNumLabel: UILabel = {
        let label = UILabel()
        label.text = "6"
        label.font = BellyGomFont.header05
        label.textColor = AftermintColor.bellyPink
        return label
    }()
    
    private let verticalLineLong2: UIView = {
        let view = UIView()
        view.backgroundColor = AftermintColor.backgroundGrey
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let scoreStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private let scoreLabel: UILabel = {
        let label = UILabel()
        label.text = "Score"
        label.font = BellyGomFont.header06
        label.textColor = AftermintColor.traitGrey
        return label
    }()
    
    private let scoreNumLabel: UILabel = {
        let label = UILabel()
        label.text = "2594"
        label.font = BellyGomFont.header05
        label.textColor = AftermintColor.bellyBlue
        return label
    }()
    
    private let propertyStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 16.0
        stack.layoutMargins = UIEdgeInsets(top: 24.0, left: 20.0, bottom: 24.0, right: 20.0)
        stack.isLayoutMarginsRelativeArrangement = true
        stack.distribution = .fillProportionally
        stack.backgroundColor = AftermintColor.backgroundGrey
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private let propertyLabel: UILabel = {
        let label = UILabel()
        label.text = "Properties"
        
        label.textColor = AftermintColor.bellyTitleGrey
        return label
    }()
    
    private let propertyView: PropertyView = {
        let view = PropertyView()
        return view
    }()
    
    
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = AftermintColor.backgroundNavy
        
        setUI()
        setLayout()
        setBarButtonItem()
        
        propertyView.configure(backgroundDesc: "Aurora",
                               bodyDesc: "Belly Pink",
                               clothesDesc: "None",
                               headDesc: "None",
                               accDesc: "None",
                               specialDesc: "Shark")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    // MARK: - Setup UI & Layout
    private func setUI() {
        
        /* ScrollView */
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        /* Other elements */
        contentView.addSubview(nftImageView)
        contentView.addSubview(nameStackView)
        contentView.addSubview(priceStackView)
        contentView.addSubview(monetaryStackView)
        contentView.addSubview(verticalLineLong1)
        contentView.addSubview(rankingStack)
        contentView.addSubview(verticalLineLong2)
        contentView.addSubview(scoreStack)
        contentView.addSubview(propertyStackView)
        
        nameStackView.addArrangedSubview(levelLabel)
        nameStackView.addArrangedSubview(nameLabel)
        priceStackView.addArrangedSubview(priceLabel)
        priceStackView.addArrangedSubview(onSaleLabel)
        monetaryStackView.addArrangedSubview(dollarLabel)
        monetaryStackView.addArrangedSubview(verticalLineShort)
        monetaryStackView.addArrangedSubview(wonLabel)
        rankingStack.addArrangedSubview(rankingLabel)
        rankingStack.addArrangedSubview(rankingNumLabel)
        scoreStack.addArrangedSubview(scoreLabel)
        scoreStack.addArrangedSubview(scoreNumLabel)
        propertyStackView.addArrangedSubview(propertyLabel)
        propertyStackView.addArrangedSubview(propertyView)
        
    }
    
    private func setLayout() {
        
        /* ScrollView */
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        ])
        
        /* Other elements */
        NSLayoutConstraint.activate([
            
            nftImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            nftImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: view.frame.size.width / 18.75),
            nftImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -(view.frame.size.width / 18.75)),
            nftImageView.heightAnchor.constraint(equalTo: nftImageView.widthAnchor),
            nftImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            
            nameStackView.topAnchor.constraint(equalTo: nftImageView.bottomAnchor, constant: 24.0),
            nameStackView.leadingAnchor.constraint(equalTo: nftImageView.leadingAnchor),
            
            priceStackView.topAnchor.constraint(equalTo: nameStackView.bottomAnchor, constant: 4.0),
            priceStackView.leadingAnchor.constraint(equalTo: nftImageView.leadingAnchor),
            
            verticalLineShort.widthAnchor.constraint(equalToConstant: 1.0),
            
            monetaryStackView.topAnchor.constraint(equalTo: priceStackView.bottomAnchor),
            monetaryStackView.leadingAnchor.constraint(equalTo: priceStackView.leadingAnchor),
            
            verticalLineLong1.topAnchor.constraint(equalTo: monetaryStackView.bottomAnchor, constant: 24.0),
            verticalLineLong1.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20.0),
            verticalLineLong1.widthAnchor.constraint(equalToConstant: 1.0),
            verticalLineLong1.heightAnchor.constraint(equalToConstant: 36.0),
            
            rankingStack.topAnchor.constraint(equalTo: verticalLineLong1.topAnchor),
            rankingStack.leadingAnchor.constraint(equalTo: verticalLineLong1.trailingAnchor, constant: 16.0),
            
            verticalLineLong2.topAnchor.constraint(equalTo: verticalLineLong1.topAnchor),
            verticalLineLong2.widthAnchor.constraint(equalToConstant: 1.0),
            verticalLineLong2.leadingAnchor.constraint(equalTo: rankingStack.trailingAnchor, constant: 115.0),
            verticalLineLong2.heightAnchor.constraint(equalTo: verticalLineLong1.heightAnchor),
            
            scoreStack.topAnchor.constraint(equalTo: verticalLineLong1.topAnchor),
            scoreStack.leadingAnchor.constraint(equalTo: verticalLineLong2.trailingAnchor, constant: 16.0),
            
            propertyStackView.topAnchor.constraint(equalTo: rankingStack.bottomAnchor, constant: 24.0),
            propertyStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            propertyStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            propertyStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -24.0),
            
        ])
        
        nameLabel.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        rankingStack.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        propertyLabel.setContentHuggingPriority(.defaultHigh, for: .vertical)
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
