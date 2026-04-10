import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      child: Row(
        children: [
          const SizedBox(width: 20),
          GestureDetector(
            onTap: () {},
            child: Container(
              padding: EdgeInsets.all(6),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(1000),
                color: const Color.fromARGB(40, 255, 255, 255),
              ),
              child: Icon(
                Icons.notifications_outlined,
                color: Colors.white,
                size: 25,
              ),
            ),
          ),
          const Spacer(),
          Text(
            'الملف الشخصي',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          const Spacer(),
          const SizedBox(width: 40),
        ],
      ),
    );
  }
}
