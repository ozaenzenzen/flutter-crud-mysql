import 'package:bloc/bloc.dart';
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
}
