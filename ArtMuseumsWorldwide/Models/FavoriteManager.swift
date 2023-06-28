//
//  FavoriteManager.swift
//  ArtMuseumsWorldwide
//
//  Created by Jinwook Kim on 2023/06/28.
//

import SwiftUI

@MainActor class FavoriteManager: ObservableObject {
    @Published private var _favorites: [ArtMuseum] = []
    var favorites: [ArtMuseum] {
        get {
            _favorites.sorted()
        }
        set {
            _favorites = newValue
        }
    }
    func filteredFavorites(with searchText: String) -> [ArtMuseum] {
        if searchText.isEmpty {
            return favorites
        } else {
            return favorites.filter { favorite in
                favorite.name.localizedCaseInsensitiveContains(searchText)
            }
        }
    }
    func has(_ artMuseum: ArtMuseum) -> Bool {
        favorites.contains(artMuseum)
    }
    func remove(_ artMuseum: ArtMuseum) {
        if let targetIndex = favorites.firstIndex(of: artMuseum) {
            favorites.remove(at: targetIndex)
        }
    }
    func add(_ artMuseum: ArtMuseum) {
        favorites.append(artMuseum)
    }
}
