import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;

class Connect {
  final dio = Dio();
  Future<List> getData() async {
    // dio = Dio();
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

  void addData(var itemcode, var itemname, var price, var stock) {
    // dio = Dio();
    String url = "http://10.0.2.2/flutter_crud_mysql1/add_data.php";

    var data = {
      'item_code': itemcode,
      'item_name': itemname,
      'price': price,
      'stock': stock,
    };
    // http.post(
    //   Uri.parse(url),
    //   body: data,
    // );

    dio.post(
      url,
      data: {
        'item_code': 'x',
        'item_name': 'x',
        'price': 'x',
        'stock': 'x',
      },
      // options: Options(method: 'POST'),
    );
  }
}
