import 'dart:async';
import 'package:clean_api/clean_api.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:simple_todo_app/application/auth_provider.dart';
import 'package:simple_todo_app/domain/auth/user_data.dart';
import 'package:simple_todo_app/presentation/auth/login_page.dart';
import 'package:simple_todo_app/presentation/auth/registration_page.dart';
import 'package:simple_todo_app/presentation/routes/error_screen.dart';
import 'package:simple_todo_app/presentation/tasks/create_task_page.dart';
import 'package:simple_todo_app/presentation/tasks/home_page.dart';

import 'loading_page.dart';

final routerNotifierProvider =
    AutoDisposeAsyncNotifierProvider<RouterNotifier, Option<UserData>>(() {
  return RouterNotifier();
});

class RouterNotifier extends AutoDisposeAsyncNotifier<Option<UserData>>
    implements Listenable {
  VoidCallback? routerListener;
  AsyncValue<Option<UserData>> authState = const AsyncLoading();

  @override
  Future<Option<UserData>> build() async {
    authState = ref.watch(authProvider);
    ref.listenSelf((_, __) {
      if (state.isLoading) return;
      routerListener?.call();
    });
    return ref.watch(
      authProvider.selectAsync((data) => data),
    );
  }

  List<RouteBase> get routes => [
        GoRoute(
          path: RegistrationPage.path,
          name: RegistrationPage.name,
          builder: (context, state) => RegistrationPage(
            key: state.pageKey,
          ),
        ),
        GoRoute(
          path: LoadingPage.path,
          name: LoadingPage.name,
          builder: (context, state) => LoadingPage(
            key: state.pageKey,
          ),
        ),
        GoRoute(
          path: LoginPage.path,
          name: LoginPage.name,
          builder: (context, state) => LoginPage(
            key: state.pageKey,
          ),
        ),
        GoRoute(
          path: HomePage.path,
          name: HomePage.name,
          builder: (context, state) => HomePage(
            key: state.pageKey,
          ),
        ),
        GoRoute(
          path: CreateTaskPage.path,
          name: CreateTaskPage.name,
          builder: (context, state) => CreateTaskPage(
            key: state.pageKey,
          ),
        ),
        GoRoute(
          path: RouteErrorScreen.path,
          name: RouteErrorScreen.name,
          builder: (context, state) => RouteErrorScreen(
            key: state.pageKey,
            error: '',
          ),
        ),
      ];

  String? redirect(BuildContext context, GoRouterState state) {
    // ref.watch(dbProvider).when(data: data, error: error, loading: loading)

    Logger.i("auth changed = $authState");
    final isGoingToLogin = state.matchedLocation == LoginPage.path ||
        state.matchedLocation == RegistrationPage.path;

    return authState.when(
        data: (data) {
          return data.fold(() {
            return isGoingToLogin ? null : LoginPage.path;
          },
              (t) => isGoingToLogin || state.matchedLocation == LoadingPage.path
                  ? HomePage.path
                  : null);
        },
        error: (error, _) => RouteErrorScreen.path,
        loading: () => LoadingPage.path);
  }

  @override
  void addListener(VoidCallback listener) => routerListener = listener;

  @override
  void removeListener(VoidCallback listener) => routerListener = null;
}
