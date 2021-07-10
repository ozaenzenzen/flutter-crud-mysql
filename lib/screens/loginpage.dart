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
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                ClipPath(
                  clipBehavior: Clip.antiAlias,
                  clipper: MyClipper(),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.cyan,
                    ),
                    height: 450,
                    width: double.infinity,
                  ),
                ),
                Positioned(
                  top: 120,
                  left: 20,
                  child: Text(
                    "Welcome!",
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: "SF UI",
                      fontSize: 60,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Positioned(
                  top: 200,
                  left: 25,
                  child: Text(
                    "Login Page",
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: "SF UI",
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            Container(
              margin: EdgeInsets.symmetric(
                vertical: 15,
                horizontal: 20,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
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
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.cyan.shade100,
                              offset: Offset(0, 10),
                              spreadRadius: 1,
                              blurRadius: 10,
                            ),
                          ],
                        ),
                        child: TextField(
                          controller: userController,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            labelText: "Email / Username",
                            labelStyle: TextStyle(
                              fontFamily: "SF Text",
                              fontSize: 13,
                            ),
                          ),
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
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.cyan.shade100,
                              offset: Offset(0, 10),
                              spreadRadius: 1,
                              blurRadius: 10,
                            ),
                          ],
                        ),
                        child: TextField(
                          controller: passController,
                          obscureText: _secureText,
                          decoration: InputDecoration(
                            // border: OutlineInputBorder(),
                            border: InputBorder.none,
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
                              fontSize: 13,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 35,
                  ),
                  ElevatedButton(
                    onPressed: () {
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
          ],
        ),
      ),
    );
  }
}

class AppTextField extends StatelessWidget {
  const AppTextField({
    Key? key,
    required this.userController,
  }) : super(key: key);

  final TextEditingController userController;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.cyan.shade100,
            offset: Offset(0, 10),
            spreadRadius: 1,
            blurRadius: 10,
          ),
        ],
      ),
      child: TextField(
        controller: userController,
        decoration: InputDecoration(
          border: InputBorder.none,
          labelText: "Email / Username",
          labelStyle: TextStyle(
            fontFamily: "SF Text",
            fontSize: 13,
          ),
        ),
      ),
    );
  }
}

class MyClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, size.height - 100);
    path.quadraticBezierTo(
        size.width / 4, size.height / 2, size.width / 2, size.height - 100);
    path.quadraticBezierTo(size.width - (size.width / 4), size.height + 10,
        size.width, size.height - 10);
    path.lineTo(size.width, 0);
    path.close();
    return path;
    // throw UnimplementedError();
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    // throw UnimplementedError();
    return true;
  }
}
