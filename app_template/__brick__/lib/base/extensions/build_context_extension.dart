import 'package:flutter/material.dart';

extension BuildContextExtension on BuildContext {
  void dismissKeyboard() {
    FocusScope.of(this).requestFocus(FocusNode());
  }
}
