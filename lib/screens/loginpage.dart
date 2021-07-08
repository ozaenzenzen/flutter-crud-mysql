import 'package:flutter/material.dart';
import 'package:flutter_crud_mysql_1/model/user.dart';
import 'package:flutter_crud_mysql_1/screens/adminpage.dart';
import 'package:flutter_crud_mysql_1/screens/homepage.dart';
import 'package:flutter_crud_mysql_1/services/auth.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController userController = TextEditingController();
  TextEditingController passController = TextEditingController();
  Auth auth = Auth();
  User user = User();
  final box = GetStorage();

  void loginMethod() {
    if (userController.text.isEmpty || passController.text.isEmpty) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Username / Password Salah"),
            content: Text("Silakan coba login kembali"),
            actions: [
              TextButton(
                onPressed: () {
                  Get.back();
                },
                child: Text("OK"),
              ),
            ],
          );
        },
      );
    } else {
      auth.login(userController.text, passController.text).then((value) {
        user = value;
        box.write('userUsername', user.username);
        box.write('userPassword', user.password);
        box.write('userLevel', user.level);
      });
      if (user.level == "admin") {
        Get.off(() => AdminPage());
      } else if (user.level == "member") {
        Get.off(() => HomePage());
      } else {}
    }
  }

  @override
  Widget build(BuildContext context) {
    userController.text = "";
    passController.text = "";

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.cyan,
        elevation: 0,
        centerTitle: true,
        title: Text(
          "Login Page",
          style: TextStyle(
            fontFamily: "SF UI",
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Container(
        margin: EdgeInsets.symmetric(
          vertical: 15,
          horizontal: 20,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //Email/username Text Field
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Email / Username",
                  style: TextStyle(
                    fontFamily: "SF Text",
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                TextField(
                  controller: userController,
                  decoration: InputDecoration(
                    labelText: "Email / Username",
                    labelStyle: TextStyle(
                      fontFamily: "SF Text",
                    ),
                    border: OutlineInputBorder(),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),

            //Password Text Field
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Password",
                  style: TextStyle(
                    fontFamily: "SF Text",
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                TextField(
                  controller: passController,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: "Password",
                    labelStyle: TextStyle(
                      fontFamily: "SF Text",
                    ),
                    border: OutlineInputBorder(),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 35,
            ),
            ElevatedButton(
              onPressed: () {
                loginMethod();
              },
              style: ElevatedButton.styleFrom(
                minimumSize: Size(120, 50),
                primary: Colors.cyan,
              ),
              child: Text(
                "Login",
                style: TextStyle(
                  fontFamily: "SF Text",
                  fontSize: 17,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
