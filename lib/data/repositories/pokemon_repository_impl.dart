import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import 'package:pos_inoidsoft_app/core/errors/failures.dart';
import 'package:pos_inoidsoft_app/data/data_sources/pokemon_local_datasource.dart';

import 'package:pos_inoidsoft_app/domain/entities/pokemon.dart';

import '../../domain/repositories/pokemon_repositories.dart';
import '../data_sources/pokemon_remote_datasource.dart';

class PokemonRepositoryImpl implements PokemonRepository {
  final PokemonLocalDatasource localDatasource;
  final PokemonRemoteDataSource remoteDatasource;

  PokemonRepositoryImpl(
      {required this.localDatasource, required this.remoteDatasource});

  @override
  Future<Either<Failure, bool>> capturePokemon(Pokemon pokemon) async {
    try {
      final resp = await localDatasource.capturePokemon(pokemon);
      return Right(resp);
    } on LocalFailure {
      throw Left(LocalFailure());
    }
  }

  @override
  Future<Either<Failure, List<Pokemon>>> getCapturePokemons() async {
    try {
      final resp = await localDatasource.getPokemonList();
      return Right(resp);
    } on LocalFailure {
      throw Left(LocalFailure());
    }
  }

  @override
  Future<Either<Failure, Pokemon>> getPokemon(int id) async {
    try {
      final resp = await remoteDatasource.getPokemon(id);
      return Right(resp);
    } on DioException {
      throw Left(ServerFailure());
    }
  }
}
