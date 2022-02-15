import 'package:dartz/dartz.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:ketemaa/core/error/failures.dart';

abstract class PlaceAddRepository {
  Future<Either<QueryResult, Failure>> placeAddCities();
}
