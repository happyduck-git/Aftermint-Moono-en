//
//  KlaytnHomeViewController.swift
//  Aftermint
//
//  Created by Platfarm on 2023/01/20.
//

import UIKit

class KlaytnHomeViewController: UIViewController {
    
    //MARK: - UIElements
    
    private let welcomeUpperView: WelcomeUpperView = {
        let view = WelcomeUpperView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let nftCardView: NFTCardView = {
        let cardView = NFTCardView()
        cardView.accessibilityIdentifier = "nftCardView"
        cardView.translatesAutoresizingMaskIntoConstraints = false
        return cardView
    }()
    
    private let collectNewNFTButton: CollectNewNFTButton = {
        let button = CollectNewNFTButton()
        button.backgroundColor = AftermintColor.backgroundGrey
        button.layer.cornerRadius = 8
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    //MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nftCardView.delegate = self
        view.backgroundColor = .white
        
        view.addSubview(welcomeUpperView)
        view.addSubview(nftCardView)
        view.addSubview(collectNewNFTButton)
        layout()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("KHVC will appear")
        
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print("KHVC will disappear")
        self.navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    //MARK: - Set up UI & Layout
    
    private func layout() {
        let tabBarHeight = view.frame.size.height / 8.2
        let viewFrameHeight = view.frame.size.height
        let viewFrameWidth = view.frame.size.width
        
        NSLayoutConstraint.activate([
            
            welcomeUpperView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: viewFrameHeight / 32.48),
            welcomeUpperView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: viewFrameWidth / 18.7),
            welcomeUpperView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -(viewFrameWidth / 20.7)),
            welcomeUpperView.heightAnchor.constraint(equalToConstant: viewFrameHeight / 10.1),
            
            nftCardView.topAnchor.constraint(equalTo: welcomeUpperView.bottomAnchor, constant: viewFrameHeight / 29),
            nftCardView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: viewFrameWidth / 18.7),
            nftCardView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            collectNewNFTButton.topAnchor.constraint(equalTo: nftCardView.bottomAnchor, constant: viewFrameHeight / 35.0),
            collectNewNFTButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: viewFrameWidth / 18.7),
            collectNewNFTButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -(viewFrameWidth / 18.7)),
            collectNewNFTButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -((viewFrameHeight / 33.8)+tabBarHeight))

            
        ])
        welcomeUpperView.setContentHuggingPriority(.defaultHigh, for: .vertical)
        nftCardView.setContentHuggingPriority(.defaultLow, for: .vertical)
        collectNewNFTButton.setContentHuggingPriority(.defaultHigh, for: .vertical)
    }
    
}

extension KlaytnHomeViewController: NFTCardViewDelegate {

    
    func didTapTemplateButton() {
        
        let templateVC: LottieViewController = LottieViewController(reactor: makeMockMoonoReactorByGall3ry3())
        navigationController?.pushViewController(templateVC, animated: true)
        
    }
}

// MARK: Extension for Lottie player of Gall3ry3
extension KlaytnHomeViewController {
    
    private func makeReactorByGall3ry3(nft: BellyGomNft) -> LottieViewReactor {
        let appDependency = AppDependency.resolve()
        return appDependency.homeViewReactor.dependency
            .lottieViewReactorFactory.create(
                payload: .init(nft: makeOpenSeaNftByGall3ry3(bellyGomNft: nft), format: .video)
            )
    }
    
    private func makeMockReactorByGall3ry3() -> LottieViewReactor {
        let appDependency = AppDependency.resolve()
        return appDependency.homeViewReactor.dependency
            .lottieViewReactorFactory.create(
                payload: .init(nft: makeMockOpenSeaNftByGall3ry3(), format: .video)
            )
    }
    
