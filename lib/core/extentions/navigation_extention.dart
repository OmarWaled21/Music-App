import 'package:flutter/material.dart';

extension NavigationExtention on BuildContext {
  void pop() => Navigator.pop(this);
  void push(Widget route) =>
      Navigator.push(this, MaterialPageRoute(builder: (context) => route));

  void pushReplacement(Widget route) => Navigator.pushReplacement(
      this, MaterialPageRoute(builder: (context) => route));

  void pushRemoveUntil(Widget route) => Navigator.pushAndRemoveUntil(
      this, MaterialPageRoute(builder: (context) => route), (route) => false);
}
