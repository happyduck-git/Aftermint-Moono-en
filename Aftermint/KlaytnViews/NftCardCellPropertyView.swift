//
//  NftCardCellPropertyView.swift
//  Aftermint
//
//  Created by Platfarm on 2023/03/10.
//

import UIKit

final class NftCardCellPropertyView: UIView {
    
    private let propertiesStackView: UIStackView = {
       let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let accProperty: NftCardCellPropertyItemView = {
        let view = NftCardCellPropertyItemView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let backgroundProperty: NftCardCellPropertyItemView = {
        let view = NftCardCellPropertyItemView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private let bodyProperty: NftCardCellPropertyItemView = {
        let view = NftCardCellPropertyItemView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private let dayProperty: NftCardCellPropertyItemView = {
        let view = NftCardCellPropertyItemView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private let effectProperty: NftCardCellPropertyItemView = {
        let view = NftCardCellPropertyItemView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private let expressionProperty: NftCardCellPropertyItemView = {
        let view = NftCardCellPropertyItemView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private let hairProperty: NftCardCellPropertyItemView = {
        let view = NftCardCellPropertyItemView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - SetUI
    private func setUI() {
        self.addSubview(propertiesStackView)
        self.propertiesStackView.addArrangedSubview(accProperty)
        self.propertiesStackView.addArrangedSubview(backgroundProperty)
        self.propertiesStackView.addArrangedSubview(bodyProperty)
        self.propertiesStackView.addArrangedSubview(dayProperty)
        self.propertiesStackView.addArrangedSubview(effectProperty)
        self.propertiesStackView.addArrangedSubview(expressionProperty)
        self.propertiesStackView.addArrangedSubview(hairProperty)
    }
    
    private func setLayout() {
        NSLayoutConstraint.activate([
            self.propertiesStackView.topAnchor.constraint(equalTo: self.topAnchor),
            self.propertiesStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.propertiesStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.propertiesStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
    
    // MARK: - Public
    public func configure(
                          accDesc: String?,
                          backgroundDesc: String?,
                          bodyDesc: String?,
                          dayDesc: String?,
                          effectDesc: String?,
                          expressionDesc: String?,
                          hairDesc: String?
                          )
    {
        accProperty.configure(propertyName: "Accessories", propertyValue: accDesc ?? "N/A")
        backgroundProperty.configure(propertyName: "Background", propertyValue: backgroundDesc ?? "N/A")
        bodyProperty.configure(propertyName: "Body", propertyValue: bodyDesc ?? "N/A")
        dayProperty.configure(propertyName: "Day", propertyValue: dayDesc ?? "N/A")
        effectProperty.configure(propertyName: "Effect", propertyValue: effectDesc ?? "N/A")
        expressionProperty.configure(propertyName: "Expression", propertyValue: expressionDesc ?? "N/A")
        hairProperty.configure(propertyName: "Hair", propertyValue: hairDesc ?? "N/A")
    }
}
