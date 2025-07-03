// The Swift Programming Language
// https://docs.swift.org/swift-book

import Foundation
import ArgumentParser

@main
struct Pokedex: AsyncParsableCommand {

    static let configuration = CommandConfiguration (
        commandName: "PokedexCLI", abstract: "Pokedex por CLI", version: "1.0.0"
    )

    @Argument(help: "O Pokemon que você ta procurando")
    var pokemonName: String

    func run() async throws {

        let service = PokemonAPIService()

        do {
            let pokemon = try await service.fetchPokemon(by: pokemonName)
            display(pokemon)
        } catch {
            print("Erro: \(error.localizedDescription)")
        }

    }

    private func display(_ pokemon: Pokemon) {

        print("Nome do Pokemon:     \(pokemon.name.capitalized)")
        print("ID:                  \(pokemon.id)")

        let types = pokemon.types
            .sorted { $0.slot > $1.slot }
            .map { $0.type.name.capitalized }
            .joined(separator: ", ")

        print("Tipos do Pokemon:    \(types)")

        print("Stats base:")

        for stat in pokemon.stats {
            print("- \(stat.stat.name.capitalized): \(stat.baseStat)") 
        }
        

    }

}