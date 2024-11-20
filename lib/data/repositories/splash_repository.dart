import 'package:nutri_teca/domain/repository_contracts/splash_repository_contract.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashRepository implements SplashRepositoryContract {
  final SharedPreferences _sharedPreferences;

  SplashRepository(this._sharedPreferences);

  @override
  String? getUserId() {
    return _sharedPreferences.getString('userId');
  }
}
