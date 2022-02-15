import 'package:equatable/equatable.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

abstract class Failure extends Equatable {
  var error;

  Failure([List properties = const <dynamic>[]]) : super();
}

class ServerFailure extends Failure {
  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}

class CacheFailure extends Failure {
  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}

class NoConnectionFailure extends Failure {
  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}

class DataNotFound extends Failure {
  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}

class GQException extends Failure {
  OperationException? operationException;

  GQException(this.operationException);

  OperationException? get errorMessage => operationException;

  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}
