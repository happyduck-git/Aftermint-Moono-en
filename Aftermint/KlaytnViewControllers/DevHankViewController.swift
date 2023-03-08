//
//  DevHankViewController.swift
//  Aftermint
//
//  Created by Hank on 2023/01/30.
//

import UIKit

class DevHankViewController: UIViewController {
    
    private let callGall3ry3Button = UIButton(type: .system)
    private let printNftsInfoButton = UIButton(type: .system)
    private let callG3withBellyGomNftButton = UIButton(type: .system)
    private let shareSimpleButton = UIButton(type: .system)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        initCallGall3ry3Button()
        initPrintNftsInfoButton()
        initCallG3withBellyGomNftButton()
        initShareSimpleButton()
        LLog.v()
    }
    
    private func initCallGall3ry3Button() {
        view.addSubview(callGall3ry3Button)
        callGall3ry3Button.centerXAnchor.constraint(
            equalTo: view.safeAreaLayoutGuide.centerXAnchor
        ).isActive = true
        callGall3ry3Button.bottomAnchor.constraint(
            equalTo: view.safeAreaLayoutGuide.bottomAnchor
        ).isActive = true
        callGall3ry3Button.setTitle("call gall3ry3", for: .normal)
        callGall3ry3Button.addTarget(self, action: #selector(callGall3ry3Screen), for: .touchUpInside)
        callGall3ry3Button.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func initPrintNftsInfoButton() {
        view.addSubview(printNftsInfoButton)
        printNftsInfoButton.centerXAnchor.constraint(
            equalTo: view.safeAreaLayoutGuide.centerXAnchor
        ).isActive = true
        printNftsInfoButton.bottomAnchor.constraint(
            equalTo: callGall3ry3Button.topAnchor
        ).isActive = true
        printNftsInfoButton.setTitle("print nfts info", for: .normal)
        printNftsInfoButton.addTarget(self, action: #selector(printNftsInfo), for: .touchUpInside)
        printNftsInfoButton.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func initCallG3withBellyGomNftButton() {
        view.addSubview(callG3withBellyGomNftButton)
        callG3withBellyGomNftButton.centerXAnchor.constraint(
            equalTo: view.safeAreaLayoutGuide.centerXAnchor
        ).isActive = true
        callG3withBellyGomNftButton.bottomAnchor.constraint(
            equalTo: printNftsInfoButton.topAnchor
        ).isActive = true
        callG3withBellyGomNftButton.setTitle("call gall3ry3 with BellyGom NFT", for: .normal)
        callG3withBellyGomNftButton.addTarget(self, action: #selector(callG3withBellyGomNftScreen), for: .touchUpInside)
        callG3withBellyGomNftButton.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func initShareSimpleButton() {
        view.addSubview(shareSimpleButton)
        shareSimpleButton.centerXAnchor.constraint(
            equalTo: view.safeAreaLayoutGuide.centerXAnchor
        ).isActive = true
        shareSimpleButton.bottomAnchor.constraint(
            equalTo: callG3withBellyGomNftButton.topAnchor
        ).isActive = true
        shareSimpleButton.setTitle("share simple", for: .normal)
        shareSimpleButton.addTarget(self, action: #selector(shareSimple), for: .touchUpInside)
        shareSimpleButton.translatesAutoresizingMaskIntoConstraints = false
    }
    
    @objc private func callGall3ry3Screen() {
        let appDependency = AppDependency.resolve()
        let gall3ry3TemplateCreateViewController = TemplateCreateViewController2(
            reactor: appDependency.homeViewReactor.dependency
                .templateCreateViewReactorFactory.create(payload: .init(nft: mockBellyNft, format: .video))
        )
        navigationController?.pushViewController(gall3ry3TemplateCreateViewController, animated: true)
    }
    
    @objc private func printNftsInfo() {
        _ = KlaytnNftRequester.requestToGetBellyGomNfts(
            walletAddress: "0xBEeBb41496BE8385291886928725d1c2bD9aBA42"
        ) { nfts in
            LLog.i("nfts: \(nfts).")
            LLog.i("nfts.count: \(nfts.count).")
        }
    }
    
    @objc private func callG3withBellyGomNftScreen() {
        DispatchQueue.global().async {
            _ = KlaytnNftRequester.requestToGetBellyGomNfts(
                walletAddress: "0xBEeBb41496BE8385291886928725d1c2bD9aBA42"
            ) { nfts in
                guard !nfts.isEmpty else {
                    LLog.w("nfts is empty.")
                    return
                }
                
                let randomIndex = Int.random(in: 0...nfts.count)
                let targetNft = self.makeOpenSeaNft(bellyGomNft: nfts[randomIndex])
                
                DispatchQueue.main.async {
                    let appDependency = AppDependency.resolve()
                    let gall3ry3TemplateCreateViewController = TemplateCreateViewController2(
                        reactor: appDependency.homeViewReactor.dependency
                            .templateCreateViewReactorFactory.create(payload: .init(nft: targetNft, format: .video))
                    )
                    self.navigationController?.pushViewController(gall3ry3TemplateCreateViewController, animated: true)
                }
                LLog.i("targetNft: \(targetNft).")
                LLog.i("nfts.count: \(nfts.count).")
            }
        }
    }
    
    private func makeOpenSeaNft(bellyGomNft: BellyGomNft) -> OpenSeaNFT {
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
            permalink: "https://opensea.io/assets/klaytn/0xce70eef5adac126c37c8bc0c1228d48b70066d03/\(bellyGomNft.tokenId)",
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
    
    @objc private func shareSimple() {
        let items = ["This app is my favorite"]
        let shareViewController = UIActivityViewController(activityItems: items, applicationActivities: nil)
        present(shareViewController, animated: true)
    }
    
    private let mockG3Nft: OpenSeaNFT = {
        let openSeaPaymentToken = OpenSeaPaymentToken(
            eth_price: "1.000000000000000"
        )
        let openSeaNftLastSale = OpenSeaNFTLastSale(
            total_price: "31000000000000000",
            payment_token: openSeaPaymentToken
        )
        let openSeaNftCollection = OpenSearNFTCollection(
            name: "The Bonsai Assemblance",
            image_url: "https://i.seadn.io/gcs/files/8b59834432204da700fcdccd185b3a37.gif?w=500&auto=format",
            slug: "thebonsaiassemblance"
        )
        let openSeaCreator = OpenSeaCreator(
            user: OpenseaUser(username: "TheBonsaiVault")
        )
        return OpenSeaNFT(
            id: 994262845,
            owner: nil,
            name: "#275",
            permalink: "https://opensea.io/assets/ethereum/0xe02d701a6183cf64adad56f905d33a21c7e83777/275",
            sell_orders: nil,
            last_sale: openSeaNftLastSale,
            collection: openSeaNftCollection,
            creator: openSeaCreator,
            price: nil,
            tokenID: "275",
            description: "Seeds become trees, but what happens after?",
            imageURLString: "https://i.seadn.io/gcs/files/6b3e7fa91207647c9d4e3823786d188f.png?w=500&auto=format"
        )
    }()
    
    private let mockBellyNft: OpenSeaNFT = {
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
    }()
}
