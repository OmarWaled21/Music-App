import 'package:client/core/extentions/media_query_extention.dart';
import 'package:client/core/extentions/navigation_extention.dart';
import 'package:client/features/auth/repositories/auth_remote_repository.dart';
import 'package:client/features/auth/view/widgets/auth_button.dart';
import 'package:client/features/auth/view/widgets/auth_check_signing.dart';
import 'package:client/features/auth/view/widgets/auth_text_field.dart';
import 'package:flutter/material.dart';
import 'package:fpdart/fpdart.dart' as fp;

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final GlobalKey<FormState> _key = GlobalKey<FormState>();

  @override
  void dispose() {
    super.dispose();
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        forceMaterialTransparency: true,
        leading: IconButton(
          onPressed: () => context.pop(),
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
        ),
      ),
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
                    'Sign Up.',
                    style: TextStyle(
                      fontSize: context.devicePixelRatio * 13,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: context.screenHeight * 0.001),
                  AuthTextField(
                    hintText: 'Name',
                    controller: _nameController,
                  ),
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
                    onTap: () async {
                      if (_key.currentState!.validate()) {
                        final res = await AuthRemoteRepository().signup(
                          name: _nameController.text.trim(),
                          email: _emailController.text.trim(),
                          password: _passwordController.text.trim(),
                        );

                        final val = switch (res) {
                          fp.Left(value: final l) => l,
                          fp.Right(value: final r) => r.name,
                        };
                        print(val);
                      }
                    },
                    title: 'Sign up',
                  ),
                  const AuthCheckSigning(isSigningUp: true)
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
