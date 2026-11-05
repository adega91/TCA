//
//  ContentFeature.swift
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

@Reducer
struct AddPlantFeature {
    @ObservableState
    struct State: Equatable {
        var name = ""
    }

    enum Action: BindableAction {
        case binding(BindingAction<State>)
        case saveTapped
        case delegate(Delegate)

        enum Delegate {
            case saved(String)
        }
    }

    @Dependency(\.dismiss) var dismiss

    var body: some ReducerOf<Self> {
        BindingReducer()
        Reduce { state, action in
            switch action {
            case .saveTapped:
                let name = state.name
                return .run { send in
                    await send(.delegate(.saved(name)))
                    await dismiss()
                }

            case .binding, .delegate:
                return .none
            }
        }
    }
}
