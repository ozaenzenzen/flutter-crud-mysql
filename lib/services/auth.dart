import 'dart:convert';
import 'package:flutter_crud_mysql_1/model/user.dart';
import 'package:dio/dio.dart';

class Auth {
  Dio dio = Dio();

  // Future<List> login(var username, var password) async {
  // Future<User> login(var username, var password) async {
  Future login(var username, var password) async {
    String url = "http://10.0.2.2/flutter_crud_mysql1/login.php";

    var data = FormData.fromMap({
      'username': username,
      'password': password,
    });

    final response = await dio.post(
      url,
      data: data,
    );

    List jsonObject = json.decode(response.data);

    if (jsonObject.isEmpty) {
      return null;
    } else {
      User userData = User.fromJson(jsonObject[0]);
      return userData;
    }
  }
}
