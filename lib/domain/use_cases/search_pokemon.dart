import 'package:dartz/dartz.dart';
import 'package:pos_inoidsoft_app/domain/repositories/pokemon_repositories.dart';

import '../../core/errors/failures.dart';
import '../entities/pokemon.dart';

class SearchPokemonUseCase {
  final PokemonRepository repository;

  SearchPokemonUseCase({required this.repository});

  Future<Either<Failure, Pokemon>> call(int id) {
    return repository.getPokemon(id);
  }
}
