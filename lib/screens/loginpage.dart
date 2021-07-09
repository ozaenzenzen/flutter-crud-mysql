import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_crud_mysql_1/model/user.dart';
import 'package:flutter_crud_mysql_1/screens/adminpage.dart';
import 'package:flutter_crud_mysql_1/screens/homepage.dart';
import 'package:flutter_crud_mysql_1/services/auth.dart';
import 'package:flutter_crud_mysql_1/widget/login_alertdialog.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  Auth auth = Auth();
  User user = User();
  final box = GetStorage();

  TextEditingController userController = TextEditingController();
  TextEditingController passController = TextEditingController();

  void loginMethod(var usernameData, var passwordData) {
    if (usernameData.isEmpty || passwordData.isEmpty) {
      // if (userController.text.isEmpty || passController.text.isEmpty) {
      print("empty text field");
      loginShowDialog();
    } else {
      auth.login(usernameData, passwordData).then((value) {
        user = value;
        //
        if (user.isNull) {
          print("data is null");
          loginShowDialog();
        } else {
          box.write('userUsername', user.username);
          box.write('userPassword', user.password);
          box.write('userLevel', user.level);
          if (user.level == "admin") {
            Get.off(() => AdminPage());
          } else if (user.level == "member") {
            Get.off(() => HomePage());
          } else {
            print("no role level");
            loginShowDialog();
          }
        }
        //
      });
    }
  }

  Future<dynamic> loginShowDialog() {
    return showDialog(
      context: context,
      builder: (context) {
        return LoginAlertDialog();
      },
    );
  }

  @override
  void dispose() {
    userController.dispose();
    passController.dispose();
    super.dispose();
  }

  bool _secureText = true;

  @override
  Widget build(BuildContext context) {
    // dispose();
    // userController.text = "";
    // passController.text = "";

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
                  // onChanged: (value) => userController.text = value,
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
                  // onChanged: (value) {
                  //   setState(() {
                  //     passController.text = value;
                  //   });
                  // },
                  controller: passController,
                  obscureText: _secureText,
                  decoration: InputDecoration(
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          _secureText = !_secureText;
                        });
                      },
                      icon: Icon((_secureText)
                          ? CupertinoIcons.eye_fill
                          : CupertinoIcons.eye_slash_fill),
                    ),
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
                print(userController.text);
                print(passController.text);
                loginMethod(
                  userController.text,
                  passController.text,
                );
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
