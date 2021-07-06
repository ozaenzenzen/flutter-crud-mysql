import 'dart:convert';

import 'package:dio/dio.dart';

class Connect {
  Future<List> getData() async {
    Dio dio = Dio();
    String url = "http://10.0.2.2/flutter_crud_mysql1/get_data.php";

    final response = await dio.get(url);

    if (response.statusCode == 200) {
      // var jsonObject = response.data as List;
      // return jsonObject.map((item) => Data.createData(item)).toList();
      return json.decode(response.data);
    } else {
      throw ("Data tidak ditemukan");
    }
  }
}
