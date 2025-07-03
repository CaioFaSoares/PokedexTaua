import Foundation

struct PokemonAPIService {

    private let baseURL = "https://pokeapi.co/api/v2/pokemon/"

    func fetchPokemon(by name: String) async throws -> Pokemon {

        // GENGAR brabo -> gengar brabo -> gengarbrabo
        let nomeFormatado = name.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
        guard let url = URL(string: "\(baseURL)\(nomeFormatado)") else {
            throw APIError.invalidURL
        }

        let (data, response) = try await URLSession.shared.data(from: url)

        if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 404 {
            throw APIError.notFound
        }

        do {
            let pokemon = try JSONDecoder().decode(Pokemon.self, from: data)
            return pokemon
        } catch {
            throw APIError.decodingError(error)
        }

    }

}