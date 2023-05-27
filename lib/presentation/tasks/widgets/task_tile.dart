import 'package:date_formatter/date_formatter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:simple_todo_app/application/task_list_provider.dart';
import 'package:simple_todo_app/domain/tasks/create_update_task_body.dart';
import 'package:simple_todo_app/domain/tasks/task_data.dart';
import 'package:simple_todo_app/presentation/core_widgets/context_theme.dart';
import 'package:simple_todo_app/presentation/core_widgets/glassomorphism.dart';
import 'package:simple_todo_app/presentation/tasks/edit_task_page.dart';

class TaskTile extends HookConsumerWidget {
  final TaskData task;
  final int index;
  const TaskTile({super.key, required this.task, required this.index});

  @override
  Widget build(BuildContext context, ref) {
    final loading = useState(false);
    return Glassmorphism(
      blur: 10,
      opacity: 0.2,
      radius: 5,
      child: ListTile(
        onTap: () async {
          final shouldUpdate = await showDialog<bool>(
              context: context,
              builder: (context) {
                return Dialog(
                  elevation: 0,
                  backgroundColor: Colors.transparent,
                  child: Glassmorphism(
                    blur: 10,
                    opacity: 0.2,
                    radius: 5,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            task.title,
                            style: context.theme.textTheme.titleLarge,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Text(
                            task.description,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              const SizedBox(
                                width: 80,
                                child: Text(
                                  'Created:',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                              Text(DateFormatter.formatDateTime(
                                dateTime: task.createdAt,
                                outputFormat: 'dd/MM/yyyy h:mm a',
                              ))
                            ],
                          ),
                          Row(
                            children: [
                              const SizedBox(
                                width: 80,
                                child: Text(
                                  'Updated:',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                              Text(DateFormatter.formatDateTime(
                                dateTime: task.updatedAt,
                                outputFormat: 'dd/MM/yyyy h:mm a',
                              ))
                            ],
                          ),
                          Row(
                            children: [
                              const SizedBox(
                                width: 80,
                                child: Text(
                                  'Deadline:',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                              Text(DateFormatter.formatDateTime(
                                dateTime: task.deadline,
                                outputFormat: 'dd/MM/yyyy',
                              ))
                            ],
                          ),
                          const Divider(
                            color: Colors.white,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              TextButton.icon(
                                onPressed: () {
                                  context.pop(false);
                                },
                                icon: const Icon(Icons.close),
                                label: const Text('Close'),
                              ),
                              TextButton.icon(
                                onPressed: () {
                                  Navigator.of(context)
                                      .pushReplacement(MaterialPageRoute(
                                          builder: (context) => EditTaskPage(
                                                task: task,
                                              )));
                                },
                                icon: const Icon(Icons.edit_document),
                                label: const Text('Edit'),
                              ),
                              TextButton(
                                onPressed: () {
                                  context.pop(true);
                                },
                                child: task.isCompleted
                                    ? const Text("Mark as\nIncomplete")
                                    : const Text("Mark as\nComplete"),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                );
              });
          if (shouldUpdate ?? false) {
            final body = CreateUpdateTaskBody(
                title: task.title,
                description: task.description,
                deadline: task.deadline,
                isCompleted: !task.isCompleted);
            loading.value = true;
            await ref.read(taskListProvider.notifier).updateTask(body, task.id);
            loading.value = false;
          }
        },
        leading: Text(
          (index + 1).toString(),
          style: Theme.of(context)
              .textTheme
              .titleLarge
              ?.copyWith(fontWeight: FontWeight.bold),
        ),
        title: Text(task.title),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              task.description,
              maxLines: 2,
            ),
            Text(
              'Deadline: ${DateFormatter.formatDateTime(
                dateTime: task.deadline,
                outputFormat: 'dd/MM/yyyy',
              )}',
              style: Theme.of(context).textTheme.labelSmall,
            ),
          ],
        ),
        trailing: task.isCompleted
            ? const Icon(
                CupertinoIcons.check_mark_circled_solid,
                color: Colors.white,
              )
            : loading.value
                ? const SizedBox(
                    width: 20,
                    child: AspectRatio(
                        aspectRatio: 1,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                        )),
                  )
                : null,
      ),
    );
  }
}
