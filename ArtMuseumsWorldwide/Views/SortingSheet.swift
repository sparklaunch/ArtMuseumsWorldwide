//
//  SortingSheet.swift
//  ArtMuseumsWorldwide
//
//  Created by Jinwook Kim on 2023/06/26.
//

import SwiftUI

struct SortingSheet: View {
    @EnvironmentObject private var artMuseumManager: ArtMuseumManager
    @Environment(\.dismiss) private var dismiss
    var body: some View {
        Form {
            Section("Sorting Strategy") {
                Picker("Choose a sorting strategy", selection: $artMuseumManager.sortingStrategy) {
                    ForEach(SortingStrategy.allCases, id: \.rawValue) { sortingStrategy in
                        Text(sortingStrategy.rawValue.capitalized)
                            .tag(sortingStrategy)
                    }
                }
            }
            Section("Sorting Order") {
                Toggle("Ascending", isOn: $artMuseumManager.ascending)
            }
            Button("Done") {
                dismiss()
            }
            Button("Reset", role: .cancel) {
                artMuseumManager.resetSortingRules()
            }
        }
    }
}

struct SortingSheet_Previews: PreviewProvider {
    static var previews: some View {
        SortingSheet()
            .environmentObject(ArtMuseumManager())
    }
}
