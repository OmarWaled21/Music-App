import 'package:client/core/extentions/navigation_extention.dart';
import 'package:client/core/theme/app_pallete.dart';
import 'package:client/features/auth/view/pages/signup_page.dart';
import 'package:flutter/material.dart';

class AuthCheckSigning extends StatelessWidget {
  final bool isSigningUp;
  const AuthCheckSigning({super.key, required this.isSigningUp});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(isSigningUp
            ? 'Already have an account? '
            : 'Don\'t have an account? '),
        GestureDetector(
          onTap: () {
            isSigningUp ? null : context.push(const SignUpPage());
          },
          child: Text(
            isSigningUp ? 'Login' : 'Sign up',
            style: const TextStyle(
              color: AppPallete.gradient1,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
