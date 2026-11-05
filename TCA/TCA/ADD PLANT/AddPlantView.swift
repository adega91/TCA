//
//  AddPlantView.swift
//  TCA
//
//  Created by De Gaspari Andrea on 05/11/2026.
//

import ComposableArchitecture
import SwiftUI

struct AddPlantView: View {
    @Bindable var store: StoreOf<AddPlantFeature>

    var body: some View {
        Form {
            TextField("Nome", text: $store.name)
            Button("Salva") { store.send(.saveTapped) }
        }
    }
}
