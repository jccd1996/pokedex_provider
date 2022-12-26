import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider_example/domain/model/pokemon.dart';
import 'package:provider_example/domain/repository/pokemon_api.dart';
import 'package:provider_example/utils/debouncer.dart';

class HomeProvider extends ChangeNotifier {
  HomeProvider({
    required this.pokemonApi,
  });

  final PokemonApi pokemonApi;
  List<Pokemon>? pokemonList;
  List<Pokemon>? searchList;
  final debouncer = Debouncer();

  Future<void> loadPokemons() async {
    pokemonList = await pokemonApi.getPokemons();
    _setInitialList();
    notifyListeners();
  }

  void _setInitialList() {
    searchList = List<Pokemon>.from(pokemonList ?? []);
  }

  void searchPokemon(String filter) {
    debouncer.execute(() {
      final filterLowerCase = filter.toLowerCase();
      if (filter.isEmpty) {
        _setInitialList();
      } else {
        searchList = List<Pokemon>.from(
          pokemonList!.where((element) =>
              element.name!.toLowerCase().contains(
                    filterLowerCase,
                  ) ||
              element.id!.toLowerCase().contains(filterLowerCase)),
        );
      }
      notifyListeners();
    });
  }
}
