import 'package:flutter/material.dart';
import 'package:provider_example/ui/home/home_screen.dart';
import 'package:provider_example/utils/assets.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    _waitAndPush();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 350,
              width: MediaQuery.of(context).size.width / 1.5,
              child: Image.asset(
                Assets.pokedexSplash,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'Pokédex created by Camilo Cubillos',
              style: Theme.of(context).textTheme.bodyText2,
            ),
            const SizedBox(height: 20),
            const CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }

  Future<void> _waitAndPush() async {
    await Future.delayed(const Duration(seconds: 2));
    if (mounted) {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => HomeScreen.create()));
    }
  }
}
