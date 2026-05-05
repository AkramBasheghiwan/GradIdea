import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String message;
  const Failure(this.message);

  @override
  List<Object> get props => [message];
}

class ServerFailure extends Failure {
  const ServerFailure(super.message);
}

class EmailNotVerifiedFailure extends Failure {
  const EmailNotVerifiedFailure(super.message);
}

class NetworkFailure extends Failure {
  const NetworkFailure(super.message);
}

class OfflineFailure extends Failure {
  const OfflineFailure(super.message);
}
