import 'package:flutter/material.dart';
import 'package:flutter_crud_mysql_1/model/itemdata.dart';
import 'package:flutter_crud_mysql_1/screens/addpage.dart';
import 'package:get/get.dart';

class HomeItem extends StatefulWidget {
  final ItemData? data;
  // final List? data;
  final int index;

  HomeItem({
    required this.index,
    required this.data,
  });

  @override
  _HomeItemState createState() => _HomeItemState();
}

class _HomeItemState extends State<HomeItem> {
  String type = "edit";
  @override
  Widget build(BuildContext context) {
    int index = widget.index;
    ItemData? data = widget.data;
    return InkWell(
      onTap: () {
        Get.to(
          () => AddPage(
            data: data,
            index: index,
            type: type,
          ),
        );
      },
      child: ConstrainedBox(
        constraints: BoxConstraints.loose(Size(double.infinity, 500)),
        child: Container(
          margin: EdgeInsets.symmetric(vertical: 10),
          height: 100,
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.black26),
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                offset: Offset(0, 3),
                blurRadius: 0.5,
                spreadRadius: 0.5,
                color: Colors.black38,
              )
            ],
          ),
          child: Container(
            margin: EdgeInsets.symmetric(
              horizontal: 10,
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  Icons.apps,
                  size: 40,
                  color: Colors.grey,
                ),
                SizedBox(
                  width: 10,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * 0.75,
                      child: Text(
                        // widget.data![index]['item_name'],
                        widget.data!.itemName.toString(),

                        style: TextStyle(
                          fontFamily: "SF Text",
                          fontSize: 18,
                        ),
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      // "Stocks: ${widget.data![index]['stock']}",
                      "Stocks: ${widget.data!.stock}",
                      style: TextStyle(
                        fontFamily: "SF Text",
                        fontSize: 14,
                      ),
                    ),
                    SizedBox(height: 15),
                    Text(
                      // "Price: Rp ${widget.data![index]['price']}",
                      "Price: Rp ${widget.data!.price}",
                      style: TextStyle(
                        fontFamily: "SF Text",
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
