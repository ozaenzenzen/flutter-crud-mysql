import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_crud_mysql_1/model/user_model.dart';
import 'package:flutter_crud_mysql_1/screens/homepage.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class AdminPage extends StatefulWidget {
  @override
  _AdminPageState createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  final box = GetStorage();
  var localUserData;
  User? userData;

  @override
  void initState() {
    if (box.read('userData') != null) {
      localUserData = box.read('userData');
      userData = User.fromJson(json.decode(localUserData));
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Admin Page",
          style: TextStyle(
            fontFamily: "SF UI",
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.cyan,
        centerTitle: true,
        elevation: 0,
      ),
      body: Center(
        child: (userData!.level == 'admin')
            ? Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.cyan,
                      ),
                      onPressed: () {
                        Get.to(() => HomePage());
                      },
                      child: Text("Halaman Home"),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.cyan,
                      ),
                      onPressed: () {},
                      child: Text("Daftar Akun Member"),
                    ),
                  ],
                ),
              )
            : Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("You're not an admin!"),
                    ElevatedButton(
                      onPressed: () {
                        Get.to(() => HomePage());
                      },
                      child: Text("Halaman Home"),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
