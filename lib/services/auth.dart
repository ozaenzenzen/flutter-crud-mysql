import 'dart:convert';
import 'package:flutter_crud_mysql_1/model/user.dart';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';

class Auth {
  Dio dio = Dio();

  // Future<List> login(var username, var password) async {
  Future<User> login(var username, var password) async {
    // void login(var username, var password) async {
    String url = "http://10.0.2.2/flutter_crud_mysql1/login.php";

    var data = FormData.fromMap({
      'username': username,
      'password': password,
    });

    final response = await dio.post(
      url,
      data: data,
    );

    var jsonObject = json.decode(response.data);

    return User.fromJson(jsonObject[0]);
  }
}
