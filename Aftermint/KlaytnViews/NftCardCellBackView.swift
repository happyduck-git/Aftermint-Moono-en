//
//  NftCardCellBackView.swift
//  Aftermint
//
//  Created by HappyDuck on 2023/01/31.
//

import UIKit

class NftCardCellBackView: UIView {
    
    //MARK: - UIElements

    private let propertyLabel: UILabel = {
        let label = UILabel()
        label.text = "Properties"
        label.font = BellyGomFont.header04
        label.textColor = AftermintColor.bellyTitleGrey
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
        
    let propertyView: NftCardCellPropertyView = {
        let view = NftCardCellPropertyView()
        view.backgroundColor = .white
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

    
    private func setUI() {
        self.addSubview(propertyLabel)
        self.addSubview(propertyView)
    }
    
    private func setLayout() {
        
        NSLayoutConstraint.activate([
            propertyLabel.topAnchor.constraint(equalToSystemSpacingBelow: self.topAnchor, multiplier: 3),
            propertyLabel.leadingAnchor.constraint(equalToSystemSpacingAfter: self.leadingAnchor, multiplier: 2),
            
            propertyView.topAnchor.constraint(equalToSystemSpacingBelow: propertyLabel.bottomAnchor, multiplier: 2),
            propertyView.leadingAnchor.constraint(equalTo: propertyLabel.leadingAnchor),
            self.trailingAnchor.constraint(equalToSystemSpacingAfter: propertyView.trailingAnchor, multiplier: 2),
            propertyView.bottomAnchor.constraint(equalTo: self.bottomAnchor)

        ])
        
        propertyLabel.setContentHuggingPriority(.defaultHigh, for: .vertical)
    }
    
}

