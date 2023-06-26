//
//  ArtMuseumRow.swift
//  ArtMuseumsWorldwide
//
//  Created by Jinwook Kim on 2023/06/26.
//

import SwiftUI

struct ArtMuseumRow: View {
    @EnvironmentObject private var artMuseumManager: ArtMuseumManager
    let artMuseum: ArtMuseum
    var body: some View {
        VStack(alignment: .leading) {
            switch artMuseumManager.sortingStrategy {
                case .name:
                    Text(artMuseum.name)
                case .city:
                    Text(artMuseum.name)
                    Text(artMuseum.city)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                case .country:
                    Text(artMuseum.name)
                    Text(artMuseum.country)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                case .space:
                    Text(artMuseum.name)
                    Text("\(artMuseum.space.formatted())\u{33A1}")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                case .established:
                    Text(artMuseum.name)
                    Text(verbatim: "\(artMuseum.established)")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
            }
        }
    }
}

struct ArtMuseumRow_Previews: PreviewProvider {
    static var previews: some View {
        ArtMuseumRow(artMuseum: ArtMuseum.example)
            .environmentObject(ArtMuseumManager())
    }
}
