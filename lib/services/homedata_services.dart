import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_crud_mysql_1/model/itemdata.dart';
import 'package:flutter_crud_mysql_1/urls/urls.dart';

class Homedata {
  ItemData data = ItemData();
  final dio = Dio();

  Future<Either<String, List>> getDataCubit() async {
    Response _response;
    String url = Urls.BASE_URL + "get_data.php";

    try {
      _response = await dio.get(url);

      var jsonObject = json.decode(_response.data);

      List _itemDataResp = jsonObject as List;
      // ItemData _itemDataResp = ItemData.fromJson(jsonObject);
      return right(_itemDataResp);
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

  Future<Either<String, ItemData>> addDataCubit(ItemData itemData) async {
    Response _response;
    String url = Urls.BASE_URL + "add_data.php";

    try {
      var data = FormData.fromMap({
        'item_code': itemData.itemCode,
        'item_name': itemData.itemName,
        'price': itemData.price,
        'stock': itemData.stock,
      });

      _response = await dio.post(url, data: data);

      var jsonObject = json.decode(_response.data);

      ItemData _itemDataResp = ItemData.fromJson(jsonObject);
      return right(_itemDataResp);
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

  Future<Either<String, ItemData>> editDataCubit(ItemData itemData) async {
    Response _response;
    String url = Urls.BASE_URL + "get_data.php";

    try {
      var data = FormData.fromMap({
        'id': itemData.id,
        'item_code': itemData.itemCode,
        'item_name': itemData.itemName,
        'price': itemData.price,
        'stock': itemData.stock,
      });

      _response = await dio.post(url, data: data);

      var jsonObject = json.decode(_response.data);

      ItemData _itemDataResp = ItemData.fromJson(jsonObject);
      return right(_itemDataResp);
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

  Future<Either<String, ItemData>> deleteDataCubit(ItemData itemData) async {
    Response _response;
    String url = Urls.BASE_URL + "delete_data.php";

    try {
      var data = FormData.fromMap({
        'id': itemData.id,
      });

      _response = await dio.post(url, data: data);

      var jsonObject = json.decode(_response.data);

      ItemData _itemDataResp = ItemData.fromJson(jsonObject);
      return right(_itemDataResp);
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

  Stream<List> getDataStream() {
    return Stream.periodic(Duration(seconds: 1)).asyncMap((event) => getData());
  }

  Future<List> getData() async {
    String url = Urls.BASE_URL + "get_data.php";

    final response = await dio.get(url);

    if (response.statusCode == 200) {
      var jsonObject = json.decode(response.data);
      return jsonObject;
    } else {
      throw ("Data tidak ditemukan");
    }
  }

  void addData(var itemcode, var itemname, var price, var stock) {
    String url = Urls.BASE_URL + "add_data.php";

    var data = FormData.fromMap({
      'item_code': itemcode,
      'item_name': itemname,
      'price': price,
      'stock': stock,
    });

    dio.post(
      url,
      data: data,
    );
  }

  void editData(var id, var itemcode, var itemname, var price, var stock) {
    String url = Urls.BASE_URL + "edit_data.php";

    var data = FormData.fromMap({
      'id': id,
      'item_code': itemcode,
      'item_name': itemname,
      'price': price,
      'stock': stock,
    });

    dio.post(
      url,
      data: data,
    );
  }

  void deleteData(var id) {
    String url = Urls.BASE_URL + "delete_data.php";

    var data = FormData.fromMap({
      'id': id,
    });

    dio.post(
      url,
      data: data,
    );
  }
}
