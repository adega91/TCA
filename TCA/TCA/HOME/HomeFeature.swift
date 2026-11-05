//
//  HomeFeature.swift
//  TCA
//
//  Created by De Gaspari Andrea on 05/11/2026.
//

import ComposableArchitecture

@Reducer
struct HomeFeature {
    @ObservableState
    struct State: Equatable {
        var showShimmer: Bool = false
        var plantsUI: [String] = []
        @Presents var addPlant: AddPlantFeature.State?
    }

    enum Action {
        case addPlantTapped
        case addPlant(PresentationAction<AddPlantFeature.Action>)
    }

    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .addPlantTapped:
                state.addPlant = AddPlantFeature.State()
                return .none

            case let .addPlant(.presented(.delegate(.saved(plant)))):
                state.plantsUI.append(plant)
                return .none

            case .addPlant:
                return .none
            }
        }
        .ifLet(\.$addPlant, action: \.addPlant) {
            AddPlantFeature()
        }
    }
}
