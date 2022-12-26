import 'package:provider_example/domain/model/pokemon.dart';

abstract class PokemonApi {
  Future<List<Pokemon>> getPokemons();
}
