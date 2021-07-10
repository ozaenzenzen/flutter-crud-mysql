import 'package:flutter/material.dart';
import 'package:flutter_crud_mysql_1/screens/homepage.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class AdminPage extends StatefulWidget {
  @override
  _AdminPageState createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  final box = GetStorage();
  var userLevel;
  @override
  void initState() {
    userLevel = box.read('userLevel');
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
        child: (userLevel == 'admin')
            ? Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Get.to(() => HomePage());
                      },
                      child: Text("Halaman Home"),
                    ),
                    ElevatedButton(
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
