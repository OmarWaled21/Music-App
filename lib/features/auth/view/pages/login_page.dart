import 'package:client/core/extentions/media_query_extention.dart';
import 'package:client/core/extentions/navigation_extention.dart';
import 'package:client/core/theme/app_pallete.dart';
import 'package:client/core/widgets/loader.dart';
import 'package:client/core/widgets/snackbar.dart';
import 'package:client/features/auth/view/widgets/auth_button.dart';
import 'package:client/features/auth/view/widgets/auth_check_signing.dart';
import 'package:client/features/auth/view/widgets/auth_text_field.dart';
import 'package:client/features/auth/viewmodel/auth_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
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
    final isLoading = ref.watch(authViewModelProvider)?.isLoading == true;

    ref.listen(
      authViewModelProvider,
      (_, next) {
        next?.when(
          data: (data) {
            // context.push(const SignUpPage());
            showSnackBar(
              context: context,
              message: 'Account created successfully!',
              icon: Icons.done,
              color: AppPallete.gradient1,
            );
<<<<<<< HEAD
            print(data);
=======
>>>>>>> 321d42b602c469ffb4c06aac4beb0e6cfce045ab
          },
          error: (error, stackTrace) {
            showSnackBar(
              context: context,
              message: error.toString(),
              icon: Icons.error,
              color: AppPallete.errorColor,
            );
          },
          loading: () {},
        );
      },
    );

    return Scaffold(
      appBar: AppBar(forceMaterialTransparency: true),
      body: isLoading
          ? const Loader()
          : Stack(
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
                  padding: EdgeInsets.symmetric(
                      horizontal: context.screenWidth * 0.04),
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
                          onTap: () async {
                            if (_key.currentState!.validate()) {
                              await ref
                                  .read(authViewModelProvider.notifier)
                                  .loginUser(
                                    email: _emailController.text.trim(),
                                    password: _passwordController.text.trim(),
                                  );
                            }
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
