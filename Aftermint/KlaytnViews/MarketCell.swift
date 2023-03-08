//
//  MarketCell.swift
//  Aftermint
//
//  Created by Platfarm on 2023/02/06.
//

import UIKit

final class MarketCell: UICollectionViewCell {
    
    //MARK: - UI Elements
    private let nftImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "nftimage1")
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 8.0
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let nameStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 4.0
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private let rankLabel: UILabel = {
        let label = UILabel()
        label.text = "Belly"
        label.font = BellyGomFont.header05
        label.textColor = AftermintColor.bellyPink
        return label
    }()
    
    private let nftNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Bellygom #6517"
        label.font = BellyGomFont.header05
        label.textColor = AftermintColor.traitGrey
        return label
    }()
    
    private let priceLabel: UILabel = {
        let label = UILabel()
        label.text = "1,651,699 KLAY"
        label.font = BellyGomFont.header04
        label.textColor = AftermintColor.bellyTitleGrey
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
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
    
    //MARK: - Set UI & Layout
    private func setUI() {
        self.addSubview(nftImageView)
        self.addSubview(nameStackView)
        self.addSubview(priceLabel)
        nameStackView.addArrangedSubview(rankLabel)
        nameStackView.addArrangedSubview(nftNameLabel)
    }
    
    private func setLayout() {
        NSLayoutConstraint.activate([
            nftImageView.topAnchor.constraint(equalTo: self.topAnchor),
            nftImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            nftImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            nftImageView.heightAnchor.constraint(equalToConstant: self.frame.size.width),
            
            nameStackView.topAnchor.constraint(equalTo: nftImageView.bottomAnchor, constant: 12.0),
            nameStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            nameStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            
            priceLabel.topAnchor.constraint(equalTo: nameStackView.bottomAnchor, constant: 4.0),
            priceLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            priceLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            priceLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
        
        rankLabel.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        priceLabel.setContentHuggingPriority(.defaultHigh, for: .vertical)
    }
    
    public func configure(image: UIImage?) {
        nftImageView.image = image
    }
}
