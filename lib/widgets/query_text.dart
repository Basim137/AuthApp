import 'package:flutter/material.dart';

class QueryText extends StatelessWidget {
  final String quetionText;
  final double textFontSize;
  final String ansText;
  final Function()? onTap;
  const QueryText({
    this.textFontSize = 16,
    this.onTap,
    super.key,
    required this.ansText,
    required this.quetionText,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,

      children: [
        GestureDetector(
          onTap: onTap,
          child: Text(
            ansText,
            style: TextStyle(
              decorationThickness: 1,
              decorationColor: const Color.fromARGB(255, 44, 120, 101),
              decorationStyle: TextDecorationStyle.solid,
              decoration: TextDecoration.underline,
              fontSize: textFontSize,
              fontWeight: FontWeight.w500,
              color: const Color.fromARGB(255, 44, 120, 101),
            ),
          ),
        ),
        Text(
          quetionText,
          style: TextStyle(fontSize: textFontSize, fontWeight: FontWeight.w500),
        ),
      ],
    );
  }
}
