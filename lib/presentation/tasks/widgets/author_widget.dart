import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:simple_todo_app/application/auth_provider.dart';

class AuthorWidget extends ConsumerWidget {
  const AuthorWidget({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final state = ref.watch(authProvider);
    return state.maybeWhen(
      orElse: () => const SizedBox.shrink(),
      data: (data) => data.fold(
          () => const SizedBox.shrink(),
          (t) => Card(
                color: Colors.white38,
                child: Padding(
                  padding: const EdgeInsets.all(5),
                  child: Row(
                    children: [
                      const Icon(CupertinoIcons.person_alt_circle),
                      const SizedBox(
                        width: 2,
                      ),
                      Text('${t.firstName} ${t.lastName}'),
                    ],
                  ),
                ),
              )),
    );
  }
}
