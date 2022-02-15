import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:ketemaa/core/error/failures.dart';

abstract class AuthRepository {
  Future<Either<QueryResult, Failure>> signIn(
      {@required String email, @required String password});

  Future<Either<QueryResult, Failure>> signUp(@required String name , @required String email , @required String password);

  Future<Either<QueryResult, Failure>> passwordUpdate(String password);

  Future<Either<QueryResult, Failure>> emailVerification(String email);

  Future<Either<QueryResult, Failure>> phoneVerification(String num);
}
