import 'package:dartz/dartz.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:ketemaa/core/error/failures.dart';
import 'package:ketemaa/features/auth/data/Repository/authentication_repository.dart';

class AuthenticationLocalRepository extends AuthRepository{
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
  Future<Either<QueryResult, Failure>> signIn({String? email , String? password}) {
    // TODO: implement signIn
    throw UnimplementedError();
  }

  @override
  Future<Either<QueryResult, Failure>> signUp(String name, String email, String password) {
    // TODO: implement signUp
    throw UnimplementedError();
  }



}