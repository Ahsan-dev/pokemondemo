
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:pokemondemo/data/data%20source/remote/gql/grapgql_client.dart';
import 'package:pokemondemo/provider/pokemon_provider.dart';
import 'package:pokemondemo/screens/pokemon_detail.dart';
import 'package:pokemondemo/screens/pokemon_list_screen.dart';
import 'package:pokemondemo/screens/splash_screen.dart';
import 'package:provider/provider.dart';
import 'package:pokemondemo/utils/app_routers.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final router = FluroRouter();
    configureRoutes(router);
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => PokemonProvider()),
        Provider<FluroRouter>.value(value: router),
      ],
      child: GraphQLProvider(
        client: GraphQLClientService.getClient(),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          onGenerateRoute: router.generator,
          home: const SplashScreen(),
        ),
      ),
    );
  }



  void configureRoutes(FluroRouter router){
    router.define(AppRouters.POKEMON_LIST_ROUTE, handler: Handler(handlerFunc: (_,__)=>PokemonListScreen()));
    router.define("${AppRouters.POKEMON_DETAIL_ROUTE}/:id",
        handler: Handler(handlerFunc: (context, params){
          final String id = params['id']?.first??'';
          return PokemonDetail(pokemonId: id);
        })
    );
  }
}
