//
//  CalendarViewReactor.swift
//  Aftermint
//
//  Created by Platfarm on 2023/02/09.
//

import ReactorKit
import RxSwift
import UIKit

final class CalendarViewReactor: Reactor {
    
    
    enum Action {
        //back button
        case tapBackButton
        //calendar toggle button
        case tapToggleButton
        //tap event image
        case tapEventImage
        //tap utility image
        case tapUtilityImage
        
    }
    
    enum Mutation {
        case tapBackButton
        case tapToggleButton
        case tapEventImage
        case tapUtilityImage
    }
    
    struct State {
        var isBack: Bool = false
        var isToggle: Bool = false
        var isBenefitTapped: Bool = false
        var isUtilityTapped: Bool = false
    }
    
    var initialState: State = State()
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .tapBackButton:
            return Observable.just(Mutation.tapBackButton)
            
        case .tapToggleButton:
            return Observable.just(Mutation.tapToggleButton)
            
        case .tapEventImage:
            return Observable.just(Mutation.tapEventImage)
            
        case .tapUtilityImage:
            return Observable.just(Mutation.tapUtilityImage)
        }
        
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        switch mutation {
        case .tapBackButton:
            newState.isBack = !state.isBack
            
        case .tapToggleButton:
            newState.isToggle = !state.isToggle
            
        case .tapEventImage:
            newState.isBenefitTapped = !state.isBenefitTapped
            
        case .tapUtilityImage:
            newState.isUtilityTapped = !state.isUtilityTapped
        }
        return newState
    }
    
}
