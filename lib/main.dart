import 'package:flutter/material.dart';
import 'package:flutter_crud_mysql_1/screens/loginpage.dart';
import 'package:get/get.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      home: LoginPage(),
      debugShowCheckedModeBanner: false,
      defaultTransition: Transition.cupertino,
    );
  }
}
