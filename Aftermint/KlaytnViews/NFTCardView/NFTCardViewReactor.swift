//
//  NFTCardViewReactor.swift
//  Aftermint
//
//  Created by Platfarm on 2023/02/01.
//

import Foundation
import ReactorKit
import RxSwift

final class NFTCardViewReactor: Reactor {
    
    let kasWalletRepository: KasWalletRepository = KasWalletRepository.shared
    
    enum Action {
        case loadAll
    }
    
    enum Mutation {
        case loadAll([BellyGomNft])
    }
    
    struct State {
        var nfts: [BellyGomNft] = []
    }
    
    var initialState: State
    
    // MARK: - Init
    init() {
        self.initialState = State()
    }
    
    // MARK: - Action -> Mutation
    var bellyGomNfts: [BellyGomNft] = []
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .loadAll:
            
            let currentWalletAddress: String = kasWalletRepository.getCurrentWallet()
            print("Current wallet address: \(currentWalletAddress)")
            
            let tempAddress: String = "0xBEeBb41496BE8385291886928725d1c2bD9aBA42"
            
            //currentWalletAddress로 바꿔야함
            
            bellyGomNfts = getNfts(of: tempAddress)
            
            return Observable.just(Mutation.loadAll(bellyGomNfts))
        }
    }
    
    
    private func getNfts(of wallet: String) -> [BellyGomNft] {

        var bellyGomNfts: [BellyGomNft] = []

        let semaphore = DispatchSemaphore(value: 0)

        _ = KlaytnNftRequester.requestToGetBellyGomNfts(
            walletAddress: wallet
        ) { nfts in
            bellyGomNfts = nfts

            semaphore.signal()
        }
        semaphore.wait()
        print("Bellygom count : \(bellyGomNfts.count)")

        return bellyGomNfts
    }
    
//    private func getNfts(of wallet: String) {
//
//        _ = KlaytnNftRequester.requestToGetBellyGomNfts(
//            walletAddress: wallet
//        ) { nfts in
//            self.bellyGomNfts = nfts
//            print("Bellygom count : \(self.bellyGomNfts.count)")
//
//        }
//    }

    // MARK: - Mutation -> State
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        
        switch mutation {
        case .loadAll(let nfts):
            newState.nfts = nfts
        }

        return newState
    }
}
