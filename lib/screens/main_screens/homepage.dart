

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_crud_mysql_1/cubit/homedata/homedata_cubit.dart';
import 'package:flutter_crud_mysql_1/model/itemdata.dart';
import 'package:flutter_crud_mysql_1/model/user_model.dart';
import 'package:flutter_crud_mysql_1/screens/addpage.dart';
import 'package:flutter_crud_mysql_1/screens/adminpage.dart';
import 'package:flutter_crud_mysql_1/widget/home_item.dart';
import 'package:flutter_crud_mysql_1/widget/home_popup_menu.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart'
    as transition;

// ignore: must_be_immutable
class HomeNavigationPage extends StatefulWidget {
  User? userData;
  List? _itemdata;
  var box;

  HomeNavigationPage(
    this.userData,
    this._itemdata,
    this.box,
  );

  @override
  _HomeNavigationPageState createState() => _HomeNavigationPageState();
}

class _HomeNavigationPageState extends State<HomeNavigationPage> {
  User? userData;
  List? itemdata;
  var box;

  @override
  void initState() {
    userData = widget.userData;
    itemdata = widget._itemdata;
    box = widget.box;
    BlocProvider.of<HomedataCubit>(context, listen: false).getItemListData();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomedataCubit, HomedataState>(
      listener: (context, state) {
        if (state is HomedataError) {
          print("Home data error");
          // loginShowDialog();
        } else if (state is HomedataLoading) {
          print('loading');
        } else if (state is HomedataGetSuccess) {
          print("Home data get success");
          itemdata = state.itemData;
        } else if (state is HomedataSuccess) {
          print("Home data success");
        }
      },
      bloc: HomedataCubit()..getItemListData(),
      builder: (context, state) {
        if (state is HomedataError) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else {
          return SafeArea(
            child: Container(
              child: Stack(
                children: [
                  Container(),
                  SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    child: Container(
                      margin: EdgeInsets.only(
                        top: 70,
                        left: 10,
                        right: 10,
                      ),
                      child: Column(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                margin: EdgeInsets.only(left: 10),
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "Home Page",
                                  style: TextStyle(
                                    fontFamily: "SF UI",
                                    fontSize: 50,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(left: 10, top: 5),
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
                              (state is HomedataLoading)
                                  ? Center(
                                      child: Container(
                                        height: 30,
                                        width: 30,
                                        child: CircularProgressIndicator(
                                          color: Colors.cyan[800],
                                        ),
                                      ),
                                    )
                                  : ListView.builder(
                                      shrinkWrap: true,
                                      physics: ScrollPhysics(),
                                      itemCount: itemdata!.length,
                                      itemBuilder: (context, index) {
                                        return HomeItem(
                                          // data: _itemdata[index],
                                          data: ItemData.fromJson(
                                              itemdata![index]),
                                          index: index,
                                        );
                                      },
                                    ),
                              // StreamBuilder<List>(
                              //   stream: homedata.getDataStream(),
                              //   builder: (context, snapshot) {
                              //     var data = snapshot.data;
                              //     // print(data);
                              //     if (snapshot.hasData == true) {
                              //       return ListView.builder(
                              //         controller: scrollController,
                              //         shrinkWrap: true,
                              //         physics: ScrollPhysics(),
                              //         itemCount: (data == null) ? 0 : data.length,
                              //         itemBuilder: (context, index) {
                              //           return HomeItem(
                              //             data: data,
                              //             index: index,
                              //           );
                              //         },
                              //       );
                              //     } else {
                              //       return Center(
                              //         child: SizedBox(
                              //           height: 30,
                              //           width: 30,
                              //           child: CircularProgressIndicator(),
                              //         ),
                              //       );
                              //     }
                              //   },
                              // ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 10,
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        (widget.userData!.level == "admin")
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
                                    Get.offAll(
                                      () => AdminPage(),
                                      transition:
                                          transition.Transition.leftToRight,
                                    );
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
                          child: HomePopupMenu(box: widget.box),
                        )
                      ],
                    ),
                  ),
                  Positioned(
                    bottom: 20,
                    right: 20,
                    child: InkWell(
                      onTap: () {
                        Get.to(() => AddPage());
                      },
                      child: Container(
                        height: 60,
                        width: 60,
                        padding: EdgeInsets.all(0),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
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
                        child: Icon(
                          Icons.add,
                          color: Colors.white,
                          size: 30,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        }
      },
    );
  }
}
