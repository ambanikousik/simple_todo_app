import 'package:clean_api/clean_api.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'presentation/routes/go_router_provider.dart';

void main() {
  CleanApi.instance.setup(
      baseUrl: 'https://simpletodoserver-production.up.railway.app/api',
      enableDialogue: true,
      showLogs: true);

  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final router = ref.watch(routerProvider);

    return MaterialApp.router(
      title: 'Simple Todo',
      darkTheme: FlexThemeData.dark(
          scheme: FlexScheme.gold,
          blendLevel: 10,
          useMaterial3: true,
          subThemesData: const FlexSubThemesData(),
          surfaceMode: FlexSurfaceMode.highScaffoldLowSurface),
      themeMode: ThemeMode.dark,
      routeInformationParser: router.routeInformationParser,
      routeInformationProvider: router.routeInformationProvider,
      routerDelegate: router.routerDelegate,
    );
  }
}
