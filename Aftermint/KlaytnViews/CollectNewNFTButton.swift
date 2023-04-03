//
//  CollectNewNFTButton.swift
//  Aftermint
//
//  Created by HappyDuck on 2023/01/20.
//

import UIKit

final class CollectNewNFTButton: UIButton {
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.spacing = 151.0
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let collectNftLabel: UILabel = {
        let label = UILabel()
        label.text = HomeAsset.collectButtonTitle.rawValue
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = AftermintColor.lightGrey
        return label
    }()
    
    private let arrowImageView: UIImageView = {
       let imageView = UIImageView()
        imageView.image = UIImage(named: "arrowright")
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
        self.addSubview(stackView)
        stackView.addArrangedSubview(collectNftLabel)
        stackView.addArrangedSubview(arrowImageView)
    }
    
    private func layout() {
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: self.topAnchor, constant: 8),
            stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            self.trailingAnchor.constraint(equalTo: stackView.trailingAnchor, constant: 20),
            self.bottomAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 8)
        ])
        
        arrowImageView.setContentHuggingPriority(.defaultHigh, for: .horizontal)
    }
}
