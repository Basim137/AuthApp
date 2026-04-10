import 'package:flutter/material.dart';

class CustomField extends StatefulWidget {
  final bool obscureText;
  final TextEditingController? control;
  final Function(String)? onSubmmited;
  const CustomField({
    super.key,
    this.obscureText = false,
    this.onSubmmited,
    this.control,
  });

  @override
  State<CustomField> createState() => _CustomFieldState();
}

class _CustomFieldState extends State<CustomField> {
  bool obsecureTextState = true;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: Stack(
        children: [
          TextField(
            controller: widget.control,
            obscureText: widget.obscureText ? obsecureTextState : false,
            textDirection: TextDirection.rtl,
            onSubmitted: widget.onSubmmited,
            decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(9),
                borderSide: BorderSide(
                  width: 0.9,
                  color: const Color.fromARGB(255, 198, 198, 198),
                ),
              ),
              fillColor: const Color.fromARGB(27, 96, 125, 139),
              filled: true,
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(9),
                borderSide: BorderSide(
                  width: 0.9,
                  color: const Color.fromARGB(255, 198, 198, 198),
                ),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(9),
              ),
            ),
          ),
          Positioned(
            top: 3,
            left: 6,
            child: widget.obscureText
                ? IconButton(
                    onPressed: () {
                      setState(() {
                        obsecureTextState = !obsecureTextState;
                      });
                    },
                    icon: Icon(
                      obsecureTextState
                          ? Icons.visibility_off_outlined
                          : Icons.visibility_outlined,
                      size: 26,
                      color: const Color.fromARGB(255, 41, 92, 71),
                    ),
                  )
                : SizedBox(),
          ),
        ],
      ),
    );
  }
}
