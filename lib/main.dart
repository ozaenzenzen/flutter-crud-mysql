import 'package:flutter/material.dart';
import 'package:flutter_crud_mysql_1/screens/adminpage.dart';
import 'package:flutter_crud_mysql_1/screens/homepage.dart';
import 'package:flutter_crud_mysql_1/screens/loginpage.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

void main() async {
  await GetStorage.init();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    final box = GetStorage();
    var userUsername = box.read('userUsername');
    var userPassword = box.read('userPassword');
    var userLevel = box.read('userLevel');

    return GetMaterialApp(
      home: (userUsername == null)
          ? LoginPage()
          : (userLevel == "admin")
              ? AdminPage()
              : (userLevel == "member")
                  ? HomePage()
                  : LoginPage(),
      debugShowCheckedModeBanner: false,
      defaultTransition: Transition.cupertino,
    );
  }
}
