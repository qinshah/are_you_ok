import 'package:flutter/material.dart';

extension Nav on BuildContext {
  void push(Widget page) {
    Navigator.push(this, MaterialPageRoute(builder: (context) => page));
  }

  void pushReplacement(Widget page) {
    Navigator.pushReplacement(
        this, MaterialPageRoute(builder: (context) => page));
  }

  void pop() {
    Navigator.pop(this);
  }

  void popUntil(Widget page) {}
}
