import 'package:client/core/theme/app_pallete.dart';
import 'package:flutter/material.dart';

void showSnackBar({
  required BuildContext context,
  required String message,
  required IconData icon,
  required Color color,
}) {
  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(
      SnackBar(
        backgroundColor: color,
        content: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CircleAvatar(
              backgroundColor: AppPallete.backgroundColor,
              child: Icon(icon),
            ),
            Text(
              message,
              style: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(),
          ],
        ),
      ),
    );
}
