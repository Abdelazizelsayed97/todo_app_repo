import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../../core/failures/failures.dart';
import '../entity/login_input.dart';
import '../repository/auth_repositories.dart';

class LoginUseCase {
  final AuthRepositories _authRepositories;

  LoginUseCase(this._authRepositories);

  Future<Either<Failure, UserCredential>> execute(LoginInput input) async {
    return await _authRepositories.login(input);
  }
}
