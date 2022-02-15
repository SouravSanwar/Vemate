import 'package:dartz/dartz.dart';
import 'package:graphql/src/core/query_result.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:ketemaa/core/error/failures.dart';
import 'package:ketemaa/core/graphQLConfig/graphql_config.dart';
import 'package:ketemaa/features/place_a_add/data/repository/place_add_repository.dart';

class PlaceAddRemoteRepository extends PlaceAddRepository {
  @override
  Future<Either<QueryResult, Failure>> placeAddCities() async {
    Either<QueryResult, Failure> _cityResponse;
    var cities = '''
    query{
      cities{
        totalCount
        edges{
          node{
            region
            city
            objectId
            usageStatus
            id
          }
        }
      }
    }
   ''';

    try {
      if (true) {
        QueryResult _categoryResult =
            await AppGraphQLConfiguration.clientToQuery().query(QueryOptions(
          document: gql(cities),
        ));
        _cityResponse = Left(_categoryResult);
      } else {
        _cityResponse = Right(DataNotFound());
      }
    } on Exception catch (e) {
      _cityResponse = Right(ServerFailure());
    }

    return _cityResponse;
    //printInfo(info: "$_TAG gq response :: ${queryResult.data} ");
  }
}
