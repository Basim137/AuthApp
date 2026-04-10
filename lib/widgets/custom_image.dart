import 'dart:io';

import 'package:flutter/material.dart';

class CustomImage extends StatefulWidget {
  final ValueNotifier<String> value;

  final Function()? onTap;
  const CustomImage({super.key, this.onTap, required this.value});

  @override
  State<CustomImage> createState() => _CustomImageState();
}

class _CustomImageState extends State<CustomImage> {
  late VoidCallback listener;
  @override
  void initState() {
    listener = () {
      if (!mounted) return;
      setState(() {});
    };
    widget.value.addListener(listener);

    super.initState();
  }

  @override
  void dispose() {
    widget.value.removeListener(listener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: GestureDetector(
        onTap: widget.onTap,
        child: Container(
          alignment: Alignment(0, 0),
          height: 82,
          width: 170,
          decoration: BoxDecoration(
            image: (widget.value.value.isNotEmpty)
                ? DecorationImage(
                    fit: BoxFit.cover,
                    image: FileImage(File(widget.value.value)),
                  )
                : null,
            gradient: LinearGradient(
              colors: [
                const Color.fromARGB(255, 20, 179, 165),
                const Color.fromARGB(255, 8, 75, 70),
              ],
            ),
            borderRadius: BorderRadius.circular(4),
          ),

          child: (widget.value.value.isEmpty)
              ? SizedBox(
                  height: 20,
                  width: 20,
                  child: CircularProgressIndicator(
                    strokeWidth: 3,
                    color: Colors.white,
                  ),
                )
              : null,
        ),
      ),
    );
  }
}
