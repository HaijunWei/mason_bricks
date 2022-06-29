import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';
import 'package:flutter/material.dart';

import '../action_state.dart';
import 'empty_data_view.dart';
import 'refresh_control.dart';

class PageScaffold extends StatelessWidget {
  const PageScaffold({
    Key? key,
    this.state,
    this.isEmpty,
    this.refreshBackgroundColor,
    this.refreshController,
    this.onRefresh,
    this.onReload,
    this.loadingWidget,
    required this.child,
  }) : super(key: key);

  final OnRefresh? onRefresh;
  final IndicatorController? refreshController;
  final Color? refreshBackgroundColor;

  final ActionState? state;
  final bool Function()? isEmpty;
  final VoidCallback? onReload;

  final Widget? loadingWidget;

  final Widget child;

  @override
  Widget build(BuildContext context) {
    Widget child = this.child;
    if (onRefresh != null) {
      child = RefreshControl(
        controller: refreshController,
        onRefresh: onRefresh!,
        backgroundColor: refreshBackgroundColor,
        child: child,
      );
    }

    if (state != null && isEmpty != null) {
      child = DataStateScaffold(
        isEmpty: isEmpty!,
        state: state!,
        inRefreshControl: onRefresh != null,
        loadingWidget: loadingWidget,
        onReload: onReload,
        child: child,
      );
    }

    return child;
  }
}

class DataStateScaffold extends StatelessWidget {
  const DataStateScaffold({
    Key? key,
    required this.state,
    required this.isEmpty,
    this.loadingWidget,
    this.inRefreshControl = true,
    this.emptyAttachChild,
    this.onReload,
    required this.child,
  }) : super(key: key);

  final ActionState state;
  final bool Function() isEmpty;
  final Widget child;
  final Widget? loadingWidget;
  final bool inRefreshControl;
  final Widget? emptyAttachChild;
  final VoidCallback? onReload;

  @override
  Widget build(BuildContext context) {
    return state.when(
      initial: () {
        if (isEmpty()) {
          final child = DefaultEmptyDataView(
            showEmpty: true,
            onEmptyTap: onReload,
            emptyAttachChild: emptyAttachChild,
            child: const SizedBox(),
          );
          if (inRefreshControl) {
            return LayoutBuilder(
              builder: (context, constraints) => SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: SizedBox(
                  width: constraints.maxWidth,
                  height: constraints.maxHeight,
                  child: child,
                ),
              ),
            );
          }
        }
        return child;
      },
      running: () {
        if (isEmpty()) {
          return loadingWidget ??
              const DefaultEmptyDataView(
                showLoading: true,
                child: SizedBox(),
              );
        }
        return child;
      },
      success: (_) {
        if (isEmpty()) {
          final child = DefaultEmptyDataView(
            showEmpty: true,
            onEmptyTap: onReload,
            emptyAttachChild: emptyAttachChild,
            child: const SizedBox(),
          );
          if (inRefreshControl) {
            return LayoutBuilder(
              builder: (context, constraints) => SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: SizedBox(
                  width: constraints.maxWidth,
                  height: constraints.maxHeight,
                  child: child,
                ),
              ),
            );
          }
        }
        return child;
      },
      failure: (_) {
        if (isEmpty()) {
          final child = DefaultEmptyDataView(
            showEmpty: true,
            onEmptyTap: onReload,
            emptyAttachChild: emptyAttachChild,
            child: const SizedBox(),
          );
          if (inRefreshControl) {
            return LayoutBuilder(
              builder: (context, constraints) => SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: SizedBox(
                  width: constraints.maxWidth,
                  height: constraints.maxHeight,
                  child: child,
                ),
              ),
            );
          }
        }
        return child;
      },
    );
  }
}
