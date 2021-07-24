import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_crud_mysql_1/screens/main_screens/homepage.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'package:flutter_crud_mysql_1/cubit/homedata/homedata_cubit.dart';
import 'package:flutter_crud_mysql_1/model/itemdata.dart';
import 'package:flutter_crud_mysql_1/model/user_model.dart';
import 'package:flutter_crud_mysql_1/screens/addpage.dart';
import 'package:flutter_crud_mysql_1/screens/main_screens/profilepage.dart';
import 'package:flutter_crud_mysql_1/services/homedata_services.dart';
import 'package:flutter_crud_mysql_1/widget/home_item.dart';
import 'package:flutter_crud_mysql_1/widget/home_popup_menu.dart';
import 'package:flutter_crud_mysql_1/widget/login_alertdialog.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  ScreenUtil screenUtil = ScreenUtil();
  ScrollController scrollController = ScrollController();
  final box = GetStorage();

  Homedata homedata = Homedata();
  ItemData data = ItemData();

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

  Future<dynamic> loginShowDialog() {
    return showDialog(
      context: context,
      builder: (context) {
        return LoginAlertDialog(
          title: "Error",
          content: "Data tidak tersedia, silakan cek kembali koneksi Anda",
        );
      },
    );
  }

  int selectedIndex = 0;

  List _itemdata = [];
  @override
  Widget build(BuildContext context) {
    List<Widget> _page = <Widget>[
      HomeNavigationPage(userData, _itemdata, box),
      ProfileNavigationPage(),
    ];

    return Scaffold(
      // appBar: AppBar(
      //   title: Text(
      //     "Home Page",
      //     style: TextStyle(
      //       fontFamily: "SF UI",
      //       fontSize: 22,
      //       fontWeight: FontWeight.bold,
      //     ),
      //   ),
      //   backgroundColor: Colors.cyan,
      //   centerTitle: true,
      //   elevation: 0,
      //   actions: [
      //     Container(
      //       padding: EdgeInsets.all(0),
      //       child: HomePopupMenu(box: box),
      //     )
      //   ],
      // ),
      body: _page.elementAt(selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedIndex,
        selectedItemColor: Colors.cyan,
        onTap: (index) {
          setState(() {
            selectedIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            label: "Home",
            icon: Icon(CupertinoIcons.house_fill),
          ),
          BottomNavigationBarItem(
            label: "Profile",
            icon: Icon(CupertinoIcons.person_fill),
          ),
        ],
      ),
    );
  }
}
