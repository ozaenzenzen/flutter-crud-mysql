part of 'add_data_cubit.dart';

@immutable
abstract class AddDataState {}

class AddDataInitial extends AddDataState {}

class AddDataLoading extends AddDataState {}

class AddDataSuccess extends AddDataState {}

class AddDataError extends AddDataState {
  final String errorMessage;
  AddDataError(this.errorMessage);
}

class AddDataGetSuccess extends AddDataState {
  final List itemData;
  AddDataGetSuccess(this.itemData);
}
