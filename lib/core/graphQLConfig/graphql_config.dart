import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class AppGraphQLConfiguration {
  static HttpLink httpLink = HttpLink(
    'http://65.1.64.139/graphql/',
  );

 static ValueNotifier<GraphQLClient> client = ValueNotifier(
    GraphQLClient(
      link: httpLink,
      cache: GraphQLCache(
        store: InMemoryStore(),
      ),
    ),
  );

 static GraphQLClient clientToQuery() {
    return GraphQLClient(
      cache: GraphQLCache(
        store: InMemoryStore(),
      ),
      link: httpLink,
    );
  }
}
