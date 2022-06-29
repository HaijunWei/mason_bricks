import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../../generated/l10n.dart';
import 'empty_data_view.dart';

class RefreshControl extends StatelessWidget {
  const RefreshControl({
    Key? key,
    this.controller,
    this.notificationPredicate,
    required this.onRefresh,
    this.backgroundColor,
    required this.child,
  }) : super(key: key);

  final Widget child;
  final IndicatorController? controller;
  final OnRefresh onRefresh;
  final ScrollNotificationPredicate? notificationPredicate;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    const offsetToArmed = 60.0;
    return CustomRefreshIndicator(
      offsetToArmed: offsetToArmed,
      onRefresh: onRefresh,
      controller: controller,
      notificationPredicate:
          notificationPredicate ?? defaultScrollNotificationPredicate,
      onStateChanged: (change) {},
      builder: (
        BuildContext context,
        Widget child,
        IndicatorController controller,
      ) {
        const textStyle = TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: Color(0xFF999999),
        );
        return AnimatedBuilder(
          animation: controller,
          builder: (context, child) {
            Widget indicator = const SizedBox();
            if (controller.isDragging) {
              indicator = ClipRect(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.arrow_downward_rounded,
                      size: 20,
                      color: Color(0xFF999999),
                    ),
                    const SizedBox(width: 5),
                    Text(
                      S.of(context).refresh_header_idle,
                      style: textStyle,
                    ),
                  ],
                ),
              );
            } else if (controller.isArmed) {
              indicator = Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.arrow_upward_rounded,
                    size: 20,
                    color: Color(0xFF999999),
                  ),
                  const SizedBox(width: 5),
                  Text(
                    S.of(context).refresh_header_pulling,
                    style: textStyle,
                  ),
                ],
              );
            } else if (controller.isLoading) {
              indicator = Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const CupertinoActivityIndicator(),
                  const SizedBox(width: 8),
                  Text(
                    S.of(context).refresh_header_refreshing,
                    style: textStyle,
                  ),
                ],
              );
            }

            return Stack(
              children: [
                Offstage(
                  offstage: controller.value == 0,
                  child: Container(
                    width: double.infinity,
                    color: backgroundColor,
                    height: offsetToArmed * controller.value,
                    child: Opacity(
                      opacity: controller.value.clamp(0.0, 1.0),
                      child: indicator,
                    ),
                  ),
                ),
                Transform.translate(
                  offset: Offset(0.0, offsetToArmed * controller.value),
                  child: child,
                ),
              ],
            );
          },
          child: child,
        );
      },
      child: child,
    );
  }
}

class NewPageProgressIndicator extends StatelessWidget {
  const NewPageProgressIndicator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const CupertinoActivityIndicator(),
          const SizedBox(width: 8),
          Text(
            S.of(context).refresh_footer_refreshing,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Color(0xFF999999),
            ),
          )
        ],
      ),
    );
  }
}

class NoMoreDataIndicator extends StatelessWidget {
  const NoMoreDataIndicator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15),
        child: Text(
          '- ${S.of(context).placeholder_noMore} -',
          style: const TextStyle(
            fontSize: 14,
            color: Color(0xFF999999),
          ),
        ),
      ),
    );
  }
}

class DefaultPagedChildBuilderDelegate<ItemType>
    extends PagedChildBuilderDelegate<ItemType> {
  DefaultPagedChildBuilderDelegate({required super.itemBuilder})
      : super(
          firstPageProgressIndicatorBuilder: (context) =>
              const DefaultEmptyDataView(
            showLoading: true,
            child: SizedBox(),
          ),
          newPageProgressIndicatorBuilder: (context) =>
              const NewPageProgressIndicator(),
          newPageErrorIndicatorBuilder: (context) => Container(),
          noMoreItemsIndicatorBuilder: (context) => const NoMoreDataIndicator(),
          noItemsFoundIndicatorBuilder: (context) => const DefaultEmptyDataView(
            showEmpty: true,
            child: SizedBox(),
          ),
          firstPageErrorIndicatorBuilder: (context) =>
              const DefaultEmptyDataView(
            showEmpty: true,
            child: SizedBox(),
          ),
        );
}
