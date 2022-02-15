import 'package:dartz/dartz.dart';
import 'package:get/get.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:ketemaa/core/error/failures.dart';
import 'package:ketemaa/core/graphQLConfig/graphql_config.dart';
import 'package:ketemaa/features/auth/data/Repository/authentication_repository.dart';

class AuthenticationRemoteRepository extends AuthRepository {
  String _TAG = "_AuthenticationRemoteRepository";

  @override
  Future<Either<QueryResult, Failure>> emailVerification(String email) {
    // TODO: implement emailVerification
    throw UnimplementedError();
  }

  @override
  Future<Either<QueryResult, Failure>> passwordUpdate(String password) {
    // TODO: implement passwordUpdate
    throw UnimplementedError();
  }

  @override
  Future<Either<QueryResult, Failure>> phoneVerification(String num) {
    // TODO: implement phoneVerification
    throw UnimplementedError();
  }

  @override
  Future<Either<QueryResult, Failure>> signIn(
      {String? email, String? password}) async {
    Either<QueryResult, Failure> _signInResponse;
    var userLogin = '''
    mutation {
        loginUser(email: "$email", password: "$password"){
          success
          access
          refresh
          user{
            username
            email
            phone
          }
        }
    }
   ''';

    try {
      QueryResult _signInResult =
          await AppGraphQLConfiguration.clientToQuery().mutate(MutationOptions(
        document: gql(userLogin),
      ));

      if (_signInResult.exception == null) {
        printInfo(info: '58' + _signInResult.exception.toString());
        _signInResponse = Left(_signInResult);
      } else {
        printInfo(info: '62 ' + _signInResult.exception.toString());
        _signInResponse = Right(GQException(_signInResult.exception));
      }
/*
      printInfo(
          info:
              "$_TAG gq response :: ${_signInResult.exception!.graphqlErrors[0].message} ");*/
    } on Exception catch (e) {
      _signInResponse = Right(ServerFailure());
      printInfo(info: 'Catch');
    }
    return _signInResponse;
  }

  @override
  Future<Either<QueryResult, Failure>> signUp(
      String name, String email, String password) async {
    Either<QueryResult, Failure> _response;
    var userLogin = '''
    mutation{
  registerUser(username: "${name}", email: "${email}", password: "${password}"){
    user {
      id
    }
  }
}
   ''';

    try {
      QueryResult _query =
          await AppGraphQLConfiguration.clientToQuery().mutate(MutationOptions(
        document: gql(userLogin),
      ));

      if (_query.exception == null) {
        printInfo(info: '58' + _query.exception.toString());
        _response = Left(_query);
      } else {
        printInfo(info: '62 ' + _query.exception.toString());
        _response = Right(GQException(_query.exception));
      }
/*
      printInfo(
          info:
              "$_TAG gq response :: ${_signInResult.exception!.graphqlErrors[0].message} ");*/
    } on Exception catch (e) {
      _response = Right(ServerFailure());
      printInfo(info: 'Catch');
    }
    return _response;
  }
}
