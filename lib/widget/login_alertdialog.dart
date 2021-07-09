import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginAlertDialog extends StatelessWidget {
  const LoginAlertDialog({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Username / Password Salah"),
      content: Text("Silakan coba login kembali"),
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
