import '../../domain/entities/pokemon.dart';

import 'dart:convert';

Pokemon pokemonFromJson(String str) => PokemonModel.fromJson(json.decode(str));

String pokemonToJson(PokemonModel data) => json.encode(data.toJson());

class PokemonModel extends Pokemon {
  PokemonModel({required super.id, required super.name, required super.image});

  factory PokemonModel.fromJson(Map<String, dynamic> json) => PokemonModel(
        id: json["id"],
        name: json["name"],
        image: json["sprites"]["front_default"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "image": image,
      };

  factory PokemonModel.fromEntity(Pokemon pokemon) =>
      PokemonModel(name: pokemon.name, id: pokemon.id, image: pokemon.image);
}
