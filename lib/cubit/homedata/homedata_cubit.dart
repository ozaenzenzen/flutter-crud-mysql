import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_crud_mysql_1/model/itemdata.dart';
import 'package:flutter_crud_mysql_1/services/homedata_services.dart';
import 'package:meta/meta.dart';

part 'homedata_state.dart';

class HomedataCubit extends Cubit<HomedataState> {
  HomedataCubit() : super(HomedataInitial());

  Homedata _homedata = Homedata();

  void getItemListData() async {
    emit(HomedataLoading());

    try {
      final _data = await _homedata.getDataCubit();

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
      final _data = await _homedata.addDataCubit(itemData);

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
      final _data = await _homedata.editDataCubit(itemData);
      
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
      _homedata.deleteDataCubit(itemData);

      emit(HomedataSuccess());
    } catch (e) {
      emit(HomedataError(e.toString()));
    }
  }
}
