import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_crud_mysql_1/model/user.dart';
import 'package:get_storage/get_storage.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final box = GetStorage();
  @override
  Widget build(BuildContext context) {
    var localUserData = box.read('userData');
    User userData = User.fromJson(json.decode(localUserData));
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Profile",
          style: TextStyle(
            fontFamily: "SF UI",
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.cyan,
      ),
      body: Container(
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
