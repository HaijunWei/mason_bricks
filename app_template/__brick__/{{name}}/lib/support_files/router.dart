import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:{{name}}/modules/splash/splash.dart';

final routeObserver = RouteObserver<PageRoute>();

const _notLoginPages = [
  '/',
  '/splash',
];

final router = GoRouter(
  initialLocation: '/splash',
  observers: [routeObserver],
  debugLogDiagnostics: true,
  routes: [
    GoRoute(path: '/', builder: (context, state) => Container()),
    GoRoute(
      path: '/splash',
      pageBuilder: (context, state) => NoTransitionPage(
        key: state.pageKey,
        child: const SplashPage(),
      ),
    ),
  ],
  redirect: (state) {
    bool isLogged = true;
    if (isLogged && !_notLoginPages.contains(state.subloc)) {
      return '/login';
    }
    return null;
  },
);

class NoTransitionPage extends CustomTransitionPage {
  NoTransitionPage({super.key, required super.child})
      : super(
          transitionsBuilder: (context, animation, secondaryAnimation, child) =>
              child,
        );
}
