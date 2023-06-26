//
//  ArtMuseumManager.swift
//  ArtMuseumsWorldwide
//
//  Created by Jinwook Kim on 2023/06/26.
//

import SwiftUI

@MainActor class ArtMuseumManager: ObservableObject {
    @Published private var _artMuseums: [ArtMuseum] = []
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
    func filteredArtMuseums(with searchText: String) -> [ArtMuseum] {
        if searchText.isEmpty {
            return artMuseums
        } else {
            return artMuseums.filter { artMuseum in
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
