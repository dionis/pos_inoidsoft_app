import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:pos_inoidsoft_app/data/models/pokemon_model.dart';

import '../../core/errors/failures.dart';
import '../../domain/entities/pokemon.dart';

abstract class PokemonLocalDatasource {
  Future<bool> capturePokemon(Pokemon pokemon);
  Future<List<Pokemon>> getPokemonList();
}

class SqlitePokemonLocalDataSourceImpl implements PokemonLocalDatasource {
  @override
  Future<bool> capturePokemon(Pokemon pokemon) {
    // TODO: implement capturePokemon
    throw UnimplementedError();
  }

  @override
  Future<List<Pokemon>> getPokemonList() {
    // TODO: implement getPokemonList
    throw UnimplementedError();
  }
}

class HivePokemonLocalDataSourceImpl implements PokemonLocalDatasource {
  HivePokemonLocalDataSourceImpl() {
    //Hive.iniFlutter();
  }
  @override
  Future<bool> capturePokemon(Pokemon pokemon) {
    try {
      //Box<dynamic> box = await Hive.opeBox('pokemons');
      //box.put(pokemon.id, PokemonModel.fromEntity(pokemon).toJson());

      return Future.value(true);
    } catch (error) {
      if (kDebugMode) {
        debugPrint(error.toString());
      }

      throw LocalFailure();
    }
  }

  @override
  Future<List<Pokemon>> getPokemonList() async {
    try {
      //  Box<dynamic> box = await Hive.opeBox('pokemons');
      dynamic box;
      return box.values.map((p) => PokemonModel.fromJson(p)).toList();
    } catch (error) {
      if (kDebugMode) {
        debugPrint(error.toString());
      }

      throw LocalFailure();
    }
  }
}
