//
//  NftCardUtilityCell.swift
//  Aftermint
//
//  Created by HappyDuck on 2023/01/25.
//

import UIKit

class NftCardUtilityCell: UITableViewCell {
    
    private let benefitAndValidityStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.layer.masksToBounds = true
        stackView.layer.cornerRadius = 8.0
        stackView.backgroundColor = AftermintColor.backgroundGrey
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let benefitStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.layer.masksToBounds = true
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let companyNameLabel: UILabel = {
        let label = UILabel()
        label.text = "롯데멤버스"
        label.font = BellyGomFont.header06
        label.textColor = AftermintColor.lightGrey
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let benefitLabel: UILabel = {
        let label = UILabel()
        label.text = "L. POINT 5천 포인트 교환권"
        label.font = BellyGomFont.header05
        label.textColor = AftermintColor.bellyTitleGrey
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let validLabel: UILabel = {
        let label = UILabel()
        label.text = "Invalid"
        label.font = BellyGomFont.header06
        label.textColor = AftermintColor.traitGrey
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setUI()
        setLayout()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Set UI and Layout
    
    private func setUI() {
        self.addSubview(benefitAndValidityStackView)
        benefitAndValidityStackView.addArrangedSubview(benefitStackView)
        benefitAndValidityStackView.addArrangedSubview(validLabel)
        benefitStackView.addArrangedSubview(companyNameLabel)
        benefitStackView.addArrangedSubview(benefitLabel)
    }
    
    private func setLayout() {
        let cellHeight = self.frame.size.height
        let cellWidth = self.frame.size.width
        
        benefitAndValidityStackView.spacing = cellWidth / 23.4
        
        NSLayoutConstraint.activate([
            
            benefitAndValidityStackView.topAnchor.constraint(equalTo: self.topAnchor, constant: cellHeight / 6.5),
            benefitAndValidityStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: cellWidth / 19.5),
            benefitAndValidityStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -(cellHeight / 6.5)),
            benefitAndValidityStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -(cellWidth / 19.5))
            
            
            /*
            benefitStackView.topAnchor.constraint(equalTo: self.topAnchor, constant: cellHeight / 6.5),
            benefitStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: cellWidth / 19.5),
            benefitStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -(cellHeight / 6.5)),
            
            validLabel.topAnchor.constraint(equalTo: benefitStackView.topAnchor),
            validLabel.bottomAnchor.constraint(equalTo: benefitStackView.bottomAnchor),
            validLabel.leadingAnchor.constraint(equalTo: benefitStackView.trailingAnchor, constant: cellWidth / 23.4),
            validLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -(cellWidth / 19.5))
            */
            
        ])
        
        companyNameLabel.setContentHuggingPriority(.defaultHigh, for: .vertical)
        validLabel.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        
        
        benefitAndValidityStackView.layoutMargins = UIEdgeInsets(top: 10.0, left: 10.0, bottom: 10.0, right: 10.0)
        benefitStackView.isLayoutMarginsRelativeArrangement = true
        benefitAndValidityStackView.isLayoutMarginsRelativeArrangement = true
    }
    
    
    public func configure(companyName: String, benefit: String, valid: IsValid) {
        self.companyNameLabel.text = companyName
        self.benefitLabel.text = benefit
        self.validLabel.text = valid.rawValue
    }
    
}
