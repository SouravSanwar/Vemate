import 'package:dartz/dartz.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:ketemaa/core/error/failures.dart';

abstract class HomeRepository {
  Future<Either<QueryResult, Failure>> category();
  Future<Either<QueryResult, Failure>> propertyForRent({var city});
}
