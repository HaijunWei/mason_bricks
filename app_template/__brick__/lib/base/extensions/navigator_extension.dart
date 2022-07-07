import 'package:flutter/cupertino.dart';

extension NavigatorExtension on BuildContext {
  Future<T?> pushPage<T>(Widget widget, {bool fullscreenDialog = false}) {
    return Navigator.push<T>(
      this,
      CupertinoPageRoute<T>(
        builder: (context) => widget,
        fullscreenDialog: fullscreenDialog,
      ),
    );
  }
}
