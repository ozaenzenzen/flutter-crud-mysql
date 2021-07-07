import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_crud_mysql_1/services/connect.dart';
import 'package:get/get.dart';

class AddPage extends StatefulWidget {
  @override
  _AddPageState createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  Connect connect = Connect();
  TextEditingController codeController = new TextEditingController();
  TextEditingController nameController = new TextEditingController();
  TextEditingController priceController = new TextEditingController();
  TextEditingController stockController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.cyan,
        centerTitle: true,
        title: Text(
          "Add Data",
          style: TextStyle(
            fontFamily: "SF UI",
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Container(
        margin: EdgeInsets.symmetric(
          horizontal: 15,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            TextField(
              controller: codeController,
              decoration: InputDecoration(
                labelText: "Item Code",
                labelStyle: TextStyle(
                  fontFamily: "SF Text",
                  fontSize: 14,
                ),
              ),
            ),
            TextField(
              controller: nameController,
              decoration: InputDecoration(
                labelText: "Item Name",
                labelStyle: TextStyle(
                  fontFamily: "SF Text",
                  fontSize: 14,
                ),
              ),
            ),
            TextField(
              controller: priceController,
              decoration: InputDecoration(
                labelText: "Price",
                labelStyle: TextStyle(
                  fontFamily: "SF Text",
                  fontSize: 14,
                ),
              ),
            ),
            TextField(
              controller: stockController,
              decoration: InputDecoration(
                labelText: "Stock",
                labelStyle: TextStyle(
                  fontFamily: "SF Text",
                  fontSize: 14,
                ),
              ),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  connect.addData(
                    codeController.text,
                    nameController.text,
                    priceController.text,
                    stockController.text,
                  );
                  Get.back();
                });
              },
              child: Text("Add Data"),
            ),
          ],
        ),
      ),
    );
  }
}
