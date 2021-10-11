import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_crud_mysql_1/cubit/adddata/cubit/add_data_cubit.dart';
import 'package:flutter_crud_mysql_1/cubit/homedata/homedata_cubit.dart';
import 'package:flutter_crud_mysql_1/model/itemdata.dart';
// import 'package:flutter_crud_mysql_1/screens/main_screens/homepage.dart';
import 'package:flutter_crud_mysql_1/screens/main_screens/mainpage.dart';
import 'package:flutter_crud_mysql_1/services/adddata_services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:get/get_navigation/src/routes/transitions_type.dart'
    as transition;

import 'dart:ui';

class AddPage extends StatefulWidget {
  final ItemData? data;
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
  ItemData? data;
  String? type;
  int? index;

  AddDataServices addDataServices = AddDataServices();

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
      codeController.text = data!.itemCode!;
      nameController.text = data!.itemName!;
      priceController.text = data!.price!;
      stockController.text = data!.stock!;
    } else {
      //
    }

    super.initState();
  }

  ScreenUtil screenUtil = ScreenUtil();

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
      body: BlocProvider(
        create: (context) => AddDataCubit(),
        child: BlocConsumer<AddDataCubit, AddDataState>(
          listener: (context, state) {
            if (state is AddDataLoading) {
              Container(
                height: screenUtil.screenHeight,
                child: SizedBox(
                  height: screenUtil.setHeight(30),
                  width: screenUtil.setWidth(30),
                  child: CircularProgressIndicator(),
                ),
              );
            } else if (state is AddDataError) {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: Text(
                      "Error",
                      style: TextStyle(
                        fontFamily: "SF UI",
                        fontSize: screenUtil.setSp(20),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    content: Text(
                      state.errorMessage,
                      style: TextStyle(
                        fontFamily: "SF UI",
                        fontSize: screenUtil.setSp(12),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  );
                },
              );
            } else if (state is AddDataSuccess) {
              Get.back();
            }
          },
          builder: (context, state) {
            if (state is AddDataLoading) {
              return Container(
                height: screenUtil.screenHeight,
                child: SizedBox(
                  height: screenUtil.setHeight(30),
                  width: screenUtil.setWidth(30),
                  child: CircularProgressIndicator(),
                ),
              );
            }
            return Container(
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
                                        content: Text(
                                            "Data will be lost. Are you sure?"),
                                        actions: [
                                          ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                              primary: Colors.red,
                                            ),
                                            child: Text("Delete"),
                                            onPressed: () {
                                              Get.back();
                                              setState(() {
                                                // BlocProvider.of<HomedataCubit>(
                                                //         context)
                                                //     .deleteItemListData(data!);
                                                addDataServices
                                                    .deleteData(data!.id);
                                              });
                                              // Get.back();
                                              Get.offAll(
                                                () => MainPage(),
                                                transition: transition
                                                    .Transition.rightToLeft,
                                              );
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
                          // Get.off(MainPage(), transition: transition.Transition.cupertino);

                          //

                          FocusScope.of(context).unfocus();
                          if (type == "edit") {
                            final postData = ItemData(
                              id: data!.id,
                              itemCode: codeController.text,
                              itemName: nameController.text,
                              price: priceController.text,
                              stock: stockController.text,
                            );

                            print(postData);

                            setState(() {
                              // BlocProvider.of<HomedataCubit>(context, listen: false)
                              //     .editItemListData(postData);

                              //

                              addDataServices.editData(
                                data!.id,
                                codeController.text,
                                nameController.text,
                                priceController.text,
                                stockController.text,
                              );

                              // Get.back();
                              Get.offAll(
                                () => MainPage(),
                                transition: transition.Transition.rightToLeft,
                              );
                            });
                          } else {
                            final postData = ItemData(
                              itemCode: codeController.text,
                              itemName: nameController.text,
                              price: priceController.text,
                              stock: stockController.text,
                            );

                            context.read<AddDataCubit>().addItemListData(postData);

                              // BlocProvider.of<HomedataCubit>(context,listen: false).addItemListData(postData);
                            // setState(() {

                              //

                              // AddDataServices.addData(
                              //   codeController.text,
                              //   nameController.text,
                              //   priceController.text,
                              //   stockController.text,
                              // );
                            // });

                            
                            // Get.back();
                            // Get.offAll(
                            //   () => MainPage(),
                            //   transition: transition.Transition.rightToLeft,
                            // );
                          }
                        },
                        child:
                            Text((type == "edit") ? "Update Now" : "Add Data"),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
