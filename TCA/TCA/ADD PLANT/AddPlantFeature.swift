//
//  AddPlantFeature.swift
//  TCA
//
//  Created by De Gaspari Andrea on 05/11/2026.
//

import ComposableArchitecture

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
