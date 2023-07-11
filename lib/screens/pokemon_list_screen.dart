import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:pokemondemo/provider/pokemon_provider.dart';
import 'package:provider/provider.dart';

import '../utils/app_routers.dart';

class PokemonListScreen extends StatefulWidget {
  const PokemonListScreen({Key? key}) : super(key: key);

  @override
  State<PokemonListScreen> createState() => _PokemonListScreenState();
}

class _PokemonListScreenState extends State<PokemonListScreen> {

  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    final pokemonProvider = Provider.of<PokemonProvider>(context, listen: false);
    _scrollController.addListener(() {
      if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
        pokemonProvider.hasNextPage = true;
        pokemonProvider.fetchPokemonList();
      }
    });
    pokemonProvider.fetchPokemonList();
  }

  @override
  Widget build(BuildContext context) {
    final pokemonProvider = Provider.of<PokemonProvider>(context);
    final pokemonList = pokemonProvider.pokemonList;
    final isLoading = pokemonProvider.isLoading;
    final hasError = pokemonProvider.hasError;
    final errorMessage = pokemonProvider.errorMessage;

    print("Size: "+pokemonList.length.toString());
    return Scaffold(
      appBar: AppBar(
        title: Text("Pokemon Demo"),
      ),
      body: Stack(
        children: [
          ListView.builder(
            controller: _scrollController,
            itemCount: pokemonList.length + 1,
            itemBuilder: (ctx, index) {
              if (index < pokemonList.length) {
                final pokemon = pokemonList[index];
                return Padding(
                  padding: const EdgeInsets.fromLTRB(10, 2, 10, 2),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(25),
                        )
                    ),
                    child: ListTile(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      tileColor: Colors.white,
                      leading: Image.network(pokemon.image),
                      title: Text(pokemon.name),
                      subtitle: Text('Class: ${pokemon.classification}'),
                      onTap: () {
                        // Handle item tap
                        final pokemonProvider = Provider.of<PokemonProvider>(context, listen: false);
                        pokemonProvider.ID = pokemon.id;
                        pokemonProvider.fetchPokemonDetails();

                        Provider.of<FluroRouter>(context, listen: false)
                            .navigateTo(
                            context,
                            "${AppRouters.POKEMON_DETAIL_ROUTE}/${pokemon.id}",
                            replace: false,
                            transition: TransitionType.fadeIn
                        );
                      },
                    ),
                  ),
                );
              } else if (isLoading) {
                return Center(
                  child: LinearProgressIndicator(),
                );
              } else {
                return Container();
              }
            },
          ),
          if (hasError)
            Positioned.fill(
              child: Container(
                color: Colors.black54,
                child: Center(
                  child: Text(
                    errorMessage,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18.0,
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
