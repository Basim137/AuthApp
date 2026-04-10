import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

class QueryPhoto extends StatelessWidget {
  final Function()? onTap;
  const QueryPhoto({super.key, this.onTap});

  @override
  Widget build(BuildContext context) {
    return DottedBorder(
      options: RoundedRectDottedBorderOptions(
        padding: EdgeInsets.all(3),

        color: const Color.fromARGB(255, 16, 144, 133),
        radius: Radius.circular(8),
        dashPattern: [12, 6],
      ),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 10),
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: const Color.fromARGB(25, 96, 125, 139),
          ),
          child: Column(
            children: [
              Icon(
                Icons.camera_alt_outlined,
                color: const Color.fromARGB(255, 16, 144, 133),
              ),
              Text(
                'JPEG ,PNG : الملفات المسموح بيها',
                style: TextStyle(
                  fontSize: 13,
                  color: const Color.fromARGB(255, 93, 95, 97),
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                '5MB :الحد الاقصي',
                style: TextStyle(
                  color: const Color.fromARGB(255, 93, 95, 97),
                  fontSize: 10,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
