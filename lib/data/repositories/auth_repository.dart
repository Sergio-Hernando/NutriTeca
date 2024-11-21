import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:nutri_teca/data/data_source_contracts/auth_data_source_contract.dart';
import 'package:nutri_teca/domain/errors/failure.dart';
import 'package:nutri_teca/domain/repository_contracts/auth_repository_contract.dart';

class AuthRepository implements AuthRepositoryContract {
  final AuthDataSourceContract _authDataSourceContract;

  AuthRepository(this._authDataSourceContract);

  @override
  Future<Either<Failure, User>> login(String email, String password) {
    return _authDataSourceContract.login(email, password);
  }

  @override
  Future<Either<Failure, User>> loginWithGoogle() {
    return _authDataSourceContract.loginWithGoogle();
  }

  @override
  Future<Either<Failure, User>> register(String email, String password) {
    return _authDataSourceContract.register(email, password);
  }

  @override
  Future<Either<Failure, void>> logout() {
    return _authDataSourceContract.logout();
  }
}
