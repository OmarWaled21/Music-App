import 'package:client/core/theme/app_pallete.dart';
import 'package:flutter/material.dart';

class AuthTextField extends StatefulWidget {
  final String hintText;
  final bool isSecured;
  final TextEditingController controller;

  const AuthTextField({
    super.key,
    required this.hintText,
    this.isSecured = false,
    required this.controller,
  });

  @override
  State<AuthTextField> createState() => _AuthTextFieldState();
}

class _AuthTextFieldState extends State<AuthTextField> {
  late bool _isSecured;

  @override
  void initState() {
    super.initState();
    _isSecured = widget.isSecured;
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (value) {
        if (value == null || value.isEmpty) {
          return '${widget.hintText} is required';
        }
        return null;
      },
      controller: widget.controller,
      obscureText: _isSecured,
      cursorColor: AppPallete.gradient1,
      decoration: InputDecoration(
        hintText: widget.hintText,
        hintStyle: TextStyle(
          color: AppPallete.gradient1.withAlpha(100),
        ),
        suffixIcon: widget.isSecured
            ? IconButton(
                onPressed: () {
                  setState(() {
                    _isSecured = !_isSecured;
                  });
                },
                icon: Icon(
                  _isSecured ? Icons.visibility_off : Icons.visibility,
                ),
              )
            : null,
      ),
    );
  }
}
