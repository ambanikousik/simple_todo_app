import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:simple_todo_app/application/auth_provider.dart';
import 'package:simple_todo_app/domain/auth/login_body.dart';
import 'package:simple_todo_app/presentation/auth/registration_page.dart';
import 'package:simple_todo_app/presentation/core_widgets/gradient_scaffold.dart';

class LoginPage extends HookConsumerWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final formKey = useMemoized(() => GlobalKey<FormState>());
    final emailController = useTextEditingController();
    final passwordController = useTextEditingController();
    final showPassword = useState(false);
    final loading = useState(false);
    return GradientScaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
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
                controller: emailController,
                style: const TextStyle(fontSize: 18),
                decoration: const InputDecoration(
                    fillColor: Colors.white24,
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
                    fillColor: Colors.white24,
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
                height: 50,
              ),
              FilledButton.tonal(
                  onPressed: () async {
                    if (formKey.currentState?.validate() ?? false) {
                      final body = LoginBody(
                          email: emailController.text,
                          password: passwordController.text);
                      loading.value = true;
                      final result =
                          await ref.read(authProvider.notifier).login(body);

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
                      : const Text('Login')),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Do not have any account?'),
                  TextButton(
                      onPressed: () {
                        context.push(RegistrationPage.path);
                      },
                      child: const Text('Register'))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  static const name = 'login';
  static const path = '/login';
}
