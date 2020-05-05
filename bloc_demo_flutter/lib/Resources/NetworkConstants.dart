import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class  Network {

static HttpLink httpLink = HttpLink(
  uri: 'https://accmp.embdev.in/graphql',
);

static AuthLink authLink = AuthLink(
//  getToken: () async => 'Bearer <YOUR_PERSONAL_ACCESS_TOKEN>',
  // OR
   getToken: () => 'Bearer <YOUR_PERSONAL_ACCESS_TOKEN>',
);

final Link linkWithAuth = authLink.concat(httpLink);

final Link onlyLink = httpLink;

//String getLinkwithAuth() {
//  return
//}

  ValueNotifier<GraphQLClient> client = ValueNotifier(
    GraphQLClient(
      link: httpLink,
      cache: OptimisticCache(dataIdFromObject: typenameDataIdFromObject),
    ),
  );

  GraphQLClient clientToQuery() {
    return GraphQLClient(
      cache: OptimisticCache(dataIdFromObject: typenameDataIdFromObject),
      link: httpLink,
    );
  }
}