    private func makeOpenSeaNftByGall3ry3(bellyGomNft: BellyGomNft) -> OpenSeaNFT {
        let collectionTitle = "Bellygom World Official"
        let collectionProfileImageUrl = "https://i.seadn.io/gcs/files/ed4380136946111c0a73f0f18ede3700.gif?auto=format&w=256"
        let nftOwnerAddress = "0xBEeBb41496BE8385291886928725d1c2bD9aBA42"
        
        let openSeaPaymentToken = OpenSeaPaymentToken(
            eth_price: "1.000000000000000"
        )
        let openSeaNftLastSale = OpenSeaNFTLastSale(
            total_price: "31000000000000000",
            payment_token: openSeaPaymentToken
        )
        let openSeaNftCollection = OpenSearNFTCollection(
            name: collectionTitle,
            image_url: collectionProfileImageUrl,
            slug: "BGom"
        )
        let openSeaCreator = OpenSeaCreator(
            user: OpenseaUser(username: collectionTitle)
        )
        let openSeaNftOwner = OpenSeaNFTOwner(
            user: OpenSeaNFTOwner.OpenSeaNFTUser(username: nftOwnerAddress),
            profile_img_url: "https://storage.googleapis.com/opensea-static/opensea-profile/28.png",
            address: nftOwnerAddress
        )
        
        return OpenSeaNFT(
            id: Int(bellyGomNft.tokenId) ?? -1,
            owner: openSeaNftOwner,
            name: bellyGomNft.name,
            permalink: "https://opensea.io/assets/klaytn/0xce70eef5adac126c37c8bc0c1228d48b70066d03/\(bellyGomNft.tokenIdInteger)",
            sell_orders: nil,
            last_sale: openSeaNftLastSale,
            collection: openSeaNftCollection,
            creator: openSeaCreator,
            price: nil,
            tokenID: bellyGomNft.tokenId,
            description: bellyGomNft.description,
            imageURLString: bellyGomNft.imageUrl
        )
    }
    
    private func makeMockOpenSeaNftByGall3ry3() -> OpenSeaNFT {
        let openSeaPaymentToken = OpenSeaPaymentToken(
            eth_price: "1.000000000000000"
        )
        let openSeaNftLastSale = OpenSeaNFTLastSale(
            total_price: "31000000000000000",
            payment_token: openSeaPaymentToken
        )
        let openSeaNftCollection = OpenSearNFTCollection(
            name: "Bellygom World Official",
            image_url: "https://i.seadn.io/gcs/files/ed4380136946111c0a73f0f18ede3700.gif?auto=format&w=384",
            slug: "thebonsaiassemblance"
        )
        let openSeaCreator = OpenSeaCreator(
            user: OpenseaUser(username: "TheBonsaiVault")
        )
        return OpenSeaNFT(
            id: 994262845,
            owner: nil,
            name: "Bellygom#6483",
            permalink: "https://opensea.io/assets/ethereum/0xe02d701a6183cf64adad56f905d33a21c7e83777/275",
            sell_orders: nil,
            last_sale: openSeaNftLastSale,
            collection: openSeaNftCollection,
            creator: openSeaCreator,
            price: nil,
            tokenID: "6438",
            description: "BELLYGOM NFT is a project created and developed from the partnership between Lotte Home Shopping and a FSN's affiliate, 'FingerVerse.' With a total of 10,000 PFPs, various experiences with the BELLYGOM IP such as shopping, hotels, exhibitions, and movies etc, are in store for you. We plan to design a new roadmap with the community members, to expand the BELLYGOM Universe through private membership benefits and events such as renting the entire Lotte World just for our community. Join us and enjoy these amazing IRL experiences with BELLYGOM NFT now!",
            imageURLString: "https://i.seadn.io/gae/-sBB9Ac4c-IZhv7SHeVIC3LZNCGA1yg_BBBqYPI8Z6AgoPLbje-ryLS8ygcGgLUBI9Vp-JNTkoDF7-GBHXtdq-5DaaRgoPOkAuxna-8?auto=format&w=1000"
        )
    }
    
    private func makeReactorByGall3ry3(nft: MoonoNft) -> LottieViewReactor {
        let appDependency = AppDependency.resolve()
        return appDependency.homeViewReactor.dependency
            .lottieViewReactorFactory.create(
                payload: .init(nft: makeOpenSeaNftByGall3ry3(moonoNft: nft), format: .video)
            )
    }
    
    private func makeMockMoonoReactorByGall3ry3() -> LottieViewReactor {
        let appDependency = AppDependency.resolve()
        return appDependency.homeViewReactor.dependency
            .lottieViewReactorFactory.create(
                payload: .init(nft: makeMockOpenSeaMoonoNftByGall3ry3(), format: .video)
            )
    }
    
