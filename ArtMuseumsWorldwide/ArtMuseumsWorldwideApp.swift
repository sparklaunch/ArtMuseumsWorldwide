//
//  ArtMuseumsWorldwideApp.swift
//  ArtMuseumsWorldwide
//
//  Created by Jinwook Kim on 2023/06/26.
//

import SwiftUI

@main
struct ArtMuseumsWorldwideApp: App {
    @StateObject private var artMuseumManager = ArtMuseumManager()
    @StateObject private var favoriteManager = FavoriteManager()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(artMuseumManager)
                .environmentObject(favoriteManager)
        }
    }
}
