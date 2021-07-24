import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginAlertDialog extends StatelessWidget {
   final String title;
   final String content;

   LoginAlertDialog({
   required this.title,
   required this.content,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Text(content),
      actions: [
        TextButton(
          onPressed: () {
            Get.back();
          },
          child: Text("OK"),
        ),
      ],
    );
  }
}
