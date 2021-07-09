import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter_crud_mysql_1/model/data.dart';

class Connect {
  Data data = Data();
  final dio = Dio();

  // Stream<Data> getDataStream() {
  Stream<List> getDataStream() {
    return Stream.periodic(Duration(seconds: 1)).asyncMap((event) => getData());
  }

  Future<List> getData() async {
  // Future<Data> getData() async {
    String url = "http://10.0.2.2/flutter_crud_mysql1/get_data.php";

    final response = await dio.get(url);

    if (response.statusCode == 200) {
      // var jsonObject = response.data as List;
      // return jsonObject.map((item) => Data.createData(item)).toList();
      var jsonObject = json.decode(response.data);
      return jsonObject;
      // return Data.fromJson(jsonObject[0]);
    } else {
      throw ("Data tidak ditemukan");
    }
  }

  void addData(var itemcode, var itemname, var price, var stock) {
    // dio = Dio();
    String url = "http://10.0.2.2/flutter_crud_mysql1/add_data.php";

    var data = FormData.fromMap({
      'item_code': itemcode,
      'item_name': itemname,
      'price': price,
      'stock': stock,
    });

    // http.post(
    //   Uri.parse(url),
    //   body: data,
    // );

    dio.post(
      url,
      data: data,
    );
  }

  void editData(var id, var itemcode, var itemname, var price, var stock) {
    String url = "http://10.0.2.2/flutter_crud_mysql1/edit_data.php";

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
    String url = "http://10.0.2.2/flutter_crud_mysql1/delete_data.php";

    var data = FormData.fromMap({
      'id': id,
    });

    dio.post(
      url,
      data: data,
    );
  }
}
