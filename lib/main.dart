import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_crud_mysql_1/model/user_model.dart';
import 'package:flutter_crud_mysql_1/screens/adminpage.dart';
import 'package:flutter_crud_mysql_1/screens/main_screens/mainpage.dart';
import 'package:flutter_crud_mysql_1/screens/loginpage.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
    var localData = box.read('userData');
    User? userData;
    
    if (localData == (null)) {
      userData = null;
    } else {
      userData = User.fromJson(json.decode(box.read('userData')));
    }

    return ScreenUtilInit(
      builder: () => GetMaterialApp(
        // home: DataPage(),
        home: (userData == (null))
            ? LoginPage()
            : (userData.level == "admin")
                ? AdminPage()
                : (userData.level == "member")
                    ? MainPage()
                    : LoginPage(),
        debugShowCheckedModeBanner: false,
        defaultTransition: Transition.cupertino,
      ),
    );
  }
}
