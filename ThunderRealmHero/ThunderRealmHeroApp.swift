//
//  ThunderRealmHeroApp.swift
//  ThunderRealmHero
//
//  Created by ClydeHsieh on 2025/3/6.
//

import SwiftUI
import SwiftData

@main
struct ThunderRealmHeroApp: App {
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Item.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(sharedModelContainer)
    }
}
