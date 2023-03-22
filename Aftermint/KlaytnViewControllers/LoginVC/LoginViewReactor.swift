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
        case connectWithFavorlet
        case connectWithKaikas
    }
    
    enum Mutation {
        case openFavorlet
        case openKaikas
        case presentAlert(String)
    }
    
    struct State {
        var shouldOpenFavorlet: Bool = false
        var shouldOpenKaikas: Bool = false
        var alertMessage: String?
        var isWalletConnected: Bool = false
    }
    
    var initialState: State
    
    // MARK: - Init
    init() {
        self.initialState = State()
    }
    
    // MARK: - Action -> Mutation
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .connectWithFavorlet:
            return Observable.just(Mutation.openFavorlet)
            
        case .connectWithKaikas:
         
            self.deeplinkToKaikasToConnectWallet{ result in
                switch result {
                case .success:
                    
                case .failure:
                }
            }
            
            /*
             let requestCode = userService.requestSMSCode("phone").asObservable()
               .map { _ in Mutation.updateNetworkStatus(.loaded("code sent")) }
               .concat(startCountdown) // when succeeds
               .catchErrorJustReturn(.updateNetworkStatus(.failed(" sent code failed"))) // when fails
             return .concat([startLoading, requestCode])
             */
            
        }
    }
    
    // MARK: - Mutation -> State
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        switch mutation {
        case .openFavorlet:
            newState.shouldOpenFavorlet = true
            newState.shouldOpenKaikas = false
            
        case .openKaikas:
//            newState.shouldOpenFavorlet = false
//            newState.shouldOpenKaikas = true
            newState.isWalletConnected = true
            
        case .presentAlert(let message):
            newState.alertMessage = message
        }
        return newState
    }
}

extension LoginViewReactor {
    
    private func deeplinkToKaikasToConnectWallet(completion: @escaping (Result<Bool, Error>) -> ()) {
        Task.init {
            do {
                guard let requestToken = try await self.kasConnectService.getTokenID() else { return }
                guard let url = URL(string: "kaikas://wallet/api?request_key=\(requestToken)") else { return }
                self.isWaitingTransactionResponse = true
                
                /// Open KAS app to login.
                DispatchQueue.main.async {
                    UIApplication.shared.open(url)
                }
                
                /// Notify when the app will enter foreground.
                self.observer = await NotificationCenter.default.addObserver(forName: UIApplication.willEnterForegroundNotification,
                                                                             object: nil,
                                                                             queue: .main,
                                                                             using: { notification in
                    /// When notified that the app will enter foreground,
                    /// acquire wallet address and save the address to KasWalletRepository.
                    Task.init {
                        guard let walletAddress = try await self.kasConnectService.getWalletAddress(requestKey: requestToken) else { return }
                        self.kasWalletRepository.setCurrentWallet(walletAddress: walletAddress)
                        print("walletAddress: \(walletAddress)")
                        completion(.success(true))
                    }
                })
                
                
            } catch (let error){
                print("Error \(error)")
                completion(.failure(error))
            }
        }
    }
}
