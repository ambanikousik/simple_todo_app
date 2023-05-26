import 'package:clean_api/clean_api.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:simple_todo_app/domain/auth/i_auth_repo.dart';
import 'package:simple_todo_app/domain/auth/login_body.dart';
import 'package:simple_todo_app/domain/auth/registration_body.dart';
import 'package:simple_todo_app/domain/auth/user_data.dart';

class AuthRepo extends IAuthRepo {
  final api = CleanApi.instance;
  @override
  Future<Either<CleanFailure, UserData>> login(LoginBody body) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final data = await api.post(
        fromData: (data) => UserData.fromMap(data),
        endPoint: '/auth/login',
        body: body.toMap());

    return data.fold((l) => left(l), (r) {
      prefs.setString('token', r.token);
      api.setHeader({"Authorization": "Bearer ${r.token}"});
      return right(r);
    });
  }

  @override
  Future<void> logout() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('token');
  }

  @override
  Future<Either<CleanFailure, UserData>> registration(
      RegistrationBody body) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final data = await api.post(
        fromData: (data) => UserData.fromMap(data),
        endPoint: '/auth/register',
        body: body.toMap());

    return data.fold((l) => left(l), (r) {
      prefs.setString('token', r.token);
      api.setHeader({"Authorization": "Bearer ${r.token}"});
      return right(r);
    });
  }

  @override
  Future<Option<UserData>> tryLogin() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('token');

    if (token != null) {
      api.setHeader({"Authorization": "Bearer $token"});
      final data = await api.get(
          fromData: (data) => UserData.fromMap(data), endPoint: '/auth/user');
      return data.fold((l) => none(), (r) => some(r));
    } else {
      return none();
    }
  }
}
