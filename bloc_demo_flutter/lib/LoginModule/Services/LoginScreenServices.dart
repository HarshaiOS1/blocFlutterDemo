import 'dart:io';
import 'package:async/async.dart';
import 'package:blocdemoflutter/Resources/NetworkConstants.dart';
import 'package:flutter/cupertino.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class LoginScreenServices {
  ValueNotifier<GraphQLClient> client = ValueNotifier(
    GraphQLClient(
      link: Network.httpLink,
      cache: OptimisticCache(dataIdFromObject: typenameDataIdFromObject),
    ),
  );

  void loginNewUser() async {
    GraphQLClient _client = Network().clientToQuery();

    QueryResult result = await _client.mutate(
      MutationOptions(
        documentNode: gql(QuaryForLogin().createUser("Mr", "Harsha", "Jyothi", "chetia" ,"Bangalore@123",
            "harsha@embitel.com", "1990-06-09", 1, true)),
      ),

    );
    print(result);
    print(result.hasException);
    print(result);
  }
}

class QuaryForLogin {
   createUser(String prefix, String firstName, String middlename, String lastname,
      String password, String email, String date_of_birth, int gender, bool is_subscribed) {
    return """
      mutation {
            createCustomer(
                    input: {
                      prefix: "$prefix"
                      firstname: "$firstName"
                      middlename: "$middlename"
                      lastname: "$lastname"
                      password: "$password"
                      email: "$email"
                      date_of_birth: "$date_of_birth"
                      gender: $gender
                      is_subscribed: $is_subscribed

             })
             {
              customer {
                  firstname
                  middlename
                  lastname
                  email
                }
               }
               }
    """;
  }
}