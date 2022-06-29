import 'package:flutter/material.dart';

class RouteListener extends StatefulWidget {
  const RouteListener({
    Key? key,
    required this.child,
    required this.observer,
    this.didPopNext,
  }) : super(key: key);

  final Widget child;
  final RouteObserver observer;
  final ValueChanged<BuildContext>? didPopNext;

  @override
  State<RouteListener> createState() => _RouteListenerState();
}

class _RouteListenerState extends State<RouteListener> with RouteAware {
  @override
  void didPopNext() {
    super.didPopNext();
    if (widget.didPopNext != null) {
      widget.didPopNext!(context);
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    widget.observer.subscribe(
      this,
      ModalRoute.of(context) as Route<dynamic>,
    );
  }

  @override
  void didUpdateWidget(covariant RouteListener oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.observer != widget.observer) {
      oldWidget.observer.unsubscribe(this);
      widget.observer.subscribe(
        this,
        ModalRoute.of(context) as Route<dynamic>,
      );
    }
  }

  @override
  void dispose() {
    widget.observer.unsubscribe(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
