//
//  FavoriteManager.swift
//  ArtMuseumsWorldwide
//
//  Created by Jinwook Kim on 2023/06/28.
//

import SwiftUI

@MainActor class FavoriteManager: ObservableObject {
    @Published private var _favorites: [ArtMuseum] = []
    private let key = "Favorites"
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
            save()
        }
    }
    func add(_ artMuseum: ArtMuseum) {
        favorites.append(artMuseum)
        save()
    }
    private func save() {
        guard let encodedData = try? JSONEncoder().encode(favorites) else {
            fatalError("Failed to encode data.")
        }
        UserDefaults.standard.set(encodedData, forKey: key)
    }
    private func load() {
        if let data = UserDefaults.standard.data(forKey: key) {
            guard let decodedData = try? JSONDecoder().decode([ArtMuseum].self, from: data) else {
                fatalError("Failed to decode data.")
            }
            favorites = decodedData
        } else {
            favorites = []
        }
    }
    init() {
        load()
    }
}
