//
//  NftCardCellPropertyItemView.swift
//  Aftermint
//
//  Created by Platfarm on 2023/03/10.
//

import UIKit

final class NftCardCellPropertyItemView: UIView {
    
    private let horizontalLine: UIView = {
        let view = UIView()
        view.backgroundColor = AftermintColor.secondaryTitleGrey
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let propertiesStackView: UIStackView = {
       let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let propertyName: UILabel = {
       let label = UILabel()
        label.textColor = AftermintColor.titleGrey
        label.font = BellyGomFont.header06
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let propertyValue: UILabel = {
       let label = UILabel()
        label.textColor = AftermintColor.bellyTitleGrey
        label.font = BellyGomFont.header07
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Set UI & Layout
    private func setUI() {
        self.addSubview(horizontalLine)
        self.addSubview(propertiesStackView)
        
        self.propertiesStackView.addArrangedSubview(propertyName)
        self.propertiesStackView.addArrangedSubview(propertyValue)
    }
    
    private func setLayout() {
        NSLayoutConstraint.activate([
            self.horizontalLine.heightAnchor.constraint(equalToConstant: 1),
            self.horizontalLine.topAnchor.constraint(equalTo: self.topAnchor),
            self.horizontalLine.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.horizontalLine.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.propertiesStackView.topAnchor.constraint(equalTo: self.horizontalLine.bottomAnchor),
            self.propertiesStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.propertiesStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.propertiesStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
        
    }
    
    // MARK: - Public
    
    public func configure(propertyName: String, propertyValue: String) {
        self.propertyName.text = propertyName
        self.propertyValue.text = propertyValue
    }
    
}
