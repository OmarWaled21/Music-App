import 'package:client/core/extentions/media_query_extention.dart';
import 'package:client/features/auth/view/widgets/auth_button.dart';
import 'package:client/features/auth/view/widgets/auth_check_signing.dart';
import 'package:client/features/auth/view/widgets/auth_text_field.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final GlobalKey<FormState> _key = GlobalKey<FormState>();

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(forceMaterialTransparency: true),
      body: Stack(
        clipBehavior: Clip.antiAlias,
        children: [
          Positioned(
            bottom: -120,
            left: -60,
            child: Image.asset(
              'assets/image.png',
              width: context.screenWidth,
              opacity: const AlwaysStoppedAnimation(.2),
            ),
          ),
          Padding(
            padding:
                EdgeInsets.symmetric(horizontal: context.screenWidth * 0.04),
            child: Form(
              key: _key,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                spacing: context.screenHeight * 0.02,
                children: [
                  Text(
                    'Login.',
                    style: TextStyle(
                      fontSize: context.devicePixelRatio * 13,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: context.screenHeight * 0.001),
                  AuthTextField(
                    hintText: 'Email',
                    controller: _emailController,
                  ),
                  AuthTextField(
                    hintText: 'Password',
                    controller: _passwordController,
                    isSecured: true,
                  ),
                  SizedBox(height: context.screenHeight * 0.01),
                  AuthButton(
                    onTap: () {
                      if (_key.currentState!.validate()) {}
                    },
                    title: 'Login',
                  ),
                  const AuthCheckSigning(isSigningUp: false)
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
