import 'package:{{name}}/support_files/assets.gen.dart';
import 'package:flutter/material.dart';

import '../../generated/l10n.dart';

class DefaultEmptyDataView extends StatelessWidget {
  const DefaultEmptyDataView({
    Key? key,
    required this.child,
    this.showLoading = false,
    this.showEmpty = false,
    this.emptyIcon,
    this.emptyTip,
    this.emptyAttachChild,
    this.onEmptyTap,
    this.backgroundColor,
  }) : super(key: key);

  final Widget child;
  final bool showLoading;
  final bool showEmpty;
  final String? emptyIcon;
  final String? emptyTip;
  final Widget? emptyAttachChild;
  final VoidCallback? onEmptyTap;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    return EmptyDataView(
      showLoading: showLoading,
      loadingBuilder: (_) => const LoadingPlaceholder(),
      showEmpty: showEmpty,
      emptyBuilder: (_) => EmptyDataPlaceholder(
        tip: emptyTip ?? S.of(context).placeholder_noData,
        attachChild: emptyAttachChild,
        icon: Stack(
          children: [
            Image.asset(
              emptyIcon ?? Assets.images.icNoData.path,
              width: 240,
            ),
          ],
        ),
        onTap: onEmptyTap,
      ),
      backgroundColor: backgroundColor,
      child: child,
    );
  }
}

class LoadingEmptyDataView extends StatelessWidget {
  const LoadingEmptyDataView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return EmptyDataView(
      showLoading: true,
      loadingBuilder: (_) => const LoadingPlaceholder(),
      child: const SizedBox(),
    );
  }
}

class EmptyDataView extends StatelessWidget {
  const EmptyDataView({
    Key? key,
    required this.child,
    this.loadingBuilder,
    this.showLoading = false,
    this.emptyBuilder,
    this.showEmpty = false,
    this.backgroundColor,
  }) : super(key: key);

  final Widget child;
  final WidgetBuilder? loadingBuilder;
  final bool showLoading;
  final WidgetBuilder? emptyBuilder;
  final bool showEmpty;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    if (showLoading && loadingBuilder != null) {
      return Container(
        color: backgroundColor,
        child: loadingBuilder!(context),
      );
    } else if (showEmpty && emptyBuilder != null) {
      return Container(
        color: backgroundColor,
        child: emptyBuilder!(context),
      );
    }
    return child;
  }
}

class EmptyDataPlaceholder extends StatelessWidget {
  const EmptyDataPlaceholder({
    Key? key,
    this.tip,
    required this.icon,
    this.attachChild,
    this.onTap,
  }) : super(key: key);

  final String? tip;
  final Widget icon;
  final Widget? attachChild;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: onTap,
      child: _AnimationContainer(
        child: Align(
          alignment: const Alignment(0, -0.2),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              icon,
              if (tip != null)
                Text(
                  tip!,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Color(0xFF999999),
                    fontWeight: FontWeight.normal,
                    decoration: TextDecoration.none,
                  ),
                ),
              if (attachChild != null) attachChild!
            ],
          ),
        ),
      ),
    );
  }
}

class LoadingPlaceholder extends StatelessWidget {
  const LoadingPlaceholder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _AnimationContainer(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CircularProgressIndicator(
            color: Theme.of(context).primaryColor,
            strokeWidth: 3,
          ),
        ],
      ),
    );
  }
}

class _AnimationContainer extends StatefulWidget {
  const _AnimationContainer({
    Key? key,
    required this.child,
  }) : super(key: key);

  final Widget child;

  @override
  __AnimationContainerState createState() => __AnimationContainerState();
}

class __AnimationContainerState extends State<_AnimationContainer>
    with SingleTickerProviderStateMixin {
  AnimationController? _controller;
  Animation<double>? opacityAnimation;
  Animation<double>? scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 250),
    );
    opacityAnimation = Tween<double>(begin: 0, end: 1).animate(_controller!);
    scaleAnimation = Tween<double>(begin: 0.8, end: 1).animate(_controller!);
    _controller?.forward();
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: FadeTransition(
        opacity: opacityAnimation!,
        child: ScaleTransition(
          scale: scaleAnimation!,
          child: widget.child,
        ),
      ),
    );
  }
}
