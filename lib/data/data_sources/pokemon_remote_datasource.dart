import 'package:dio/dio.dart';

import '../models/pokemon_model.dart';

abstract class PokemonRemoteDataSource {
  Future<PokemonModel> getPokemon(int id);
}

class PokemonRemoteDatasourceImp implements PokemonRemoteDataSource {
  final Dio dio = Dio();

  @override
  Future<PokemonModel> getPokemon(int id) async {
    final resp = await dio.get("https://pokeapi.co/api/v2/pokemon/${id}");

    return PokemonModel.fromJson(resp.data);
  }
}
