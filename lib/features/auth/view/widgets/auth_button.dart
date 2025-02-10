import 'package:client/core/extentions/media_query_extention.dart';
import 'package:client/core/theme/app_pallete.dart';
import 'package:flutter/material.dart';

class AuthButton extends StatelessWidget {
  final VoidCallback onTap;
  final String title;

  const AuthButton({super.key, required this.onTap, required this.title});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        width: context.screenWidth,
        height: context.screenHeight * 0.06,
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [AppPallete.gradient1, AppPallete.gradient2],
            begin: Alignment.bottomLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(
          title,
          style: TextStyle(
            color: AppPallete.backgroundColor,
            fontWeight: FontWeight.bold,
            fontSize: context.devicePixelRatio * 6,
          ),
        ),
      ),
    );
  }
}
