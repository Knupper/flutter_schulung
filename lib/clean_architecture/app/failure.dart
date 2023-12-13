abstract class Failure {}

class ServerFailure extends Failure {
  ServerFailure();
}

class CacheFailure extends Failure {
  CacheFailure();
}

class NoInternetConnectionFailure extends Failure {
  NoInternetConnectionFailure();
}

class OutOfRangeFailure extends Failure {
  OutOfRangeFailure();
}

class UnknownFailure extends Failure {
  UnknownFailure();
}
