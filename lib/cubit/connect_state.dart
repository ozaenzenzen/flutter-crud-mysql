part of 'connect_cubit.dart';

@immutable
abstract class ConnectState {}

class ConnectInitial extends ConnectState {}

class ConnectSuccess extends ConnectState {}

class ConnectFail extends ConnectState {}
