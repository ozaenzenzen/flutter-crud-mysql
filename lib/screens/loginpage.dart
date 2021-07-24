import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_crud_mysql_1/cubit/auth/auth_cubit.dart';
import 'package:flutter_crud_mysql_1/model/user_model.dart';
import 'package:flutter_crud_mysql_1/screens/adminpage.dart';
import 'package:flutter_crud_mysql_1/screens/main_screens/mainpage.dart';
import 'package:flutter_crud_mysql_1/services/auth_services.dart';
import 'package:flutter_crud_mysql_1/widget/login_alertdialog.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
  final _formKey = GlobalKey<FormState>();

  TextEditingController userController = TextEditingController();
  TextEditingController passController = TextEditingController();

  // void loginMethod(var usernameData, var passwordData) {
  //   if (usernameData.isEmpty || passwordData.isEmpty) {
  //     print("empty text field");
  //     loginShowDialog();
  //   } else {
  //     auth.login(usernameData, passwordData).then((value) {
  //       user = value;
  //       //
  //       if (user == (null)) {
  //         print("data is null");
  //         loginShowDialog();
  //       } else {
  //         box.write('userUsername', user.username);
  //         box.write('userPassword', user.password);
  //         box.write('userLevel', user.level);
  //         if (user.level == "admin") {
  //           Get.off(() => AdminPage());
  //         } else if (user.level == "member") {
  //           Get.off(() => HomePage());
  //         } else {
  //           print("no role level");
  //           loginShowDialog();
  //         }
  //       }
  //       //
  //     });
  //   }
  // }

  Future<dynamic> loginShowDialog() {
    return showDialog(
      context: context,
      builder: (context) {
        return LoginAlertDialog(
          title: "Username / Password Salah" , 
          content: "Silakan coba login kembali" ,
        );
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
    ScreenUtil screenUtil = ScreenUtil();
    return Scaffold(
      body: SingleChildScrollView(
        child: MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => AuthCubit(),
            ),
            // BlocProvider(
            //   create: (context) => AuthCubit()..loadUserFromLocal(),
            // ),
          ],
          child: BlocConsumer<AuthCubit, AuthState>(
            listener: (context, state) {
              if (state is AuthError) {
                print("auth error");
                loginShowDialog();
              } else if (state is AuthLoading) {
                print('loading');
              } else if (state is AuthLoginSuccess) {
                print("auth login success");
                BlocProvider.of<AuthCubit>(context)
                    .saveUserToLocal(state.userData);
                if (state.userData.level == "admin") {
                  Get.off(() => AdminPage());
                } else if (state.userData.level == "member") {
                  Get.off(() => MainPage());
                }
              } else if (state is AuthSuccess) {
                print("auth success");
              }
            },
            builder: (context, state) {
              return Column(
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
                          // height: MediaQuery.of(context).size.height * 0.5,
                          height: screenUtil.setHeight(350),
                          width: double.infinity,
                        ),
                      ),
                      Positioned(
                        top: 100,
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
                        top: 180,
                        left: 25,
                        child: Text(
                          "Logbook App Login Page",
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: "SF UI",
                            fontSize: 23,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: 20,
                    ),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          //
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
                                child: TextFormField(
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Field cannot be empty';
                                    }
                                    return null;
                                  },
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

                          //
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
                                child: TextFormField(
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Field cannot be empty';
                                    }
                                    return null;
                                  },
                                  textInputAction: TextInputAction.go,
                                  onFieldSubmitted: (value) {
                                    FocusScope.of(context).unfocus();
                                    if (_formKey.currentState!.validate()) {
                                      final _requestData = User(
                                        username: userController.text,
                                        password: passController.text,
                                      );
                                      BlocProvider.of<AuthCubit>(context,
                                              listen: false)
                                          .signInUser(_requestData);
                                    }
                                  },
                                  controller: passController,
                                  obscureText: _secureText,
                                  decoration: InputDecoration(
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
                          (state is AuthLoading)
                              ? Center(
                                  child: Container(
                                    height: 30,
                                    width: 30,
                                    child: CircularProgressIndicator(),
                                  ),
                                )
                              : ElevatedButton(
                                  onPressed: () {
                                    FocusScope.of(context).unfocus();
                                    if (_formKey.currentState!.validate()) {
                                      final _requestData = User(
                                        username: userController.text,
                                        password: passController.text,
                                      );
                                      BlocProvider.of<AuthCubit>(context,
                                              listen: false)
                                          .signInUser(_requestData);
                                    }
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
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  String? validateUsername(String value) {
    if (value.length < 3) {
      if (value.isEmpty) {
        return "User can't be empty!";
      } else {
        return "User must be more than 4 character";
      }
    } else {
      return null;
    }
  }

  String? validatePassword(String value) {
    if (value.length < 5) {
      if (value.isEmpty) {
        return "Password can't be empty!";
      } else {
        return "Password must be more than 4 character";
      }
    } else {
      return null;
    }
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
