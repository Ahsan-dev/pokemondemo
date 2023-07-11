import 'package:flutter/cupertino.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:pokemondemo/data/models/Pokemon.dart';

import '../data/data source/remote/gql/grapgql_client.dart';

class PokemonProvider extends ChangeNotifier{
  List<Pokemon> _pokemonList = [];
  bool _isLoading = false;
  bool _isDetailLoading = false;
  bool _hasError = false;
  String _errorMessage = '';
  Pokemon _pokemon = Pokemon(
      name: "",
      id: "",
      weight: Weight(
        minimum: "",
        maximum: ""
      ),
      height: Height(
        minimum: "",
        maximum: ""
      ),
      classification: "",
      image: ""
  );
  String _ID = "";

  set ID(String id){
    _ID = id;
    //notifyListeners();
    print("Received ID: $_ID");
  }

  List<Pokemon> get pokemonList => _pokemonList;
  bool get isLoading => _isLoading;
  bool get isDetailLoading => _isDetailLoading;
  bool get hasError => _hasError;
  String get errorMessage => _errorMessage;
  Pokemon get pokemon => _pokemon;

  int _limit = 10;
  int _offset = 0;
  bool _hasNextPage = false;
  int _lastlimit = 0;

  bool get hasNextPage => _hasNextPage;

  set hasNextPage(bool next){
    _hasNextPage = next;
    notifyListeners();
  }

  Future<void> fetchPokemonList() async{

    if(_hasNextPage){
      //_lastlimit = _limit;
      _limit+=10;
      _pokemonList.clear();
    }

    print("Fetching Pokemon List...");
    if(_isLoading) return;
    _isLoading = true;
    _hasNextPage = false;
    _errorMessage = '';
    //notifyListeners();
    try{
      final query = '''
         query {
            pokemons(first: $_limit) {
              name
              id
              weight{
                minimum
                maximum
              }
              height{
                minimum
                maximum
              }
              classification
              image
            }
          }
      ''';

      final options = QueryOptions(
        document: gql(query),
      );

      final response = await GraphQLClientService.getClient().value.query(options);
      print("Result A:  "+ response.data.toString());
      // if (response.hasException) {
      //   throw Exception('Failed to fetch Pokémon list');
      // }
      //final response = await DioClient().fetchPokemons(_limit);
      final List<dynamic> result = response.data?['pokemons'];

      //print("Result:  "+ result[0].name);
      _pokemonList.addAll(result.map((pokemonData) {
        return Pokemon(
            name: pokemonData["name"],
            id: pokemonData["id"],
            weight: Weight(
                minimum:pokemonData["weight"]["minimum"],
                maximum: pokemonData["weight"]["maximum"]
            ),
            height: Height(
                minimum:pokemonData["height"]["minimum"],
                maximum: pokemonData["height"]["maximum"]
            ),
            classification: pokemonData["classification"],
            image: pokemonData["image"]
        );
      }));
    }catch(e){
      _hasError = true;
      _errorMessage = "Failed to fetch pokemon list: ${e.toString()}";
      notifyListeners();
    }finally{
      _isLoading = false;
      notifyListeners();
    }
  }



  Future<void> fetchPokemonDetails() async{
    if(_isDetailLoading) return;
    _errorMessage = '';
    _isDetailLoading = true;
    try{
      final query = '''
      query fetchPokemon(\$id: String!){
        pokemon(id:\$id){
          name
          id
          weight{
            minimum
            maximum
          }
          height{
            minimum
            maximum
          }
          classification
          image
        }
      }
      ''';

      final options = QueryOptions(
        document: gql(query),
        variables: {'id':_ID}
      );

      final response = await GraphQLClientService.getClient().value.query(options);
      print("Result B:  "+ response.data.toString());
      final dynamic pokemonData = response.data?['pokemon'];
      if(pokemonData!=null)
        _pokemon = Pokemon(
            name: pokemonData['name'],
            id: pokemonData['id'],
            weight: Weight(
              minimum: pokemonData['weight']['minimum'],
              maximum: pokemonData['weight']['maximum']
            ),
            height: Height(
                minimum: pokemonData['height']['minimum'],
                maximum: pokemonData['height']['maximum']
            ),
            classification: pokemonData['classification'],
            image: pokemonData['image']
        );
      notifyListeners();
    }catch(e){
      print("Detail: e=> $e");
      _hasError = true;
      _errorMessage = "Failed to fetch pokemon: ${e.toString()}";
      notifyListeners();
    }
    finally{
      _isDetailLoading = false;
      notifyListeners();
    }
  }

}