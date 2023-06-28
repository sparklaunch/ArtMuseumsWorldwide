//
//  ArtMuseumView.swift
//  ArtMuseumsWorldwide
//
//  Created by Jinwook Kim on 2023/06/26.
//

import SwiftUI

struct ArtMuseumView: View {
    @EnvironmentObject private var favoriteManager: FavoriteManager
    let artMuseum: ArtMuseum
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                Image(artMuseum.imageName)
                    .resizable()
                    .scaledToFill()
                    .frame(maxWidth: .infinity, maxHeight: 300)
                    .clipped()
                VStack(alignment: .leading, spacing: 10) {
                    HStack {
                        Text(artMuseum.name)
                            .font(.largeTitle.bold())
                        Spacer()
                        if favoriteManager.has(artMuseum) {
                            Button {
                                favoriteManager.remove(artMuseum)
                            } label: {
                                Image(systemName: "star.fill")
                                    .imageScale(.large)
                            }
                        } else {
                            Button {
                                favoriteManager.add(artMuseum)
                            } label: {
                                Image(systemName: "star")
                                    .imageScale(.large)
                            }
                        }
                    }
                    Text("Location: \(artMuseum.city), \(artMuseum.country).")
                        .font(.title3.weight(.semibold))
                    Text(verbatim: "Established in \(artMuseum.established) CE.")
                    Text("Space: \(artMuseum.space)\u{33A1}.")
                    Spacer()
                }
                .padding()
            }
        }
        .edgesIgnoringSafeArea(.all)
    }
}

struct ArtMuseumView_Previews: PreviewProvider {
    static var previews: some View {
        ArtMuseumView(artMuseum: ArtMuseum.example)
            .environmentObject(FavoriteManager())
    }
}
