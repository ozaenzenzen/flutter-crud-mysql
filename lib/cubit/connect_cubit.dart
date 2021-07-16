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
      final _data = await _auth.login(userData.username, userData.password);

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
      // GetStorage().write('userData', jsonDecode(userData));

      GetStorage().write('userUsername', userData.username);
      GetStorage().write('userPassword', userData.password);
      GetStorage().write('userLevel', userData.level);
      emit(ConnectSuccess());
    } catch (e) {
      emit(ConnectError(e.toString()));
    }
  }

  void loadUserFromLocal() async {
    emit(ConnectLoading());
    try{
      // final _userData = GetStorage.read('userData');

      final _userUsername = GetStorage().read('userUsername');
      final _userPassword = GetStorage().read('userPassword');
      final _userLevel = GetStorage().read('userLevel');

      emit(ConnectLoginSuccess(_userUsername));
      
    }
    catch(e){
      emit(ConnectError(e.toString()));
    }
  }
}
