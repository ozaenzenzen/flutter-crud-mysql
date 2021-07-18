import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_crud_mysql_1/services/homedata_services.dart';
import 'package:get/get.dart';

class AddPage extends StatefulWidget {
  final data;
  final type;
  final index;

  AddPage({
    this.data,
    this.type,
    this.index,
  });

  @override
  _AddPageState createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  var data;
  String? type;
  int? index;

  Homedata homedata = Homedata();
  TextEditingController codeController = new TextEditingController();
  TextEditingController nameController = new TextEditingController();
  TextEditingController priceController = new TextEditingController();
  TextEditingController stockController = new TextEditingController();

  @override
  void initState() {
    data = widget.data;
    type = widget.type;
    index = widget.index;

    if (type == "edit") {
      codeController.text = data[index]['item_code'];
      nameController.text = data[index]['item_name'];
      priceController.text = data[index]['price'];
      stockController.text = data[index]['stock'];
    } else {
      //
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.cyan,
        centerTitle: true,
        title: Text(
          (type == "edit") ? "Edit Data" : "Add Data",
          style: TextStyle(
            fontFamily: "SF UI",
            fontSize: 22,
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
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                (type == "edit")
                    ? ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Colors.red,
                        ),
                        onPressed: () {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: Text("Delete Data"),
                                  content:
                                      Text("Data will be lost. Are you sure?"),
                                  actions: [
                                    ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        primary: Colors.red,
                                      ),
                                      child: Text("Delete"),
                                      onPressed: () {
                                        Get.back();
                                        setState(() {
                                          homedata.deleteData(data[index]['id']);
                                        });
                                        Get.back();
                                      },
                                    ),
                                    TextButton(
                                      child: Text("Cancel"),
                                      onPressed: () {
                                        Get.back();
                                      },
                                    ),
                                  ],
                                );
                              });
                        },
                        child: Text("Delete"),
                      )
                    : Container(),
                SizedBox(
                  width: 10,
                ),
                ElevatedButton(
                  onPressed: () {
                    FocusScope.of(context).unfocus();
                    if (type == "edit") {
                      setState(() {
                        homedata.editData(
                          data[index]['id'],
                          codeController.text,
                          nameController.text,
                          priceController.text,
                          stockController.text,
                        );
                        Get.back();
                      });
                    } else {
                      setState(() {
                        homedata.addData(
                          codeController.text,
                          nameController.text,
                          priceController.text,
                          stockController.text,
                        );
                        Get.back();
                      });
                    }
                  },
                  child: Text((type == "edit") ? "Update Now" : "Add Data"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
