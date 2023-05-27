import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:simple_todo_app/application/auth_provider.dart';
import 'package:simple_todo_app/application/task_list_provider.dart';
import 'package:simple_todo_app/presentation/core_widgets/gradient_scaffold.dart';
import 'package:simple_todo_app/presentation/tasks/create_task_page.dart';
import 'package:simple_todo_app/presentation/tasks/widgets/author_widget.dart';
import 'package:simple_todo_app/presentation/tasks/widgets/task_tile.dart';

class HomePage extends HookConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final state = ref.watch(taskListProvider);
    return GradientScaffold(
        floatingActionButton: FloatingActionButton(
          foregroundColor: Colors.white,
          backgroundColor: Colors.red.shade600,
          shape: const CircleBorder(),
          onPressed: () {
            context.push(CreateTaskPage.path);
          },
          child: const Icon(Icons.add),
        ),
        body: state.when(
          loading: () => const Center(
            child: CircularProgressIndicator(),
          ),
          error: (error, _) => Center(
            child: Text(error.toString()),
          ),
          data: (data) => SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 50,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        child: Text(
                          'Simple Todo',
                          style: Theme.of(context)
                              .textTheme
                              .headlineLarge
                              ?.copyWith(fontWeight: FontWeight.w700),
                        ),
                      ),
                      const AuthorWidget(),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '${data.length} tasks',
                      ),
                      TextButton.icon(
                          onPressed: () {
                            showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                      backgroundColor:
                                          Colors.orange.withOpacity(0.7),
                                      title: const Text('Logout'),
                                      content: const Text(
                                          'Are you sure you want to logout ?'),
                                      actions: [
                                        FilledButton(
                                            onPressed: () {
                                              context.pop();
                                            },
                                            child: const Text('No')),
                                        OutlinedButton(
                                            style: OutlinedButton.styleFrom(
                                                foregroundColor: Colors.white),
                                            onPressed: () {
                                              ref
                                                  .read(authProvider.notifier)
                                                  .logout();
                                            },
                                            child: const Text('Yes'))
                                      ],
                                    ));
                          },
                          icon: const Icon(Icons.logout),
                          label: const Text('Logout'))
                    ],
                  ),
                  Expanded(
                      child: data.isEmpty
                          ? const Center(
                              child: Text(
                                'You do not have any task\nPlease create a new task',
                                textAlign: TextAlign.center,
                              ),
                            )
                          : ListView.separated(
                              itemCount: data.length,
                              itemBuilder: (context, index) => TaskTile(
                                task: data[index],
                                index: index,
                              ),
                              separatorBuilder: (context, index) =>
                                  const SizedBox(
                                height: 5,
                              ),
                            ))
                ],
              ),
            ),
          ),
        ));
  }

  static const name = "home";

  static const path = "/";
}
