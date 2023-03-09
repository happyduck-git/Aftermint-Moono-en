//
//  NFTCardView.swift
//  Aftermint
//
//  Created by HappyDuck on 2023/01/20.
//


import UIKit
import ReactorKit
import RxSwift
import RxCocoa
import Nuke

protocol NFTCardViewDelegate: AnyObject {
    func didTapTemplateButton()
}

class NFTCardView: UIView {
    
    var viewModel: NFTCardViewModel = NFTCardViewModel()
    var nftSelected: [Bool] = []
    
    // MARK: - UIElements
    
    weak var delegate: NFTCardViewDelegate?
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        
        stackView.axis = .horizontal
        stackView.spacing = 1.0
        stackView.accessibilityIdentifier = "nftCardStackView"
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let numbersOfNft: UILabel = {
        let label = UILabel()
        label.text = "3"
        label.font = BellyGomFont.header03
        label.textColor = AftermintColor.moonoBlue
        return label
    }()
    
    private let numbersOfNftDescription: UILabel = {
        let label = UILabel()
        label.text = "개의 벨리곰 NFT"
        label.font = BellyGomFont.header06
        label.textColor = .white
        return label
    }()
    
    private let nftCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(NftCardCell.self, forCellWithReuseIdentifier: NftCardCell.identifier)
        collectionView.accessibilityIdentifier = "nftCollectionView"
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = AftermintColor.backgroundNavy
        collectionView.alpha = 0.0
        return collectionView
        
    }()
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
        layout()
        setDelegate()
        
        bind()
        fetchBellyGomNft()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Set UI and Layout
    private func setUI() {
        self.addSubview(stackView)
        stackView.addArrangedSubview(numbersOfNft)
        stackView.addArrangedSubview(numbersOfNftDescription)
        
        self.addSubview(nftCollectionView)
    }
    
    private func setDelegate() {
        self.nftCollectionView.delegate = self
        self.nftCollectionView.dataSource = self
    }
    
    private func layout() {
        
        NSLayoutConstraint.activate([
            
            stackView.topAnchor.constraint(equalTo: self.topAnchor),
            stackView.leadingAnchor.constraint(equalToSystemSpacingAfter: self.leadingAnchor, multiplier: 1),
            
            nftCollectionView.topAnchor.constraint(equalTo: stackView.bottomAnchor),
            nftCollectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            nftCollectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            nftCollectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
            
        ])
        
        stackView.setContentHuggingPriority(.defaultHigh, for: .vertical)
    } 
    
}

//MARK: - CollectionView Delegate & DataSource

extension NFTCardView: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
      
        guard let numberOfNfts = viewModel.bellyGomNfts.value?.count else { return 0 }
        
        
        self.numbersOfNft.text = String(numberOfNfts)
        nftSelected = Array(repeating: false, count: numberOfNfts)
        
        return numberOfNfts

    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        guard let nft = viewModel.bellyGomNfts.value?[indexPath.row] else {
            fatalError("No nft value found")
        }
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NftCardCell.identifier, for: indexPath) as? NftCardCell else {
            fatalError("Unsupported cell")
        }
        
        if nftSelected[indexPath.row] == false {
            cell.resetCell()
        } else {
            cell.selectViewToHide(cardBackView: false, nftImageView: true)
        }
        
        cell.delegate = self
        
        cell.backgroundColor = .white
        
        makeCellRadius(of: cell)
        makeCellShadow(of: cell)
        
        let url = URL(string: nft.imageUrl)!
        
        ImagePipeline.shared.loadImage(with: url) { result in
            switch result {
            case .success(let imageResponse):
                cell.configureImage(image: imageResponse.image)
            case .failure(let failure):
                print("Nuke load image failed: \(failure)")
            }
        }
        
        DispatchQueue.main.async {
            
            UIView.animate(withDuration: 0.4) {
                self.nftCollectionView.alpha = 1.0
            }
            
            cell.configure(
                backgroundDesc: nft.traits.background,
                bodyDesc: nft.traits.body,
                clothesDesc: nft.traits.clothes,
                headDesc: nft.traits.head,
                accDesc: nft.traits.acc,
                specialDesc: nft.traits.special,
                
                name: nft.name,
                rank: nft.traits.rank,
                score: nft.score,
                updatedAt: nft.updateAt,
                grade: nft.traits.grade
            )
            
        }
        
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let viewFrameHeight = self.nftCollectionView.frame.size.height
        let viewFrameWidth = self.nftCollectionView.frame.size.width
        return CGSize(width: viewFrameWidth / 1.3, height: viewFrameHeight - 30)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! NftCardCell
        
        if nftSelected[indexPath.row] {
            nftSelected[indexPath.row] = false
            cell.selectViewToHide(cardBackView: true, nftImageView: false)

            UIView.transition(from: cell.cardBackView,
                              to: cell.cardFrontView,
                              duration: 0.3,
                              options: [.transitionFlipFromLeft, .showHideTransitionViews])
        } else {
            nftSelected[indexPath.row] = true
            cell.selectViewToHide(cardBackView: false, nftImageView: true)
        
            UIView.transition(from: cell.cardFrontView,
                              to: cell.cardBackView,
                              duration: 0.3,
                              options: [.transitionFlipFromLeft, .showHideTransitionViews])
        }
        
    }
    
    private func makeCellRadius(of cell: UICollectionViewCell) {
        cell.layer.cornerRadius = 20.0
        cell.layer.borderWidth = 1.0
        cell.layer.borderColor = UIColor(ciColor: .black).cgColor
    }
    
    private func makeCellShadow(of cell: UICollectionViewCell) {
        cell.layer.masksToBounds = false
        cell.layer.shadowRadius = 8.0
        cell.layer.shadowOpacity = 1
        cell.layer.shadowColor = UIColor(red: 0.696, green: 0.696, blue: 0.696, alpha: 0.5).cgColor
        cell.layer.shadowOffset = CGSize(width: 4, height: 4)
        cell.layer.shadowPath = UIBezierPath(roundedRect: CGRect(x: 4, y: 10, width: cell.frame.width, height: cell.frame.height - 10), cornerRadius: 20).cgPath
        cell.layer.shadowOffset = CGSize(width: 4, height: 4)
    }
    
    
 
}

//MARK: - ViewModel related

extension NFTCardView {
    
    private func bind() {
        viewModel.bellyGomNfts.bind { [weak self] _ in
            DispatchQueue.main.async {
                self?.nftCollectionView.reloadData()
            }
        }
    }
    
    private func fetchBellyGomNft() {
        let tempAddress: String = K.Wallet.temporaryAddress
        self.viewModel.getNfts(of: tempAddress) { nfts in
            self.viewModel.bellyGomNfts.value = nfts
        }
    }
}

//MARK: - NftCardCellDelegate

extension NFTCardView: NftCardCellDelegate {
    
    func didTapTemplateButton() {
        delegate?.didTapTemplateButton()
    }
    
}
