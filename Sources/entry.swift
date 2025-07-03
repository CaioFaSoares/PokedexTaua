// The Swift Programming Language
// https://docs.swift.org/swift-book

import Foundation
import ArgumentParser

@main
struct Pokedex: AsyncParsableCommand {
    
    static let configuration = CommandConfiguration(
        commandName: "pokedex",
        subcommands: [
            FindPokemon.self,
            ListPokemon.self
        ]
    )
}


struct FindPokemon: AsyncParsableCommand {

    static let configuration = CommandConfiguration (
        commandName: "find-pokemon", abstract: "Pokedex por CLI", version: "1.0.0"
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

struct ListPokemon: AsyncParsableCommand {
    static let configuration: CommandConfiguration = CommandConfiguration(
        commandName: "list-pokemon",
        abstract: "Lista os Pokemons disponíveis na PokeAPI"
    )

    @Option(name: .shortAndLong, help: "Número de Pokemons a serem listados (padrão: 20)")
    var limit: Int = 20

    @Option(name: .shortAndLong, help: "Número de Pokemon a iniciar a lista (padrão: 0)")
    var offset: Int = 0

    func run() async throws {
        let service = PokemonAPIService()

        do {
            let pokemonList = try await service.fetchPokemonList(limit: limit, offset: offset)
            displayList(pokemonList)
        } catch {
            print("Erro ao buscar lista de Pokemons: \(error.localizedDescription)")
            return
        }
    }


    func displayList(_ pokemonList: PokemonList) {
        print("Total de Pokemons: \(pokemonList.count)")
        print("Pokemons disponíveis:")

        for item in pokemonList.results {
            let name = item.name.capitalized
            let url = item.url
            print("- \(name) (\(url))")
        }
    }
}
