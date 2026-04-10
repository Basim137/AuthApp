import 'package:flutter/material.dart';

scaffoldMessage(BuildContext context, {required String message}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      padding: EdgeInsets.all(6),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadiusGeometry.circular(8),
      ),

      backgroundColor: const Color.fromARGB(255, 16, 138, 128),
      content: Container(
        width: double.infinity,
        alignment: Alignment.topLeft,

        height: 30,
        child: Text(
          message,
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w300),
        ),
      ),
    ),
  );
}
