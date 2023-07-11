import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:pokemondemo/provider/pokemon_provider.dart';
import 'package:pokemondemo/utils/app_routers.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    final pokemonProvider = Provider.of<PokemonProvider>(context,listen: false);

    // Fetch the Pokémon list
    pokemonProvider.fetchPokemonList().then((_) {
      // Navigate to the Pokémon list screen
      Provider.of<FluroRouter>(context, listen: false).navigateTo(context, AppRouters.POKEMON_LIST_ROUTE, replace: true);
    }).catchError((error) {
      // Handle error, e.g., show an error message or retry fetching the data
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("assets/pokeball.png"),
            SizedBox(height: 5,),
            Text("Pokemon Demo"),
          ],
        ),
      ),
    );
  }
}
