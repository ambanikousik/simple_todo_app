import 'package:date_formatter/date_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:simple_todo_app/application/task_list_provider.dart';
import 'package:simple_todo_app/domain/tasks/create_update_task_body.dart';
import 'package:simple_todo_app/presentation/core_widgets/glassomorphism.dart';
import 'package:simple_todo_app/presentation/core_widgets/gradient_scaffold.dart';

class CreateTaskPage extends HookConsumerWidget {
  const CreateTaskPage({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final titleController = useTextEditingController();
    final descriptionController = useTextEditingController();
    final datetime = useState<DateTime?>(null);
    final loading = useState(false);
    final formKey = useMemoized(() => GlobalKey<FormState>());

    return GradientScaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text('Create task'),
      ),
      body: Form(
        key: formKey,
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          children: [
            TextFormField(
              controller: titleController,
              decoration: InputDecoration(
                  fillColor: Colors.white24,
                  errorStyle: TextStyle(color: Colors.amber.shade50),
                  labelText: 'Title',
                  hintText: 'Write a short title',
                  border: const OutlineInputBorder()),
              validator: (value) =>
                  value == null || value.isEmpty ? 'Title is required' : null,
            ),
            const SizedBox(
              height: 10,
            ),
            TextFormField(
              controller: descriptionController,
              minLines: 4,
              maxLines: 100,
              decoration: InputDecoration(
                  fillColor: Colors.white24,
                  errorStyle: TextStyle(color: Colors.amber.shade50),
                  labelText: 'Description',
                  hintText: 'Task description',
                  border: const OutlineInputBorder()),
              validator: (value) => value == null || value.isEmpty
                  ? 'Description is required'
                  : null,
            ),
            const SizedBox(
              height: 10,
            ),
            Glassmorphism(
              blur: 10,
              opacity: 0.2,
              radius: 5,
              child: ListTile(
                onTap: () async {
                  datetime.value = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime.now(),
                      lastDate: DateTime(2025));
                },
                leading: const Icon(Icons.calendar_month),
                title: Text(
                    'Deadline: ${datetime.value != null ? DateFormatter.formatDateTime(
                        dateTime: datetime.value!,
                        outputFormat: 'dd/MM/yyyy',
                      ) : ''}'),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Center(
              child: FilledButton(
                  style: FilledButton.styleFrom(
                      backgroundColor: Colors.white30,
                      foregroundColor: Colors.white),
                  onPressed: () async {
                    if (formKey.currentState?.validate() ?? false) {
                      if (datetime.value == null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text('Please select a deadline')));
                      } else {
                        final body = CreateUpdateTaskBody(
                            title: titleController.text,
                            description: descriptionController.text,
                            deadline: datetime.value!,
                            isCompleted: false);
                        loading.value = true;
                        await ref
                            .read(taskListProvider.notifier)
                            .createTask(body);

                        if (context.mounted) {
                          context.pop();
                        }
                      }
                    }
                  },
                  child: loading.value
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : const Text('Create post')),
            )
          ],
        ),
      ),
    );
  }

  static const name = "create-task";

  static const path = "/create-task";
}
