//
//  BookmarkViewReactor.swift
//  Aftermint
//
//  Created by HappyDuck on 2023/02/12.
//

import UIKit
import ReactorKit
import RxSwift

class BookmarkViewReactor: Reactor {
    
    let cellImages: [UIImage?] = [UIImage(named: "benefit_event"), UIImage(named: "benefit_utility")]
    lazy var dataSource: Observable<[UIImage?]> = Observable<[UIImage?]>.of(cellImages)
    
    
    enum Action {
        case refresh
        //tap event image
        case tapEventImage
        //tap utility image
        case tapUtilityImage
    }
    
    enum Mutation {
        case setCellItems([UIImage?])
        case tapEventImage
        case tapUtilityImage
    }
    
    struct State {
        var cellItems: [UIImage?] = []
        var isBenefitTapped: Bool = true
        var isUtilityTapped: Bool = false
    }
    
    var initialState: State = State()
    
    func mutate(action: Action) -> Observable<Mutation> {
        
        switch action {
        case .refresh:
            return Observable.of(Mutation.setCellItems(cellImages))
            
        case .tapEventImage:
            return Observable.just(Mutation.tapEventImage)
            
        case .tapUtilityImage:
            return Observable.just(Mutation.tapUtilityImage)
        }

    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        switch mutation {
        case .setCellItems(let images):
            newState.cellItems = images
            
        case .tapEventImage:
            newState.isBenefitTapped = !state.isBenefitTapped
            newState.isUtilityTapped = !state.isUtilityTapped
            
        case .tapUtilityImage:
            newState.isUtilityTapped = !state.isUtilityTapped
            newState.isBenefitTapped = !state.isBenefitTapped
        }
        return newState
    }
    
    
}
