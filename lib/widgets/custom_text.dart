import 'package:flutter/material.dart';

class CustomButtonTExt extends StatelessWidget {
  final String text;
  final Function()? onTap;

  const CustomButtonTExt({super.key, required this.text, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Text(
        text,
        style: TextStyle(
          decorationThickness: 1,
          decorationColor: Colors.red,
          decorationStyle: TextDecorationStyle.solid,
          decoration: TextDecoration.underline,
          fontSize: 16,
          fontWeight: FontWeight.w700,
          color: Colors.red,
        ),
      ),
    );
  }
}
