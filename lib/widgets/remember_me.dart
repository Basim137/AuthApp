import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:prac_27/core/api/constants.dart';

class RememberMe extends StatefulWidget {
  const RememberMe({super.key});

  @override
  State<RememberMe> createState() => _RememberMeState();
}

class _RememberMeState extends State<RememberMe> {
  bool boxState = false;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          onTap: () {},
          child: Text(
            'هل نسيت كلمة المرور؟',
            style: TextStyle(
              decorationThickness: 1,
              decorationColor: const Color.fromARGB(255, 44, 120, 101),
              decorationStyle: TextDecorationStyle.solid,
              decoration: TextDecoration.underline,
              fontSize: 15,
              fontWeight: FontWeight.w500,
              color: const Color.fromARGB(255, 44, 120, 101),
            ),
          ),
        ),
        Spacer(),
        Text('تذكرني'),
        Checkbox(
          visualDensity: VisualDensity.compact,
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          activeColor: const Color.fromARGB(255, 44, 120, 101),
          value: boxState,
          onChanged: (state) async {
            boxState = state!;
            final box = Hive.box(AppKeys.infoHive);
            if (boxState) {
              await box.put(AppKeys.islogined, true);
            } else {
              await box.put(AppKeys.islogined, false);
            }
            setState(() {});
          },
        ),
      ],
    );
  }
}
