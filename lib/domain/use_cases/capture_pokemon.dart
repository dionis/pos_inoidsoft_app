import 'package:dartz/dartz.dart';
import 'package:pos_inoidsoft_app/core/errors/failures.dart';
import 'package:pos_inoidsoft_app/domain/repositories/pokemon_repositories.dart';

import '../entities/pokemon.dart';

class CapturePokemonUseCase {
  final PokemonRepository pokemonRepositories;

  CapturePokemonUseCase({required this.pokemonRepositories});

  Future<Either<Failure, bool>> call(Pokemon pokemon) {
    return pokemonRepositories.capturePokemon(pokemon);
  }
}
