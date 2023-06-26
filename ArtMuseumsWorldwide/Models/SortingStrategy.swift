//
//  SortingStrategy.swift
//  ArtMuseumsWorldwide
//
//  Created by Jinwook Kim on 2023/06/26.
//

import SwiftUI

enum SortingStrategy: String, CaseIterable, Hashable {
    case name
    case city
    case country
    case space
    case established
}
