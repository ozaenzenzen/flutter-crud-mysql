import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_crud_mysql_1/model/user_model.dart';
import 'package:get_storage/get_storage.dart';

class ProfileNavigationPage extends StatefulWidget {
  const ProfileNavigationPage({Key? key}) : super(key: key);

  @override
  _ProfileNavigationPageState createState() => _ProfileNavigationPageState();
}

class _ProfileNavigationPageState extends State<ProfileNavigationPage> {
  final box = GetStorage();
  @override
  Widget build(BuildContext context) {
    var localUserData = box.read('userData');
    User userData = User.fromJson(json.decode(localUserData));
    return SafeArea(
      child: Container(
        margin: EdgeInsets.symmetric(
          vertical: 10,
          horizontal: 10,
        ),
        child: Text(
          "Your role is ${userData.username}",
          style: TextStyle(
            fontFamily: "SF UI",
            fontSize: 40,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
