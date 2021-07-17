import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:flutter_crud_mysql_1/model/user.dart';
import 'package:dio/dio.dart';

class Auth {
  Dio dio = Dio();

  // Future login(var username, var password) async {
  //   String url = "http://10.0.2.2/flutter_crud_mysql1/login.php";

  //   var data = FormData.fromMap({
  //     'username': username,
  //     'password': password,
  //   });

  //   final response = await dio.post(
  //     url,
  //     data: data,
  //   );

  //   List jsonObject = json.decode(response.data);

  //   if (jsonObject.isEmpty) {
  //     return null;
  //   } else {
  //     User userData = User.fromJson(jsonObject[0]);
  //     return userData;
  //   }
  // }

  // Future<Either<String, User>> login2(User user) async {
  Future<Either<String, User>> login(User user) async {
    Response _response;
    String url = "http://10.0.2.2/flutter_crud_mysql1/login.php";
    try {
      var data = FormData.fromMap({
        'username': user.username,
        'password': user.password,
      });

      _response = await dio.post(url, data: data);
      List jsonObject = json.decode(_response.data);
      User _userResp = User.fromJson(jsonObject[0]);
      return right(_userResp);
    } on DioError catch (e) {
      print(e.response!.statusCode);
      String errorMessage = e.response!.data.toString();

      switch (e.type) {
        case DioErrorType.connectTimeout:
          break;
        case DioErrorType.sendTimeout:
          break;
        case DioErrorType.receiveTimeout:
          break;
        case DioErrorType.response:
          errorMessage = e.response!.data['message'];
          break;
        case DioErrorType.cancel:
          break;
        case DioErrorType.other:
          break;
      }
      return left(errorMessage);
    }
  }
}
