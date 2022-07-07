import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppColors extends ThemeExtension<AppColors> {
  const AppColors({
    required this.primary,
    required this.secondary,
    required this.text1,
    required this.text2,
    required this.text3,
    required this.textPlaceholder,
    required this.divider1,
    required this.divider2,
    required this.comFFF,
    required this.background,
    required this.backgroundGrey,
  });

  /// 主题色
  final Color primary;

  /// 次主题色
  final Color secondary;

  /// 文字颜色，默认
  final Color text1;

  /// 文字颜色
  final Color text2;

  /// 文字颜色
  final Color text3;

  /// 占位文字颜色
  final Color textPlaceholder;

  /// 分割线颜色
  final Color divider1;

  /// 分割线颜色
  final Color divider2;

  /// 白色，可能在以主题色为背景的时候用到
  final Color comFFF;

  /// 背景色，通常为白色
  final Color background;

  /// 背景色，通常为浅灰色
  final Color backgroundGrey;

  @override
  ThemeExtension<AppColors> copyWith({
    Color? primary,
    Color? secondary,
    Color? text1,
    Color? text2,
    Color? text3,
    Color? text4,
    Color? textPlaceholder,
    Color? textFieldFill,
    Color? divider1,
    Color? divider2,
    Color? comFFF,
    Color? background,
    Color? backgroundGrey,
  }) {
    return AppColors(
      primary: primary ?? this.primary,
      secondary: primary ?? this.secondary,
      text1: text1 ?? this.text1,
      text2: text2 ?? this.text2,
      text3: text3 ?? this.text3,
      textPlaceholder: textPlaceholder ?? this.textPlaceholder,
      divider1: divider1 ?? this.divider1,
      divider2: divider2 ?? this.divider2,
      comFFF: comFFF ?? this.comFFF,
      background: background ?? this.background,
      backgroundGrey: backgroundGrey ?? this.backgroundGrey,
    );
  }

  @override
  ThemeExtension<AppColors> lerp(ThemeExtension<AppColors>? other, double t) {
    if (other is! AppColors) {
      return this;
    }

    return AppColors(
      primary: Color.lerp(primary, other.primary, t)!,
      secondary: Color.lerp(primary, other.secondary, t)!,
      text1: Color.lerp(text1, other.text1, t)!,
      text2: Color.lerp(text2, other.text2, t)!,
      text3: Color.lerp(text3, other.text3, t)!,
      textPlaceholder: Color.lerp(textPlaceholder, other.textPlaceholder, t)!,
      divider1: Color.lerp(divider1, other.divider1, t)!,
      divider2: Color.lerp(divider2, other.divider2, t)!,
      comFFF: Color.lerp(comFFF, other.comFFF, t)!,
      background: Color.lerp(background, other.background, t)!,
      backgroundGrey: Color.lerp(backgroundGrey, other.backgroundGrey, t)!,
    );
  }
}

const _appColors = AppColors(
  primary: Color(0xFFEDD47D),
  secondary: Color(0xFF35B589),
  text1: Color(0xFF333333),
  text2: Color(0xFF666666),
  text3: Color(0xFF999999),
  textPlaceholder: Color(0xFFC7C9D1),
  divider1: Color(0xFFE4E4E4),
  divider2: Color(0xFFE4E4E4),
  comFFF: Color(0xFFFFFFFF),
  background: Color(0xFFFFFFFF),
  backgroundGrey: Color(0xFFF9F9FA),
);

final appThemeData = ThemeData.light().copyWith(
  primaryColor: _appColors.primary,
  canvasColor: Colors.transparent,
  scaffoldBackgroundColor: _appColors.background,
  textTheme: TextTheme(
    // TextField
    bodyText2: TextStyle(
      color: _appColors.text1,
      // Flutter 3.X，在苹果机上中文字重渲染有问题，需要指定字体修复
      fontFamilyFallback: Platform.isIOS ? const ['PingFang SC'] : null,
    ),
    // 大部分地方的文字颜色
    subtitle1: TextStyle(
      color: _appColors.text1,
      // Flutter 3.X，在苹果机上中文字重渲染有问题，需要指定字体修复
      fontFamilyFallback: Platform.isIOS ? const ['PingFang SC'] : null,
    ),
  ),
  cupertinoOverrideTheme: NoDefaultCupertinoThemeData(
    primaryColor: _appColors.primary,
    textTheme: CupertinoTextThemeData(
      textStyle: TextStyle(
        color: _appColors.text1,
        // Flutter 3.X，在苹果机上中文字重渲染有问题，需要指定字体修复
        fontFamilyFallback: Platform.isIOS ? const ['PingFang SC'] : null,
      ),
      navTitleTextStyle: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
        color: _appColors.text1,
      ),
    ),
  ),
  appBarTheme: AppBarTheme(
    backgroundColor: _appColors.comFFF,
    iconTheme: IconThemeData(color: _appColors.text1),
    titleTextStyle: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.bold,
      color: _appColors.text1,
    ),
    centerTitle: true,
    elevation: 0,
    systemOverlayStyle: kSystemUiOverlayStyle,
  ),
  dividerColor: _appColors.divider1,
  highlightColor: Colors.black.withOpacity(0.05),
  extensions: const [_appColors],
);

/// 默认动画时长
const kDefaultAnimationDuration = Duration(milliseconds: 200);

/// 默认边距
const kDefaultPaddingLR = 16.0;

/// 默认圆角大小
const kDefaultRadius = 4.0;

/// 状态栏黑色文字
const kSystemUiOverlayStyle = SystemUiOverlayStyle(
  statusBarColor: Colors.transparent,
  statusBarBrightness: Brightness.light,
  statusBarIconBrightness: Brightness.dark,
  systemNavigationBarColor: Colors.white,
  systemNavigationBarDividerColor: Colors.white,
);

/// 状态栏白色文字
const kSystemUiOverlayStyleDark = SystemUiOverlayStyle(
  statusBarColor: Colors.transparent,
  statusBarBrightness: Brightness.dark,
  statusBarIconBrightness: Brightness.light,
  systemNavigationBarColor: Colors.white,
  systemNavigationBarDividerColor: Colors.white,
);

extension AppTheme on BuildContext {
  AppColors get appColors => Theme.of(this).extension<AppColors>()!;
}

/// 从底部往上弹动画
Widget bottomSlideAnimation(
  BuildContext context,
  Animation<double> animation,
  Widget child,
) {
  final slideAnimation =
      Tween<Offset>(begin: const Offset(0, 1), end: const Offset(0, 0))
          .chain(CurveTween(curve: Curves.easeOut))
          .animate(animation);
  return Align(
    alignment: Alignment.bottomCenter,
    child: SlideTransition(
      position: slideAnimation,
      child: child,
    ),
  );
}

/// pop弹出动画
Widget popFadeAnimation(
  BuildContext context,
  Animation<double> animation,
  Widget child,
) {
  Animation<double> curve = CurvedAnimation(
    parent: animation,
    curve: Curves.slowMiddle,
  );
  final fadeAnimation = Tween<double>(begin: 0, end: 1).animate(curve);
  final scaleAnimation = Tween<double>(begin: 1.1, end: 1).animate(curve);
  return FadeTransition(
    opacity: fadeAnimation,
    child: ScaleTransition(
      scale: scaleAnimation,
      child: child,
    ),
  );
}
