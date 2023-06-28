//
//  ArtMuseumView.swift
//  ArtMuseumsWorldwide
//
//  Created by Jinwook Kim on 2023/06/26.
//

import SwiftUI

struct ArtMuseumView: View {
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
                    Text(artMuseum.name)
                        .font(.largeTitle.bold())
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
    }
}
