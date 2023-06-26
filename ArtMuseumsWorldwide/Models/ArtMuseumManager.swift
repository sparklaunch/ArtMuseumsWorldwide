//
//  ArtMuseumManager.swift
//  ArtMuseumsWorldwide
//
//  Created by Jinwook Kim on 2023/06/26.
//

import SwiftUI

@MainActor class ArtMuseumManager: ObservableObject {
    @Published private var _artMuseums: [ArtMuseum] = []
    @Published var sortingStrategy: SortingStrategy = .name
    @Published var ascending = true
    private var cacheDirectory: URL {
        let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        return documentDirectory.appendingPathComponent("Cache")
    }
    var artMuseums: [ArtMuseum] {
        get {
            _artMuseums.sorted()
        }
        set {
            _artMuseums = newValue
        }
    }
    func resetSortingRules() {
        sortingStrategy = .name
        ascending = true
    }
    func filteredArtMuseums(with searchText: String) -> [ArtMuseum] {
        let temporaryArtMuseums: [ArtMuseum]
        switch sortingStrategy {
            case .name:
                temporaryArtMuseums = artMuseums.sorted {
                    ascending ? $0.name < $1.name : $0.name > $1.name
                }
            case .city:
                temporaryArtMuseums = artMuseums.sorted {
                    ascending ? $0.city < $1.city : $0.city > $1.city
                }
            case .country:
                temporaryArtMuseums = artMuseums.sorted {
                    ascending ? $0.country < $1.country : $0.country > $1.country
                }
            case .space:
                temporaryArtMuseums = artMuseums.sorted {
                    ascending ? $0.space < $1.space : $0.space > $1.space
                }
            case .established:
                temporaryArtMuseums = artMuseums.sorted {
                    ascending ? $0.established < $1.established : $0.established > $1.established
                }
        }
        if searchText.isEmpty {
            return temporaryArtMuseums
        } else {
            return temporaryArtMuseums.filter { artMuseum in
                artMuseum.name.localizedCaseInsensitiveContains(searchText)
            }
        }
    }
    private func initializeData() {
        let dataURL = Bundle.main.url(forResource: "data", withExtension: "csv")!
        guard let stringData = try? String(contentsOf: dataURL) else {
            fatalError("Failed to load data.")
        }
        let components = stringData.components(separatedBy: "\n").map { row in
            row.trimmingCharacters(in: .whitespacesAndNewlines)
        }.dropLast()
        var artMuseums = [ArtMuseum]()
        for component in components {
            let items = component.components(separatedBy: ",")
            let name = items[0]
            let city = items[1]
            let country = items[2]
            let space = Int(items[3])!
            let established = Int(items[4])!
            let artMuseum = ArtMuseum(name: name, city: city, country: country, space: space, established: established)
            artMuseums.append(artMuseum)
        }
        self.artMuseums = artMuseums
    }
    private func saveCache() {
        guard let encodedData = try? JSONEncoder().encode(artMuseums) else {
            fatalError("Failed to encode data.")
        }
        do {
            try encodedData.write(to: cacheDirectory, options: [.atomic, .completeFileProtection])
        } catch {
            print(error.localizedDescription)
        }
    }
    private func loadData() {
        if let cacheData = try? Data(contentsOf: cacheDirectory) {
            print("Found the cache.")
            guard let decodedData = try? JSONDecoder().decode([ArtMuseum].self, from: cacheData) else {
                fatalError("Failed to decode data.")
            }
            artMuseums = decodedData
        } else {
            print("Not found the cache.")
            initializeData()
            saveCache()
        }
    }
    init() {
        loadData()
    }
}
