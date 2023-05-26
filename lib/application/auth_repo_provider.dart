import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:simple_todo_app/domain/auth/i_auth_repo.dart';
import 'package:simple_todo_app/infrastructure/auth_repo.dart';

final authRepoProvider = Provider<IAuthRepo>((ref) {
  return AuthRepo();
});
