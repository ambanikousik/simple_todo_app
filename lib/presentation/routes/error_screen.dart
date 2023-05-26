import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:simple_todo_app/application/auth_provider.dart';

class RouteErrorScreen extends ConsumerWidget {
  final String error;
  const RouteErrorScreen({super.key, required this.error});

  @override
  Widget build(BuildContext context, ref) {
    final state = ref.watch(authProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Error'),
        centerTitle: true,
      ),
      body: state.maybeWhen(
          orElse: () => error.isEmpty
              ? const SizedBox.shrink()
              : Center(child: Text(error)),
          error: (error, _) => Center(
                child: Text(error.toString()),
              )),
    );
  }

  static const name = "error";

  static const path = "/error";
}