    private func makeOpenSeaNftByGall3ry3(moonoNft: MoonoNft) -> OpenSeaNFT {
        let collectionTitle = "Moono Week"
        let collectionProfileImageUrl = "https://i.seadn.io/gae/cB8JeJwP76w_GGSvQe-WpwfzA31aQZF2fVLA0FmvcsrISfe9e7HDQ_DE9QhilMaCW88vFo_EfBA6ItrNrUOxmbWlbq6suY0v8Sln?auto=format&w=256"
        let nftOwnerAddress = "0x3961eA20e28A30bCB25E130bec3378d0C248030C"
        
        let openSeaPaymentToken = OpenSeaPaymentToken(
            eth_price: "1.000000000000000"
        )
        let openSeaNftLastSale = OpenSeaNFTLastSale(
            total_price: "31000000000000000",
            payment_token: openSeaPaymentToken
        )
        let openSeaNftCollection = OpenSearNFTCollection(
            name: collectionTitle,
            image_url: collectionProfileImageUrl,
            slug: "MOONO"
        )
        let openSeaCreator = OpenSeaCreator(
            user: OpenseaUser(username: collectionTitle)
        )
        let openSeaNftOwner = OpenSeaNFTOwner(
            user: OpenSeaNFTOwner.OpenSeaNFTUser(username: nftOwnerAddress),
            profile_img_url: "https://storage.googleapis.com/opensea-static/opensea-profile/11.png",
            address: nftOwnerAddress
        )
        
        return OpenSeaNFT(
            id: Int(moonoNft.tokenId) ?? -1,
            owner: openSeaNftOwner,
            name: moonoNft.name,
            permalink: "https://opensea.io/assets/klaytn/0x29421a3c92075348fcbcb04de965e802ed187302/\(moonoNft.tokenIdInteger)",
            sell_orders: nil,
            last_sale: openSeaNftLastSale,
            collection: openSeaNftCollection,
            creator: openSeaCreator,
            price: nil,
            tokenID: moonoNft.tokenId,
            description: moonoNft.description,
            imageURLString: "https://firebasestorage.googleapis.com/v0/b/moono-aftermint-storage.appspot.com/o/Moono%23\(moonoNft.tokenIdInteger).jpeg?alt=media"
        )
    }
    
    private func makeMockOpenSeaMoonoNftByGall3ry3() -> OpenSeaNFT {
        let openSeaPaymentToken = OpenSeaPaymentToken(
            eth_price: "1.000000000000000"
        )
        let openSeaNftLastSale = OpenSeaNFTLastSale(
            total_price: "31000000000000000",
            payment_token: openSeaPaymentToken
        )
        let openSeaNftCollection = OpenSearNFTCollection(
            name: "Moono Week",
            image_url: "https://i.seadn.io/gae/cB8JeJwP76w_GGSvQe-WpwfzA31aQZF2fVLA0FmvcsrISfe9e7HDQ_DE9QhilMaCW88vFo_EfBA6ItrNrUOxmbWlbq6suY0v8Sln?auto=format&w=256",
            slug: "MOONO"
        )
        let openSeaCreator = OpenSeaCreator(
            user: OpenseaUser(username: "2B14DA")
        )
        return OpenSeaNFT(
            id: 994262845,
            owner: nil,
            name: "Moono#1183",
            permalink: "https://opensea.io/assets/klaytn/0x29421a3c92075348fcbcb04de965e802ed187302/1183",
            sell_orders: nil,
            last_sale: openSeaNftLastSale,
            collection: openSeaNftCollection,
            creator: openSeaCreator,
            price: nil,
            tokenID: "1183",
            description: "Meet the unique generative NFT art of Moono and join the exclusive membership!",
            imageURLString: "https://i.seadn.io/gae/Aa6TaAL9HxsTUVCbOfBXKqLzM5dEGQz4Oioo7PBRM4aUmBy5Jxzel9doCM8eGH5NRfH_taxqnFYUK05QtaA-tqNGOVSrApvSRI6A?auto=format&w=1000"
        )
    }
}
