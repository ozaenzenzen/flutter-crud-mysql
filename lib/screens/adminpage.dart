import 'package:flutter/material.dart';
import 'package:flutter_crud_mysql_1/screens/homepage.dart';
import 'package:get/get.dart';

class AdminPage extends StatefulWidget {
  @override
  _AdminPageState createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
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
        child: Container(
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
        ),
      ),
    );
  }
}
