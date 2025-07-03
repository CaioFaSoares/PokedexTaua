import Foundation

struct Pokemon: Codable {
    let weight: Int
    let height: Int
    let id: Int
    let name: String
    let species: PokemonSpecies

    let types: [PokemonTypes]
    let stats: [PokemonStats]
}

struct PokemonSpecies: Codable {
    let name: String
    let url: String
}

struct PokemonTypes: Codable {
    let slot: Int
    let type: PokemonType
}

struct PokemonType: Codable {
    let name: String
    let url: String
}

struct PokemonStats: Codable {
    let baseStat: Int
    let effort: Int
    let stat: PokemonStat

    enum CodingKeys: String, CodingKey {
        case baseStat = "base_stat"
        case effort
        case stat
    }
}

struct PokemonStat: Codable {
    let name: String
    let url: String
}