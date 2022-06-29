import 'package:flutter/material.dart';

class CustomScrollBehavior extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    // 禁用安卓风格滑动辉光效果
    return child;
  }

  static const ScrollPhysics _clampingPhysics =
      ClampingScrollPhysics(parent: RangeMaintainingScrollPhysics());

  @override
  ScrollPhysics getScrollPhysics(BuildContext context) {
    // 在某些控件使用BouncingScrollPhysics视觉效果有问题，默认安卓风格，有需要去单独修改
    return _clampingPhysics;
  }
}
