import 'package:flutter/material.dart';

class CommonSnackBar {
  static Future<void> showSnackBar(BuildContext context, String text) async {
    Scaffold.of(context).showSnackBar(SnackBar(
      behavior: SnackBarBehavior.floating,
      content: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          text,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.normal),
        ),
      ),
    ));
  }
}
