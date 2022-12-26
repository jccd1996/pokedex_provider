import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_example/data/pokemon_analytics.dart';
import 'package:provider_example/data/rest/pokemon_rest_service.dart';
import 'package:provider_example/domain/repository/pokemon_api.dart';
import 'package:provider_example/ui/splash/splash_screen.dart';
import 'package:provider_example/utils/theme/theme_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<PokemonAnalytics>(
          create: (_) => PokemonAnalytics(),
        ),
        Provider<PokemonApi>(
          create: (context) => PokemonRestService(
            context.read<PokemonAnalytics>(),
          ),
        ),
        ChangeNotifierProvider(
          create: (_) => ThemeProvider(),
        ),
      ],
      child: Consumer<ThemeProvider>(builder: (context, provider, _) {
        final isLight = provider.isLight;
        return GestureDetector(
          onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
          child: MaterialApp(
            title: 'Flutter Pokemon',
            theme: isLight ? provider.lightTheme : provider.darkTheme,
            home: const SplashScreen(),
          ),
        );
      }),
    );
  }
}
