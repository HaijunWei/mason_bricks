import 'package:flutter/material.dart';

class DismissKeyboardGesture extends StatelessWidget {
  const DismissKeyboardGesture({
    Key? key,
    required this.child,
  }) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      behavior: HitTestBehavior.opaque,
      child: child,
    );
  }
}
