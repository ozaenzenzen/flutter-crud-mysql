import 'package:flutter/material.dart';
import 'package:flutter_crud_mysql_1/model/data.dart' as data;
import 'package:flutter_crud_mysql_1/screens/addpage.dart';
import 'package:flutter_crud_mysql_1/screens/loginpage.dart';
import 'package:flutter_crud_mysql_1/services/connect.dart';
import 'package:flutter_crud_mysql_1/widget/home_item.dart';
import 'package:flutter_crud_mysql_1/widget/home_popup_menu.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ScrollController scrollController = ScrollController();
  Connect connect = Connect();
  final box = GetStorage();
  // Data data = Data();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Home Page",
          style: TextStyle(
            fontFamily: "SF UI",
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.cyan,
        centerTitle: true,
        elevation: 0,
        actions: [
          Container(
            padding: EdgeInsets.all(0),
            child: HomePopupMenu(box: box),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.symmetric(
            vertical: 10,
            horizontal: 10,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              // StreamBuilder<Data>(
              StreamBuilder<List>(
                stream: connect.getDataStream(),
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
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(() => AddPage());
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
