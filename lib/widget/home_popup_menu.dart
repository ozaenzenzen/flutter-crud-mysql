import 'package:flutter/cupertino.dart';
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
        CupertinoIcons.ellipsis_vertical,
        color: Colors.white,
        size: 30,
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
            child: Row(
              children: [
                Icon(Icons.person),
                Container(
                  height: 30,
                  child: VerticalDivider(
                    color: Colors.black26,
                    thickness: 2.0,
                    width: 20,
                  ),
                ),
                new Text(
                  "Profile",
                  style: TextStyle(
                    fontFamily: "SF UI",
                    fontSize: 15,
                  ),
                ),
              ],
            ),
          ),
          PopupMenuItem(
            value: 2,
            child: Row(
              children: [
                Icon(Icons.settings),
                Container(
                  height: 30,
                  child: VerticalDivider(
                    color: Colors.black26,
                    thickness: 2.0,
                    width: 20,
                  ),
                ),
                new Text(
                  "Settings",
                  style: TextStyle(
                    fontFamily: "SF UI",
                    fontSize: 15,
                  ),
                ),
              ],
            ),
          ),
          PopupMenuItem(
            value: 3,
            child: Row(
              children: [
                Icon(Icons.exit_to_app),
                Container(
                  height: 30,
                  child: VerticalDivider(
                    color: Colors.black26,
                    thickness: 2.0,
                    width: 20,
                  ),
                ),
                new Text(
                  "Logout",
                  style: TextStyle(
                    fontFamily: "SF UI",
                    fontSize: 15,
                  ),
                ),
              ],
            ),
          ),
        ];
      },
    );
  }
}
