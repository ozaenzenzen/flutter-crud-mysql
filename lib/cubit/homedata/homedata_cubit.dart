import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_crud_mysql_1/model/itemdata.dart';
import 'package:flutter_crud_mysql_1/services/adddata_services.dart';
import 'package:meta/meta.dart';

part 'homedata_state.dart';

class HomedataCubit extends Cubit<HomedataState> {
  HomedataCubit() : super(HomedataInitial());

  AddDataServices _addDataServices = AddDataServices();

  void getItemListData() async {
    emit(HomedataLoading());

    try {
      final _data = await _addDataServices.getDataCubit();

      _data.fold(
        (l) => emit(HomedataError(l)),
        (r) => emit(HomedataGetSuccess(r)),
      );
    } catch (e) {
      emit(HomedataError(e.toString()));
    }
  }

  void addItemListData(ItemData itemData) async {
    emit(HomedataLoading());

    try {
      final _data = await _addDataServices.addDataCubit(itemData);

      _data.fold(
        (l) => emit(HomedataError(l)),
        (r) => emit(HomedataGetSuccess(r)),
      );
      // emit(HomedataSuccess());
    } catch (e) {
      emit(HomedataError(e.toString()));
    }
  }

  void editItemListData(ItemData itemData) async {
    emit(HomedataLoading());

    try {
      final _data = await _addDataServices.editDataCubit(itemData);
      
      _data.fold(
        (l) => emit(HomedataError(l)),
        (r) => emit(HomedataGetSuccess(r)),
      );

      // emit(HomedataSuccess());
    } catch (e) {
      emit(HomedataError(e.toString()));
    }
  }

  void deleteItemListData(ItemData itemData) async {
    emit(HomedataLoading());

    try {
      _addDataServices.deleteDataCubit(itemData);

      emit(HomedataSuccess());
    } catch (e) {
      emit(HomedataError(e.toString()));
    }
  }
}
