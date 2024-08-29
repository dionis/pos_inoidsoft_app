import 'package:dartz/dartz.dart';
import 'package:pos_inoidsoft_app/domain/repositories/pokemon_repositories.dart';

import '../../core/errors/failures.dart';
import '../entities/pokemon.dart';

class GetCapturePokemonUseCase {
  final PokemonRepository pokemonRepository;
  GetCapturePokemonUseCase({required this.pokemonRepository});

  Future<Either<Failure, List<Pokemon>>> call() {
    return pokemonRepository.getCapturePokemons();
  }
}
