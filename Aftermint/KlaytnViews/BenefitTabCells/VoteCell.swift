//
//  VoteCell.swift
//  Aftermint
//
//  Created by Platfarm on 2023/02/06.
//

import UIKit

class VoteCell: UICollectionViewCell {
    
    // MARK: - UI Elements
    private let wholeImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "benefit_vote")
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    // MARK: - Init
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
        self.addSubview(wholeImageView)
        
    }
    
    private func setLayout() {
        NSLayoutConstraint.activate([
        
            wholeImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 10.0),
            wholeImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10.0),
            wholeImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10.0),
            wholeImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10.0),
            
        ])
    }
    
}
