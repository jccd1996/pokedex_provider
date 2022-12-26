import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_example/domain/model/pokemon.dart';
import 'package:provider_example/domain/repository/pokemon_api.dart';
import 'package:provider_example/ui/details/pokemon_detail.dart';
import 'package:provider_example/ui/home/home_provider.dart';
import 'package:provider_example/utils/theme/theme_provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen._({super.key});

  static ChangeNotifierProvider<HomeProvider> create({Key? key}) =>
      ChangeNotifierProvider(
        lazy: false,
        create: (context) => HomeProvider(
          pokemonApi: context.read<PokemonApi>(),
        )..loadPokemons(),
        child: HomeScreen._(key: key),
      );

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final result = context.watch<HomeProvider>().pokemonList;
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      body: SafeArea(
        child: result == null
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Pokédex',
                          style: textTheme.headline4
                              ?.copyWith(fontWeight: FontWeight.bold),
                        ),
                        IconButton(
                            onPressed: () {
                              context.read<ThemeProvider>().changeTheme();
                            },
                            icon: const Icon(Icons.lightbulb))
                      ],
                    ),
                    const Text(
                        'Search your Pokémon by name or using its National Pokédex number.'),
                    const SizedBox(height: 10),
                    TextField(
                      decoration: const InputDecoration(
                        hintText: 'Name or Number',
                        prefixIcon: Icon(Icons.search),
                      ),
                      onChanged: (val) {
                        context.read<HomeProvider>().searchPokemon(val);
                      },
                    ),
                    const SizedBox(height: 20),
                    const Expanded(child: PokemonGrid())
                  ],
                ),
              ),
      ),
    );
  }
}

class PokemonGrid extends StatelessWidget {
  const PokemonGrid({super.key});

  @override
  Widget build(BuildContext context) {
    final pokemons = context.watch<HomeProvider>().searchList;
    final isLight = context.watch<ThemeProvider>().isLight;
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 2 / 3,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
      ),
      itemCount: pokemons?.length ?? 0,
      itemBuilder: (context, index) {
        final pokemon = pokemons![index];
        return InkWell(
          onTap: () {
            _goToDetailPokemon(context, pokemon);
          },
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: isLight ? Colors.greenAccent[100] : Colors.black,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              children: [
                Image.network(
                  pokemon.imageurl!,
                  height: 150,
                ),
                Text(
                  pokemon.name!,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                  ),
                ),
                Text(
                  pokemon.id!,
                  style: const TextStyle(
                    fontSize: 18,
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  void _goToDetailPokemon(BuildContext context, Pokemon pokemon) {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (_) => PokemonDetail.create(pokemon: pokemon)));
  }
}
