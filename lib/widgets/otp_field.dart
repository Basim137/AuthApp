import 'package:flutter/material.dart';

class OtpField extends StatelessWidget {
  final Function(String)? onSubmmited;
  final Function(String)? onChanged;
  final TextEditingController? control;
  const OtpField({super.key, this.onSubmmited, this.onChanged, this.control});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 55,
      child: TextField(
        controller: control,
        onChanged: onChanged,
        onSubmitted: onSubmmited,
        maxLength: 1,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          counter: SizedBox(),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: Colors.blueGrey),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: Colors.blueGrey),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: Colors.blueGrey),
          ),
        ),
      ),
    );
  }
}
