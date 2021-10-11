import 'package:bloc/bloc.dart';
import 'package:flutter_crud_mysql_1/model/itemdata.dart';
import 'package:flutter_crud_mysql_1/services/adddata_services.dart';
import 'package:meta/meta.dart';

part 'add_data_state.dart';

class AddDataCubit extends Cubit<AddDataState> {
  AddDataCubit() : super(AddDataInitial());
  AddDataServices _addDataServices = AddDataServices();

  void getItemListData() async {
    emit(AddDataLoading());

    try {
      final _data = await _addDataServices.getDataCubit();

      _data.fold(
        (l) => emit(AddDataError(l)),
        (r) => emit(AddDataGetSuccess(r)),
      );
    } catch (e) {
      emit(AddDataError(e.toString()));
    }
  }

  void addItemListData(ItemData itemData) async {
    emit(AddDataLoading());

    try {
      _addDataServices.addData(itemData).onError(
            (error, stackTrace) => emit(
              AddDataError(error.toString()),
            ),
          );
      emit(AddDataSuccess());

      // final _data = await _addDataServices.addDataCubit(itemData);

      // _data.fold(
      //   (l) => emit(AddDataError(l)),
      //   (r) => emit(AddDataGetSuccess(r)),
      // );
    } catch (e) {
      emit(AddDataError(e.toString()));
    }
  }

  void editItemListData(ItemData itemData) async {
    emit(AddDataLoading());

    try {
      _addDataServices.editData(itemData).onError(
            (error, stackTrace) => emit(
              AddDataError(error.toString()),
            ),
          );

      emit(AddDataSuccess());

      // final _data = await _addDataServices.editDataCubit(itemData);

      // _data.fold(
      //   (l) => emit(AddDataError(l)),
      //   (r) => emit(AddDataGetSuccess(r)),
      // );

    } catch (e) {
      emit(AddDataError(e.toString()));
    }
  }

  void deleteItemListData(String id) async {
    emit(AddDataLoading());

    try {
      // _addDataServices.deleteDataCubit(itemData).onError(
      _addDataServices.deleteData(id).onError(
            (error, stackTrace) => emit(
              AddDataError(error.toString()),
            ),
          );

      emit(AddDataSuccess());
    } catch (e) {
      emit(AddDataError(e.toString()));
    }
  }
}
