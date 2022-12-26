import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:provider_example/data/pokemon_analytics.dart';
import 'package:provider_example/domain/model/pokemon.dart';
import 'package:provider_example/domain/repository/pokemon_api.dart';

const pokemonAPI =
    'https://gist.githubusercontent.com/hungps/0bfdd96d3ab9ee20c2e572e47c6834c7/raw/pokemons.json';

class PokemonRestService implements PokemonApi {
  PokemonRestService(this.pokemonAnalytics);

  final PokemonAnalytics pokemonAnalytics;

  @override
  Future<List<Pokemon>> getPokemons() async {
    var url = Uri.parse(pokemonAPI);
    pokemonAnalytics.sendEvent('get pokemon list');
    var response = await http.get(url);
    log('Response status: ${response.statusCode}');
    log('Response body: ${response.body}');
    return pokemonFromJson(response.body);
  }
}
