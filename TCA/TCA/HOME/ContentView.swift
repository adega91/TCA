//
//  ContentView.swift
//  TCA
//
//  Created by De Gaspari Andrea on 05/11/2026.
//

import ComposableArchitecture
import SwiftUI

struct HomeView: View {
    @Bindable var store: StoreOf<HomeFeature>

    var body: some View {
        NavigationStack {
            VStack {
                if store.showShimmer {
                    ProgressView()
                    Spacer()
                } else if store.plantsUI.isEmpty {
                    ContentUnavailableView("Nessun impianto", systemImage: "house")
                } else {
                    List(store.plantsUI, id: \.self) { plant in
                        Text(plant)
                    }
                }
            }
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Aggiungi") {
                        store.send(.addPlantTapped)
                    }
                    .buttonStyle(.borderedProminent)
                    .tint(.blue)
                }

            }
            .navigationDestination(
                item: $store.scope(state: \.addPlant, action: \.addPlant)) { addStore in
                    AddPlantView(store: addStore)
                }
        }
    }
}

struct AddPlantView: View {
    @Bindable var store: StoreOf<AddPlantFeature>

    var body: some View {
        Form {
            TextField("Nome", text: $store.name)
            Button("Salva") { store.send(.saveTapped) }
        }
    }
}

#Preview {
    HomeView(store: Store(initialState: HomeFeature.State()) { HomeFeature() })
}
