import 'package:flutter/foundation.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:pokemondemo/utils/constants.dart';

class GraphQLClientService{
  static final HttpLink _httpLink = HttpLink(AppConstants.BASE_URL);

  static final AuthLink _authLink = AuthLink(
      getToken: () async => 'AUTH TOKEN'
  );

  static final Link link = _httpLink;

  static ValueNotifier<GraphQLClient> getClient() {
    final client = GraphQLClient(
        link: link,
        cache: GraphQLCache()
    );

    return ValueNotifier(client);
  }
}