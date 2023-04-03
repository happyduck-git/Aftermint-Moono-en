//
//  WelcomeUpperView.swift
//  Aftermint
//
//  Created by HappyDuck on 2023/01/20.
//

import UIKit

class WelcomeUpperView: UIView {
    
    //Welcome + Name
    private let welcomeStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillProportionally
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    private let nameStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.spacing = 4.0
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    private let usernameLabel: UILabel = {
        let label = UILabel()
        label.font = BellyGomFont.header03
        label.textColor = .white
        label.text = HomeAsset.greetings.rawValue
        return label
    }()
    
    /// THIS UI PROPERTY IS NOT IN USE IN ENGLISH VER.
    private let courtesyTitleLabel: UILabel = {
        let label = UILabel()
        label.font = BellyGomFont.header03
        label.isHidden = true
        label.textColor = .white
        return label
    }()
    
    private let nameWelcomeStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let welcomeLabel: UILabel = {
        let label = UILabel()
        label.font = BellyGomFont.header03
        label.textColor = AftermintColor.moonoBlue
        label.text = HomeAsset.username.rawValue
        return label
    }()
    
    private let logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: HomeAsset.moonoLogo.rawValue)
        return imageView
    }()
    
    //Wallet + Connection
    private let walletConnectStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 4.0
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let walletImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: HomeAsset.kaikasIcon.rawValue)
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let walletNameLabel: UILabel = {
        let label = UILabel()
        label.text = HomeAsset.kaikas.rawValue
        label.font = .systemFont(ofSize: 12, weight: .bold)
        label.textColor = .white
        return label
    }()
    
    private let walletLabel: UILabel = {
        let label = UILabel()
        label.text = HomeAsset.nftWallet.rawValue
        label.font = .systemFont(ofSize: 12, weight: .medium)
        label.textColor = AftermintColor.bellyGrey
        label.textColor = .white
        return label
    }()
    
    private let connectCheckImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: HomeAsset.greenCheckmark.rawValue)
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func setUI() {
        
        self.addSubview(welcomeStackView)
        self.addSubview(walletConnectStackView)
        
        nameStackView.addArrangedSubview(usernameLabel)
        nameStackView.addArrangedSubview(courtesyTitleLabel)
        nameWelcomeStackView.addArrangedSubview(nameStackView)
        nameWelcomeStackView.addArrangedSubview(welcomeLabel)
        welcomeStackView.addArrangedSubview(nameWelcomeStackView)
        welcomeStackView.addArrangedSubview(logoImageView)
        
        walletConnectStackView.addArrangedSubview(walletImageView)
        walletConnectStackView.addArrangedSubview(walletNameLabel)
        walletConnectStackView.addArrangedSubview(walletLabel)
        walletConnectStackView.addArrangedSubview(connectCheckImageView)

    }
    
    private func layout() {
        NSLayoutConstraint.activate([
            welcomeStackView.topAnchor.constraint(equalTo: self.topAnchor),
            welcomeStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            welcomeStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            
            walletConnectStackView.topAnchor.constraint(equalTo: welcomeStackView.bottomAnchor, constant: 8.0),
            walletConnectStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            walletConnectStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
        
        walletImageView.setContentHuggingPriority(.defaultLow, for: .horizontal)
        connectCheckImageView.setContentHuggingPriority(.defaultLow, for: .horizontal)
    }
}
