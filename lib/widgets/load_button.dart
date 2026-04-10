import 'package:flutter/material.dart';

class LoadindButton extends StatelessWidget {
  final bool isLoading;
  final String? text;
  final Function()? onTap;
  const LoadindButton({
    super.key,
    this.text,
    this.onTap,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return AbsorbPointer(
      absorbing: isLoading ? true : false,
      child: GestureDetector(
        onTap: onTap,

        child: Container(
          margin: EdgeInsets.symmetric(vertical: 5),
          alignment: Alignment(0, 0),
          width: double.infinity,
          padding: EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            gradient: LinearGradient(
              colors: [
                const Color.fromARGB(255, 20, 179, 165),
                const Color.fromARGB(255, 8, 75, 70),
              ],
            ),
          ),
          child: isLoading
              ? SizedBox(
                  height: 20,
                  width: 20,
                  child: CircularProgressIndicator(
                    strokeWidth: 3,
                    color: Colors.white,
                  ),
                )
              : Text(
                  text ?? '',
                  style: TextStyle(
                    fontSize: 17,
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
        ),
      ),
    );
  }
}
