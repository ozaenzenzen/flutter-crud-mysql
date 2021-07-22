part of 'homedata_cubit.dart';

@immutable
abstract class HomedataState {}

class HomedataInitial extends HomedataState {}

class HomedataLoading extends HomedataState {}

class HomedataSuccess extends HomedataState {}

class HomedataError extends HomedataState {
  final String errorMessage;
  HomedataError(this.errorMessage);
}

class HomedataGetSuccess extends HomedataState {
  final ItemData itemData;
  HomedataGetSuccess(this.itemData);
}
