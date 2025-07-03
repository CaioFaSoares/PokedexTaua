struct PokemonList: Codable {
    let count: Int
    let next: String?
    let previous: String?
    let results: [PokemonListItem]

    enum CodingKeys: String, CodingKey {
        case count
        case next
        case previous
        case results
    }
}

struct PokemonListItem: Codable {
    let name: String
    let url: String

    enum CodingKeys: String, CodingKey {
        case name
        case url
    }
}