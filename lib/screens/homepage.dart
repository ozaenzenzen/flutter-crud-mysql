import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_crud_mysql_1/model/itemdata.dart';
import 'package:flutter_crud_mysql_1/model/user_model.dart';
import 'package:flutter_crud_mysql_1/screens/addpage.dart';
import 'package:flutter_crud_mysql_1/screens/profilepage.dart';
import 'package:flutter_crud_mysql_1/services/homedata_services.dart';
import 'package:flutter_crud_mysql_1/widget/home_item.dart';
import 'package:flutter_crud_mysql_1/widget/home_popup_menu.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';


class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ScreenUtil screenUtil = ScreenUtil();
  ScrollController scrollController = ScrollController();
  final box = GetStorage();

  Homedata homedata = Homedata();
  ItemData data = ItemData();

  var localUserData;
  User? userData;

  @override
  void initState() {
    localUserData = box.read('userData');
    userData = User.fromJson(json.decode(localUserData));
    super.initState();
  }

  final List<Widget> _page = [
    HomePage(),
    ProfilePage(),
  ];

  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
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
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.symmetric(
            vertical: 10,
            horizontal: 10,
          ),
          child: Column(
            children: [
              SizedBox(
                height: screenUtil.setHeight(35),
              ),
              Container(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    (userData!.level == "admin")
                        ? Container(
                            padding: EdgeInsets.all(0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.cyan,
                              boxShadow: [
                                BoxShadow(
                                  offset: Offset(2, 4),
                                  blurRadius: 3,
                                  spreadRadius: 1,
                                  color: Colors.black45,
                                ),
                              ],
                            ),
                            child: IconButton(
                              icon: Icon(
                                CupertinoIcons.back,
                                color: Colors.white,
                                size: 30,
                              ),
                              onPressed: () {
                                Get.back();
                              },
                            ),
                          )
                        : Container(),
                    Container(
                      padding: EdgeInsets.all(0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            offset: Offset(2, 4),
                            blurRadius: 3,
                            spreadRadius: 1,
                            color: Colors.black45,
                          ),
                        ],
                        color: Colors.cyan,
                      ),
                      child: HomePopupMenu(box: box),
                    )
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.only(left: 20, top: 20),
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Home \nPage",
                      style: TextStyle(
                        fontFamily: "SF UI",
                        fontSize: 50,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 20, top: 5),
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "List of your logbook is here...",
                      style: TextStyle(
                        fontFamily: "SF UI",
                        fontSize: 19,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  StreamBuilder<List>(
                    stream: homedata.getDataStream(),
                    builder: (context, snapshot) {
                      var data = snapshot.data;
                      if (snapshot.hasData == true) {
                        return ListView.builder(
                          controller: scrollController,
                          shrinkWrap: true,
                          physics: ScrollPhysics(),
                          itemCount: (data == null) ? 0 : data.length,
                          itemBuilder: (context, index) {
                            return HomeItem(
                              data: data,
                              index: index,
                            );
                          },
                        );
                      } else {
                        return Center(
                          child: SizedBox(
                            height: 30,
                            width: 30,
                            child: CircularProgressIndicator(),
                          ),
                        );
                      }
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
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
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.cyan,
        onPressed: () {
          Get.to(() => AddPage());
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
