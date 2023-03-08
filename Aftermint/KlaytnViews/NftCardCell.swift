//
//  NftCardCellBack.swift
//  Aftermint
//
//  Created by HappyDuck on 2023/01/22.
//

import UIKit

protocol NftCardCellDelegate: AnyObject {
    func didTapTemplateButton()
}

class NftCardCell: UICollectionViewCell {
    
    weak var delegate: NftCardCellDelegate?

    //MARK: - UI Elements
    
    internal let cardBackView: NftCardCellBackView = {
        let view = NftCardCellBackView()
        view.isHidden = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    internal let cardFrontView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "bellygom_test")
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 20.0
        imageView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let traitView: NftTraitView = {
        let view = NftTraitView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private var traitButtonImage: UIImage? {
        if !cardFrontView.isHidden {
            return UIImage(named: "front_deco_button")
        } else {
            return UIImage(named: "back_opensea_button")
        }
    }
    
    //MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        
        setUI()
        setLayout()

        traitView.delegate = self
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    //MARK: - Set UI and Layout
    
    private func setUI() {
        
        self.addSubview(cardBackView)
        self.addSubview(cardFrontView)
        
        self.addSubview(traitView)
        
    }
    
    
    private func setLayout() {
        
        NSLayoutConstraint.activate([
            
            cardBackView.topAnchor.constraint(equalTo: self.topAnchor),
            cardBackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 5),
            cardBackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -5),
            cardBackView.heightAnchor.constraint(equalToConstant: self.frame.size.width),
            
            cardFrontView.topAnchor.constraint(equalTo: self.topAnchor),
            cardFrontView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            cardFrontView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            cardFrontView.heightAnchor.constraint(equalToConstant: self.frame.size.width),
            
            traitView.topAnchor.constraint(equalTo: cardBackView.bottomAnchor, constant: 10),
            traitView.topAnchor.constraint(equalTo: cardFrontView.bottomAnchor, constant: 10),
            traitView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            traitView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -20)
            
        ])
        
    }
    
    //MARK: - Configuration
    public func configure(backgroundDesc: String,
                          bodyDesc: String,
                          clothesDesc: String,
                          headDesc: String,
                          accDesc: String,
                          specialDesc: String,
                          
                          name: String,
                          rank: Int,
                          score: Int,
                          updatedAt: Int64,
                          grade: BellyGomNft.GradeType
    ) {
        self.cardBackView.propertyView.configure(backgroundDesc: backgroundDesc,
                                    bodyDesc: bodyDesc,
                                    clothesDesc: clothesDesc,
                                    headDesc: headDesc,
                                    accDesc: accDesc,
                                    specialDesc: specialDesc)
        
        self.traitView.configure(name: name,
                                 rank: rank,
                                 score: score,
                                 updatedAt: updatedAt,
                                 grade: grade)
    }
    
    internal func configureImage(image: UIImage) {
        self.cardFrontView.image = image
    }
    
    internal func selectViewToHide(cardBackView hideCardBackView: Bool, nftImageView hideNftImageView: Bool) {
        self.cardBackView.isHidden = hideCardBackView
        self.cardFrontView.isHidden = hideNftImageView
        self.traitView.changeCardButtonImage(with: traitButtonImage)
    }
    
    internal func resetCell() {
        self.cardBackView.propertyView.configure(backgroundDesc: nil, bodyDesc: nil, clothesDesc: nil, headDesc: nil, accDesc: nil, specialDesc: nil)
        self.traitView.configure(name: nil, rank: nil, score: nil, updatedAt: nil, grade: nil)
        self.traitView.cardButton.imageView?.image = UIImage(named: "front_deco_button")
        self.cardFrontView.image = nil
        
        self.cardFrontView.isHidden = false
        self.cardBackView.isHidden = true
        
    }
    
}

extension NftCardCell: NftTraitViewDelegate {
    
    func didTapTemplateButton() {
        delegate?.didTapTemplateButton()
    }
    
}
