import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter_crud_mysql_1/model/user.dart';
import 'package:flutter_crud_mysql_1/services/auth.dart';
import 'package:get_storage/get_storage.dart';
import 'package:meta/meta.dart';

part 'connect_state.dart';

class ConnectCubit extends Cubit<ConnectState> {
  ConnectCubit() : super(ConnectInitial());

  Auth _auth = Auth();

  void signInUser(User userData) async {
    emit(ConnectLoading());

    try {
      // final _data = await _auth.login(userData.username, userData.password);
      final _data = await _auth.login(userData);

      _data.fold(
        (l) => emit(ConnectError(l)),
        (r) => emit(ConnectLoginSuccess(r)),
      );
    } catch (e) {
      emit(ConnectError(e.toString()));
    }
  }

  void saveUserToLocal(User userData) async {
    emit(ConnectLoading());
    try {
      GetStorage().write('userData', json.encode(userData));

      emit(ConnectSuccess());
    } catch (e) {
      emit(ConnectError(e.toString()));
    }
  }

  void loadUserFromLocal() async {
    emit(ConnectLoading());
    try {
      final _data = await GetStorage().read("userData");
      final _result = User.fromJson(json.decode(_data));

      emit(ConnectLoginSuccess(_result));
    } catch (e) {
      emit(ConnectError(e.toString()));
    }
  }

  Future<String?> getUserStorage() async {
    final _data = await GetStorage().read("userData");
    if (_data != null) {
      return _data;
    } else {
      return null;
    }
  }
}
