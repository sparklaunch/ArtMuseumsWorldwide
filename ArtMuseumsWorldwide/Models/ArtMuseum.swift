//
//  ArtMuseum.swift
//  ArtMuseumsWorldwide
//
//  Created by Jinwook Kim on 2023/06/26.
//

import SwiftUI

struct ArtMuseum: Identifiable, Codable {
    var id: String {
        name
    }
    let name: String
    let city: String
    let country: String
    let space: Int
    let established: Int
}

extension ArtMuseum: Comparable {
    static func <(lhs: ArtMuseum, rhs: ArtMuseum) -> Bool {
        lhs.name < rhs.name
    }
}
