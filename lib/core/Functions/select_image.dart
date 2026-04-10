import 'package:flutter/material.dart';

selectFromGalleryOrCamera(
  BuildContext context, {
  Function()? camera,
  Function()? gallery,
}) {
  showModalBottomSheet(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    context: context,
    builder: (context) {
      return Padding(
        padding: EdgeInsetsGeometry.symmetric(vertical: 22),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(flex: 3),
            IconButton(
              onPressed: gallery,
              icon: Icon(
                Icons.image,
                size: 60,
                color: const Color.fromARGB(255, 20, 179, 165),
              ),
            ),
            const Spacer(),
            IconButton(
              onPressed: camera,
              icon: Icon(
                Icons.camera_alt_rounded,
                size: 60,
                color: const Color.fromARGB(255, 20, 179, 165),
              ),
            ),
            const Spacer(flex: 3),
          ],
        ),
      );
    },
  );
}
