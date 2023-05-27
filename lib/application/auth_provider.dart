import 'package:clean_api/clean_api.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:simple_todo_app/application/auth_repo_provider.dart';
import 'package:simple_todo_app/domain/auth/login_body.dart';
import 'package:simple_todo_app/domain/auth/registration_body.dart';
import 'package:simple_todo_app/domain/auth/user_data.dart';

import 'task_list_provider.dart';

final authProvider =
    AsyncNotifierProvider<AuthNotifier, Option<UserData>>(AuthNotifier.new);

class AuthNotifier extends AsyncNotifier<Option<UserData>> {
  @override
  Future<Option<UserData>> build() {
    return ref.read(authRepoProvider).tryLogin();
  }

  Future<Option<CleanFailure>> login(LoginBody body) async {
    state = const AsyncLoading();
    final result = await ref.read(authRepoProvider).login(body);
    state = AsyncData(result.fold((l) => none(), (r) => some(r)));
    return result.fold((l) => some(l), (r) {
      ref.invalidate(taskListProvider);

      return none();
    });
  }

  Future<Option<CleanFailure>> registration(RegistrationBody body) async {
    state = const AsyncLoading();
    final result = await ref.read(authRepoProvider).registration(body);
    state = AsyncData(result.fold((l) => none(), (r) => some(r)));
    return result.fold((l) => some(l), (r) {
      ref.invalidate(taskListProvider);

      return none();
    });
  }

  void logout() async {
    await ref.read(authRepoProvider).logout();
    state = AsyncData(none());
  }
}
