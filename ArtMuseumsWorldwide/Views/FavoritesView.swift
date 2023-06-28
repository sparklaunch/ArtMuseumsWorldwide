//
//  FavoritesView.swift
//  ArtMuseumsWorldwide
//
//  Created by Jinwook Kim on 2023/06/26.
//

import SwiftUI

struct FavoritesView: View {
    @EnvironmentObject private var favoriteManager: FavoriteManager
    @State private var searchText = ""
    var body: some View {
        NavigationView {
            List {
                ForEach(favoriteManager.filteredFavorites(with: searchText)) { favorite in
                    Text(favorite.name)
                }
            }
            .searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .always))
            .autocorrectionDisabled()
            .navigationTitle("Favorites")
        }
        .navigationViewStyle(.stack)
    }
}

struct FavoritesView_Previews: PreviewProvider {
    static var previews: some View {
        FavoritesView()
            .environmentObject(FavoriteManager())
    }
}
