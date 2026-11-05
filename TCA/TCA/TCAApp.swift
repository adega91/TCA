//
//  TCAApp.swift
//  TCA
//
//  Created by De Gaspari Andrea on 05/11/2026.
//

import ComposableArchitecture
import SwiftUI

@main
struct TCAApp: App {
    static let store = Store(initialState: HomeFeature.State()) {
        HomeFeature()
    }

    var body: some Scene {
        WindowGroup {
            HomeView(store: Self.store)
        }
    }
}
