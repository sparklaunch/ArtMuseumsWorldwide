//
//  MainView.swift
//  ArtMuseumsWorldwide
//
//  Created by Jinwook Kim on 2023/06/26.
//

import SwiftUI

struct MainView: View {
    @EnvironmentObject private var artMuseumManager: ArtMuseumManager
    @State private var searchText = ""
    @State private var showingSortingSheet = false
    var body: some View {
        NavigationView {
            List(artMuseumManager.filteredArtMuseums(with: searchText)) { artMuseum in
                NavigationLink {
                    ArtMuseumView(artMuseum: artMuseum)
                } label: {
                    ArtMuseumRow(artMuseum: artMuseum)
                }
            }
            .searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .always))
            .autocorrectionDisabled()
            .navigationTitle("Art Museums (\(artMuseumManager.filteredArtMuseums(with: searchText).count))")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        showingSortingSheet = true
                    } label: {
                        Label("Sort", systemImage: "slider.horizontal.3")
                    }
                }
            }
            .sheet(isPresented: $showingSortingSheet) {
                SortingSheet()
            }
        }
        .navigationViewStyle(.stack)
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
            .environmentObject(ArtMuseumManager())
    }
}
