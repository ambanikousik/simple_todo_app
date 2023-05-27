import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:simple_todo_app/application/auth_provider.dart';
import 'package:simple_todo_app/domain/auth/registration_body.dart';

class RegistrationPage extends HookConsumerWidget {
  const RegistrationPage({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final formKey = useMemoized(() => GlobalKey<FormState>());
    final firstName = useTextEditingController();
    final lastName = useTextEditingController();

    final emailController = useTextEditingController();
    final passwordController = useTextEditingController();
    final confirmPassController = useTextEditingController();
    final showPassword = useState(false);
    final loading = useState(false);

    return Scaffold(
      appBar: AppBar(title: const Text('Register')),
      body: Form(
        key: formKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: ListView(
            children: [
              const SizedBox(
                height: 60,
              ),
              TextFormField(
                controller: firstName,
                style: const TextStyle(fontSize: 18),
                decoration: const InputDecoration(
                    prefixIcon: Icon(CupertinoIcons.person),
                    labelText: 'First name',
                    hintText: 'John',
                    border: OutlineInputBorder()),
                validator: (value) => value == null || value.isEmpty
                    ? 'First name is required'
                    : null,
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: lastName,
                style: const TextStyle(fontSize: 18),
                decoration: const InputDecoration(
                    prefixIcon: Icon(CupertinoIcons.person),
                    labelText: 'Last name',
                    hintText: 'Whick',
                    border: OutlineInputBorder()),
                validator: (value) => value == null || value.isEmpty
                    ? 'Last name is required'
                    : null,
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: emailController,
                style: const TextStyle(fontSize: 18),
                decoration: const InputDecoration(
                    prefixIcon: Icon(CupertinoIcons.mail),
                    labelText: 'Email',
                    hintText: 'abc@email.com',
                    border: OutlineInputBorder()),
                validator: (value) => value == null || value.isEmpty
                    ? 'Please write down email address'
                    : null,
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: passwordController,
                style: const TextStyle(fontSize: 18),
                obscureText: !showPassword.value,
                decoration: InputDecoration(
                    prefixIcon: const Icon(CupertinoIcons.lock_circle),
                    suffix: InkWell(
                        onTap: () {
                          showPassword.value = !showPassword.value;
                        },
                        child: showPassword.value
                            ? const Icon(CupertinoIcons.lock_open)
                            : const Icon(CupertinoIcons.lock)),
                    labelText: 'Password',
                    hintText: 'xxxxxxx',
                    border: const OutlineInputBorder()),
                validator: (value) => value == null || value.length < 6
                    ? 'Password should contain at least 6 character'
                    : null,
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: confirmPassController,
                style: const TextStyle(fontSize: 18),
                obscureText: !showPassword.value,
                decoration: InputDecoration(
                    prefixIcon: const Icon(CupertinoIcons.lock_circle),
                    suffix: InkWell(
                        onTap: () {
                          showPassword.value = !showPassword.value;
                        },
                        child: showPassword.value
                            ? const Icon(CupertinoIcons.lock_open)
                            : const Icon(CupertinoIcons.lock)),
                    labelText: 'Confirm Password',
                    hintText: 'xxxxxxx',
                    border: const OutlineInputBorder()),
                validator: (value) => value == null || value.length < 6
                    ? 'Password should contain at least 6 character'
                    : value != passwordController.text
                        ? 'Passowrd didn\'t match'
                        : null,
              ),
              const SizedBox(
                height: 50,
              ),
              FilledButton.tonal(
                  onPressed: () async {
                    if (formKey.currentState?.validate() ?? false) {
                      final body = RegistrationBody(
                          firstName: firstName.text,
                          lastName: lastName.text,
                          email: emailController.text,
                          password: passwordController.text);

                      loading.value = true;
                      final result = await ref
                          .read(authProvider.notifier)
                          .registration(body);

                      if (result.isSome()) {
                        if (context.mounted) {
                          loading.value = false;
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content:
                                  Text(result.fold(() => '', (t) => t.error))));
                        }
                      }
                    }
                  },
                  child: loading.value
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : const Text('Register')),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Already have an account?'),
                  TextButton(
                      onPressed: () {
                        context.pop();
                      },
                      child: const Text('Login'))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  static const name = 'register';
  static const path = '/register';
}
