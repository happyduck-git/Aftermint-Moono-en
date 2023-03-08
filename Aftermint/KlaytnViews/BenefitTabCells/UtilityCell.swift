//
//  UtilityCell.swift
//  Aftermint
//
//  Created by Platfarm on 2023/02/06.
//

import UIKit



class UtilityCell: UICollectionViewCell {
    
    // MARK: - UI Elements
    
    private let levelsImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "level_tags")
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let wholeScrollView: UIScrollViewSuperTaps = {
        let scrollView = UIScrollViewSuperTaps()
        scrollView.showsVerticalScrollIndicator = false
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    
    private lazy var wholeImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "benefit_utility")
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false

        return imageView
    }()
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = AftermintColor.backgroundGrey
        setUI()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Set UI & Layout
    private func setUI() {
        self.addSubview(levelsImageView)
        self.addSubview(wholeScrollView)
        wholeScrollView.addSubview(wholeImageView)
    }
    
    private func setLayout() {
        NSLayoutConstraint.activate([
        
            levelsImageView.topAnchor.constraint(equalTo: self.topAnchor),
            levelsImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            levelsImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            levelsImageView.heightAnchor.constraint(equalToConstant: 60.0),
            
            wholeScrollView.topAnchor.constraint(equalTo: levelsImageView.bottomAnchor),
            wholeScrollView.leadingAnchor.constraint(equalTo: wholeScrollView.leadingAnchor),
            wholeScrollView.trailingAnchor.constraint(equalTo: wholeScrollView.trailingAnchor),
            wholeScrollView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
            wholeImageView.topAnchor.constraint(equalTo: wholeScrollView.topAnchor),
            wholeImageView.leadingAnchor.constraint(equalTo: wholeScrollView.leadingAnchor),
            wholeImageView.trailingAnchor.constraint(equalTo: wholeScrollView.trailingAnchor),
            wholeImageView.bottomAnchor.constraint(equalTo: wholeScrollView.bottomAnchor),
            wholeImageView.widthAnchor.constraint(equalTo: wholeScrollView.widthAnchor)
            
        ])
    }
    
    //MARK: - Configure
    public func configure(image: UIImage?) {
        wholeImageView.image = image
    }
    
    
}

