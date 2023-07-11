import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/pokemon_provider.dart';

class PokemonDetail extends StatefulWidget {

  final String pokemonId;

  const PokemonDetail({Key? key, required this.pokemonId}) : super(key: key);

  @override
  State<PokemonDetail> createState() => _PokemonDetailState();
}

class _PokemonDetailState extends State<PokemonDetail> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final pokemonProvider = Provider.of<PokemonProvider>(context);
    final pokemon = pokemonProvider.pokemon;
    return Scaffold(
      appBar: AppBar(
        title: Text("Pokemon: ${pokemon.name}"),
      ),
      body:pokemonProvider.isDetailLoading?
      Container(
          child: LinearProgressIndicator()
      ):
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(15),
                )
              ),
              
              padding: EdgeInsets.all(10),
              margin: EdgeInsets.all(15),
              child: Image.network(
                pokemon.image,
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height/5*2,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "ID: ${pokemon.id}",
                  style: TextStyle(
                    fontSize: 15,
                  ),
                ),
              ],
            ),
            SizedBox(height: 20,),
            Text(
                "${pokemon.name}",
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold

              ),
            ),
            SizedBox(height: 10,),
            Text(
              "Class: ${pokemon.classification}",
              style: TextStyle(
                fontSize: 15,
              ),
            ),
            SizedBox(height: 10,),
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Min Weight: ${pokemon.weight.minimum}",
                  style: TextStyle(
                    fontSize: 15,
                  ),
                ),
                Text(
                  "Max Weight: ${pokemon.weight.maximum}",
                  style: TextStyle(
                    fontSize: 15,
                  ),
                ),
              ],
            ),
            SizedBox(height: 10,),
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Min Height: ${pokemon.height.minimum}",
                  style: TextStyle(
                    fontSize: 15,
                  ),
                ),
                Text(
                  "Max Height: ${pokemon.height.maximum}",
                  style: TextStyle(
                    fontSize: 15,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
