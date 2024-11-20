import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:nutri_teca/data/data_source_contracts/auth_data_source_contract.dart';
import 'package:nutri_teca/domain/errors/failure.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthRemoteDataSource implements AuthDataSourceContract {
  final FirebaseAuth _firebaseAuth;
  final SharedPreferences _sharedPreferences;

  AuthRemoteDataSource(this._firebaseAuth, this._sharedPreferences);

  @override
  Future<Either<Failure, User>> login(String email, String password) async {
    try {
      final userCredential = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      final user = userCredential.user!;
      _sharedPreferences.setString('userId', user.uid);
      return Right(user);
    } on FirebaseAuthException catch (e) {
      return Left(Failure(message: _mapFirebaseError(e)));
    } catch (_) {
      return Left(Failure(message: 'Unexpected error occurred'));
    }
  }

  @override
  Future<Either<Failure, User>> register(String email, String password) async {
    try {
      final userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      final user = userCredential.user!;
      _sharedPreferences.setString('userId', user.uid);
      return Right(user);
    } on FirebaseAuthException catch (e) {
      return Left(Failure(message: _mapFirebaseError(e)));
    } catch (_) {
      return Left(Failure(message: 'Unexpected error occurred'));
    }
  }

  @override
  Future<void> logout() async {
    await _firebaseAuth.signOut();
  }

  String _mapFirebaseError(FirebaseAuthException e) {
    switch (e.code) {
      case 'user-not-found':
        return 'User not found';
      case 'wrong-password':
        return 'Incorrect password';
      default:
        return 'Authentication error';
    }
  }
}
