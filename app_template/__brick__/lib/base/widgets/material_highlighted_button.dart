import 'package:flutter/material.dart';

class MaterialHighlightedButton extends StatelessWidget {
  const MaterialHighlightedButton({
    Key? key,
    required this.child,
    this.color,
    this.splashColor,
    required this.onPressed,
  }) : super(key: key);

  final Widget child;
  final Color? color;
  final Color? splashColor;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: color ?? Colors.transparent,
      child: InkWell(
        splashColor: splashColor,
        onTap: onPressed,
        child: child,
      ),
    );
  }
}
