//
//  ContentView.swift
//  ArtMuseumsWorldwide
//
//  Created by Jinwook Kim on 2023/06/26.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject private var artMuseumManager: ArtMuseumManager
    var body: some View {
        NavigationView {
            List(artMuseumManager.artMuseums) { artMuseum in
                NavigationLink {

                } label: {
                    Text(artMuseum.name)
                }
            }
            .navigationTitle("Art Museums (\(artMuseumManager.artMuseums.count))")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(ArtMuseumManager())
    }
}
