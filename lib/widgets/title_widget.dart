import 'package:flutter/material.dart';

class TitledWidget extends StatelessWidget {
  final String title;
  final Widget widget;
  const TitledWidget({super.key, required this.title, required this.widget});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,

      children: [
        const SizedBox(height: 6),
        Text(
          title,
          style: TextStyle(fontSize: 14.5, fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 6),
        widget,
      ],
    );
  }
}
