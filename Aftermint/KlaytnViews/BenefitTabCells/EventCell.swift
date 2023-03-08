//
//  EventCell.swift
//  Aftermint
//
//  Created by Platfarm on 2023/02/06.
//

import UIKit

class EventCell: UICollectionViewCell {
    
    // MARK: - UI Elements
    private let scrollView: UIScrollViewSuperTaps = {
        let scrollView = UIScrollViewSuperTaps()
        scrollView.showsVerticalScrollIndicator = false
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private lazy var wholeImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "benefit_event")
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        setUI()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Set UI & Layout
    private func setUI() {
        self.addSubview(scrollView)
        scrollView.addSubview(wholeImageView)
    }
    
    private func setLayout() {
        NSLayoutConstraint.activate([
        
            scrollView.topAnchor.constraint(equalTo: self.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
            wholeImageView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            wholeImageView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            wholeImageView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            wholeImageView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            wholeImageView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        ])
    }
    
    //MARK: - Configure
    public func configure(image: UIImage?) {
        wholeImageView.image = image
    }
    
}
