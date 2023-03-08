//
//  LoginViewReactor.swift
//  Aftermint
//
//  Created by Platfarm on 2023/01/30.
//

import ReactorKit
import RxSwift
import UIKit

final class LoginViewReactor: Reactor {
    
    let kasWalletRepository: KasWalletRepository = KasWalletRepository.shared
    let kasConnectService: KASConnectService = KASConnectService.shared
    var requestToken: String?
    
    private var isWaitingTransactionResponse: Bool = false
    private var observer: NSObjectProtocol?
    
    
    enum Action {
        case connectWithKaikas
    }
    
    enum Mutation {
        case connect
        case presentAlert(String)
    }
    
    struct State {
        var connect: Void = ()
        var alertMessage: String?
    }
    
    var initialState: State
    
    // MARK: - Init
    init() {
        self.initialState = State()
    }
    
    // MARK: - Action -> Mutation
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .connectWithKaikas:
            
            if NetworkStatus.shared.isConnected {
                Task.init {
                    do {
                        guard let requestToken = try await self.kasConnectService.getTokenID() else { return }
                        guard let url = URL(string: "kaikas://wallet/api?request_key=\(requestToken)") else { return }
                        self.isWaitingTransactionResponse = true
                        
                        /* Open KAS app to login */
                        DispatchQueue.main.async {
                            UIApplication.shared.open(url)
                        }
                        
                        self.observer = await NotificationCenter.default.addObserver(forName: UIApplication.willEnterForegroundNotification,
                                                                                     object: nil,
                                                                                     queue: .main,
                                                                                     using: { notification in
                            Task.init {
                                guard let walletAddress = try await self.kasConnectService.getWalletAddress(requestKey: requestToken) else { return }
                                self.kasWalletRepository.setCurrentWallet(walletAddress: walletAddress)
                                print("walletAddress: \(walletAddress)")
                            }
                        })
                        
                    } catch (let error){
                        print("Error \(error)")
                    }
                }
                
                return Observable.just(Mutation.connect)
            } else {
                print("Please check your Network connection!")
            }
        }
        return Observable.just(Mutation.presentAlert("WalletAddress unavailable"))
    }
    
    // MARK: - Mutation -> State
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        switch mutation {
        case .connect:
            newState.connect = ()
        case .presentAlert(let message):
            newState.alertMessage = message
        }
        
        return newState
    }
}
