part of 'connect_cubit.dart';

@immutable
abstract class ConnectState {}

class ConnectInitial extends ConnectState {}

class ConnectLoading extends ConnectState {}

class ConnectSuccess extends ConnectState {}

class ConnectError extends ConnectState {
  final String errorMessage;
  ConnectError(this.errorMessage);
}

class ConnectLoginSuccess extends ConnectState {
  final User userData;
  ConnectLoginSuccess(this.userData);
}
