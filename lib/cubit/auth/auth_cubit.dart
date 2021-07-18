import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter_crud_mysql_1/model/user_model.dart';
import 'package:flutter_crud_mysql_1/services/auth_services.dart';
import 'package:get_storage/get_storage.dart';
import 'package:meta/meta.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  Auth _auth = Auth();

  void signInUser(User userData) async {
    emit(AuthLoading());

    try {
      // final _data = await _auth.login(userData.username, userData.password);
      final _data = await _auth.login(userData);

      _data.fold(
        (l) => emit(AuthError(l)),
        (r) => emit(AuthLoginSuccess(r)),
      );
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  void saveUserToLocal(User userData) async {
    emit(AuthLoading());
    try {
      GetStorage().write('userData', json.encode(userData));
      print("local save success");
      emit(AuthSuccess());
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  void loadUserFromLocal() async {
    emit(AuthLoading());
    try {
      final _data = await GetStorage().read("userData");
      final _result = User.fromJson(json.decode(_data));

      emit(AuthLoginSuccess(_result));
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  // Future<String?> getUserStorage() async {
  // Future<User?> getUserStorage() async {
  User? getUserStorage() {
    final _data = GetStorage().read("userData");
    final _result = User.fromJson(json.decode(_data));
    if (_result != (null)) {
      return _result;
    } else {
      return null;
    }
  }
}
