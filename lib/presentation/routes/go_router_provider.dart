import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'error_screen.dart';
import 'router_notifier.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();

final routerProvider = Provider.autoDispose<GoRouter>((ref) {
  final routerNotifier = ref.watch(routerNotifierProvider.notifier);

  return GoRouter(
    navigatorKey: _rootNavigatorKey,
    refreshListenable: routerNotifier,
    redirect: routerNotifier.redirect,
    routes: routerNotifier.routes,
    errorBuilder: (context, state) => RouteErrorScreen(
      error: state.error.toString(),
      key: state.pageKey,
    ),
  );
});
