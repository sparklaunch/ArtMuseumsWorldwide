//
//  ContentView.swift
//  ArtMuseumsWorldwide
//
//  Created by Jinwook Kim on 2023/06/26.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject private var artMuseumManager: ArtMuseumManager
    @State private var searchText = ""
    var body: some View {
        NavigationView {
            List(artMuseumManager.filteredArtMuseums(with: searchText)) { artMuseum in
                NavigationLink {

                } label: {
                    Text(artMuseum.name)
                }
            }
            .searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .always))
            .autocorrectionDisabled()
            .navigationTitle("Art Museums (\(artMuseumManager.filteredArtMuseums(with: searchText).count))")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(ArtMuseumManager())
    }
}
