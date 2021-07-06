import 'package:flutter/material.dart';
import 'package:flutter_crud_mysql_1/services/connect.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Connect connect = Connect();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Home Page",
          style: TextStyle(
            fontFamily: "SF Compact",
            fontSize: 22,
          ),
        ),
        backgroundColor: Colors.cyan,
        centerTitle: true,
        elevation: 0,
      ),
      body: FutureBuilder<List>(
        future: connect.getData(),
        // future: connect.getData(),
        builder: (context, snapshot) {
          var data = snapshot.data;
          if (snapshot.hasData == true) {
            return ListView.builder(
              itemCount: (data == null) ? 0 : data.length,
              itemBuilder: (context, index) {
                return Container(
                  margin: EdgeInsets.symmetric(vertical:10),
                  height: 40,
                  decoration: BoxDecoration(
                    border: Border.all(),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(data![index]['item_name']),
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
    );
  }
}
