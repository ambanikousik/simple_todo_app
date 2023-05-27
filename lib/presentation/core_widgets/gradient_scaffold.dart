import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:simple_todo_app/presentation/core_widgets/context_theme.dart';

class GradientScaffold extends StatelessWidget {
  final PreferredSizeWidget? appBar;

  final Widget? body;

  final Widget? floatingActionButton;

  final Widget? drawer;

  final Widget? endDrawer;

  final Widget? bottomNavigationBar;

  final Widget? bottomSheet;

  final FloatingActionButtonLocation? floatingActionButtonLocation;

  final FloatingActionButtonAnimator? floatingActionButtonAnimator;

  final List<Widget>? persistentFooterButtons;

  final DrawerCallback? onDrawerChanged;

  final DrawerCallback? onEndDrawerChanged;

  final bool? resizeToAvoidBottomInset;

  final bool primary;

  final bool extendBody;

  final bool extendBodyBehindAppBar;

  final bool drawerEnableOpenDragGesture;

  final bool endDrawerEnableOpenDragGesture;

  /// {@macro flutter.material.DrawerController.dragStartBehavior}
  final DragStartBehavior drawerDragStartBehavior;
  final Color? drawerScrimColor;

  final double? drawerEdgeDragWidth;

  final String? restorationId;

  const GradientScaffold({
    Key? key,
    this.appBar,
    this.body,
    this.floatingActionButton,
    this.floatingActionButtonLocation,
    this.floatingActionButtonAnimator,
    this.persistentFooterButtons,
    this.drawer,
    this.onDrawerChanged,
    this.endDrawer,
    this.onEndDrawerChanged,
    this.bottomNavigationBar,
    this.bottomSheet,
    this.resizeToAvoidBottomInset,
    this.primary = true,
    this.drawerDragStartBehavior = DragStartBehavior.start,
    this.extendBody = false,
    this.extendBodyBehindAppBar = false,
    this.drawerScrimColor,
    this.drawerEdgeDragWidth,
    this.drawerEnableOpenDragGesture = true,
    this.endDrawerEnableOpenDragGesture = true,
    this.restorationId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: context.backgroundGradient,
      ),
      child: Scaffold(
        key: key,
        appBar: appBar,
        body: body,
        floatingActionButton: floatingActionButton,
        floatingActionButtonLocation: floatingActionButtonLocation,
        floatingActionButtonAnimator: floatingActionButtonAnimator,
        persistentFooterButtons: persistentFooterButtons,
        drawer: drawer,
        onDrawerChanged: onDrawerChanged,
        endDrawer: endDrawer,
        onEndDrawerChanged: onEndDrawerChanged,
        bottomNavigationBar: bottomNavigationBar,
        bottomSheet: bottomSheet,
        backgroundColor: Colors.transparent,
        resizeToAvoidBottomInset: resizeToAvoidBottomInset,
        primary: primary,
        drawerDragStartBehavior: drawerDragStartBehavior,
        extendBody: extendBody,
        extendBodyBehindAppBar: extendBodyBehindAppBar,
        drawerScrimColor: drawerScrimColor,
        drawerEdgeDragWidth: drawerEdgeDragWidth,
        drawerEnableOpenDragGesture: drawerEnableOpenDragGesture,
        endDrawerEnableOpenDragGesture: endDrawerEnableOpenDragGesture,
        restorationId: restorationId,
      ),
    );
  }
}
