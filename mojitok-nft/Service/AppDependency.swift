//
//  AppDependency.swift
//  mojitok-nft
//
//  Created by 김진우 on 2022/06/08.
//

import Foundation

struct AppDependency {
    let homeViewReactor: HomeViewReactor2
    let loginViewControllerDependency: LoginViewController.Dependency
    let startViewControllerDependency: StartViewController.Dependency
    let klaytnTabBarViewControllerDependency: KlaytnTabViewController.Dependency
    let lottieViewControllerDependency: LottieViewController.Dependency
    
    static func resolve() -> AppDependency {
        let templateRepository = TemplateRepository.shared
        let walletRepository = WalletRepository.shared
        let nftRepository = NFTRepository.shared
        let twitterService = TwitterService.shared
        let userService = UserService.shared
         
        /// Currently not in use
        /*
        let templateShareViewReactorFactory = TemplateShareViewReactor.Factory(dependency: .init(twitterService: twitterService, userService: userService))
        
        let templateCreateViewReactorFactory = TemplateCreateViewReactor.Factory(dependency: .init(templateShareViewReactorFactory: templateShareViewReactorFactory, templateRepository: templateRepository))
        
         let homeViewReactor = HomeViewReactor(dependency: .init(templateCreateViewReactorFactory: templateCreateViewReactorFactory, walletRepository: walletRepository, nftRepository: nftRepository), payload: .init())
         */
        
        let templateShareViewReactorFactory2 = TemplateShareViewReactor2.Factory(dependency: .init(twitterService: twitterService, userService: userService))
        
        let templateCreateViewReactorFactory2 = TemplateCreateViewReactor2.Factory(dependency: .init(templateShareViewReactorFactory: templateShareViewReactorFactory2, templateRepository: templateRepository))
        
        let lottieViewReactorFactory = LottieViewReactor.Factory(dependency: .init(templateRepository: templateRepository))
        
        let homeViewReactor2 = HomeViewReactor2(dependency: .init(templateCreateViewReactorFactory: templateCreateViewReactorFactory2, lottieViewReactorFactory: lottieViewReactorFactory, walletRepository: walletRepository, nftRepository: nftRepository), payload: .init())
        
        let lottieViewControllerDependency: LottieViewController.Dependency = .init(factory: lottieViewReactorFactory)
        
        let homeViewControllerDependency: KlaytnHomeViewController.Dependency =
            .init(homeViewReactor: homeViewReactor2,
                  lottieViewControllerDependency: lottieViewControllerDependency)
        
        let mainTabBarControllerDependency: KlaytnTabViewController.Dependency =
            .init(homeViewControllerDependency: homeViewControllerDependency) {
            LeaderBoardTableViewCellListViewModel()
        }
        
        let startViewControllerDependency: StartViewController.Dependency = .init(mainTabBarViewControllerDependency: mainTabBarControllerDependency)
        
        let loginViewControllerDependency: LoginViewController.Dependency = .init(
            reactor: { LoginViewReactor() },
            startViewControllerDependency: startViewControllerDependency,
            mainTabBarViewControllerDependency: mainTabBarControllerDependency
        )
        
        return .init(homeViewReactor: homeViewReactor2,
                     loginViewControllerDependency: loginViewControllerDependency,
                     startViewControllerDependency: startViewControllerDependency,
                     klaytnTabBarViewControllerDependency: mainTabBarControllerDependency,
                     lottieViewControllerDependency: lottieViewControllerDependency
                     )
    }
}

extension LoginViewController {
    struct Dependency {
        let reactor: () -> LoginViewReactor
        let startViewControllerDependency: StartViewController.Dependency
        let mainTabBarViewControllerDependency: KlaytnTabViewController.Dependency
    }
}

extension StartViewController {
    struct Dependency {
        let mainTabBarViewControllerDependency: KlaytnTabViewController.Dependency
    }
}

extension KlaytnTabViewController {
    struct Dependency {
        let homeViewControllerDependency: KlaytnHomeViewController.Dependency
        let leaderBoardListViewModel: () -> LeaderBoardTableViewCellListViewModel
    }
}

extension KlaytnHomeViewController {
    struct Dependency {
        let homeViewReactor: HomeViewReactor2
        let lottieViewControllerDependency: LottieViewController.Dependency
    }
}

extension LottieViewController {
    struct Dependency {
        let factory: LottieViewReactor.Factory
    }
}
