import 'package:clean_api/clean_api.dart';
import 'package:simple_todo_app/domain/auth/login_body.dart';
import 'package:simple_todo_app/domain/auth/registration_body.dart';
import 'package:simple_todo_app/domain/auth/user_data.dart';

abstract class IAuthRepo {
  Future<Option<UserData>> tryLogin();
  Future<Either<CleanFailure, UserData>> login(LoginBody body);
  Future<Either<CleanFailure, UserData>> registration(RegistrationBody body);
  Future<void> logout();
}
