import 'package:flutter/material.dart';
import 'package:flutter_crud_mysql_1/screens/loginpage.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
class HomePopupMenu extends StatelessWidget {
  const HomePopupMenu({
    Key? key,
    required this.box,
  }) : super(key: key);

  final GetStorage box;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      icon: Icon(
        Icons.more_vert,
        size: 35,
      ),
      onSelected: (value) {
        if (value == 1) {
        } else if (value == 2) {
        } else {
          box.remove('userUsername');
          box.remove('userPassword');
          box.remove('userLevel');
          Get.offAll(
            () => LoginPage(),
            transition: Transition.leftToRight,
          );
        }
      },
      itemBuilder: (context) {
        return [
          PopupMenuItem(
            value: 1,
            child: new Text("Profile"),
          ),
          PopupMenuItem(
            value: 2,
            child: new Text("Settings"),
          ),
          PopupMenuItem(
            value: 3,
            child: new Text("Logout"),
          ),
        ];
      },
    );
  }
}
