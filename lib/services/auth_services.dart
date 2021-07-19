import 'dart:convert';
import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:flutter_crud_mysql_1/model/user_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter_crud_mysql_1/urls/urls.dart';
import 'package:html/parser.dart';

class Auth {
  Dio dio = Dio();

  Future<Either<String, User>> login(User user) async {
    // dynamic _response;
    Response _response;
    // HttpClientResponse _response;
    String url = Urls.BASE_URL + "login.php";

    try {
      var data = FormData.fromMap({
        'username': user.username,
        'password': user.password,
      });

      _response = await dio.post(
        url,
        data: data,
        options: Options(
          headers: {
            'Content-type': 'application/json',
            'Accept': 'application/json',
          },
          contentType: Headers.jsonContentType,
          responseType: ResponseType.json,
        ),
      );

      // print("data nih: ${_response.data}");
      // print("data nih:: ${_response.headers}");
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
