import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:nutri_teca/data/data_source_contracts/auth_data_source_contract.dart';
import 'package:nutri_teca/domain/errors/failure.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthRemoteDataSource implements AuthDataSourceContract {
  final FirebaseAuth _firebaseAuth;
  final SharedPreferences _sharedPreferences;
  final GoogleSignIn _googleSignIn;

  AuthRemoteDataSource(
    this._firebaseAuth,
    this._sharedPreferences,
    this._googleSignIn,
  );

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
  Future<Either<Failure, User>> loginWithGoogle() async {
    try {
      // Realiza el flujo de autenticación de Google
      final googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        return Left(Failure(message: 'Google Sign-In was canceled'));
      }

      final googleAuth = await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Inicia sesión en Firebase
      final userCredential =
          await _firebaseAuth.signInWithCredential(credential);
      final user = userCredential.user!;

      // Guarda el userId en SharedPreferences
      await _sharedPreferences.setString('userId', user.uid);

      return Right(user);
    } on FirebaseAuthException catch (e) {
      return Left(Failure(message: _mapFirebaseError(e)));
    } catch (e) {
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
  Future<Either<Failure, void>> logout() async {
    try {
      await _firebaseAuth.signOut();

      await _sharedPreferences.remove('userId');

      return const Right(null);
    } on FirebaseAuthException catch (e) {
      return Left(Failure(message: _mapFirebaseError(e)));
    } catch (_) {
      return Left(Failure(message: 'Unexpected error occurred'));
    }
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
