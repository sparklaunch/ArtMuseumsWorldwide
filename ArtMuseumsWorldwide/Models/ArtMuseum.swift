//
//  ArtMuseum.swift
//  ArtMuseumsWorldwide
//
//  Created by Jinwook Kim on 2023/06/26.
//

import SwiftUI

struct ArtMuseum: Identifiable, Codable {
    static let example = ArtMuseum(name: "British Museum", city: "London", country: "United Kingdom", space: 92_000, established: 1753)
    var id: String {
        name
    }
    let name: String
    let city: String
    let country: String
    let space: Int
    let established: Int
    var imageName: String {
        name.capitalized.replacingOccurrences(of: " ", with: "").replacingOccurrences(of: ":", with: "")
    }
}

extension ArtMuseum: Comparable {
    static func <(lhs: ArtMuseum, rhs: ArtMuseum) -> Bool {
        lhs.name < rhs.name
    }
}

extension ArtMuseum: Equatable {
    static func ==(lhs: ArtMuseum, rhs: ArtMuseum) -> Bool {
        lhs.name == rhs.name
    }
}
