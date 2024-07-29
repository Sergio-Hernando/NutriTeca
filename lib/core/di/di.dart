import 'package:food_macros/core/network/dio_http_client.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'modules/api_modules.dart';
part 'modules/remote_datasource_modules.dart';
part 'modules/local_datasource_modules.dart';
part 'modules/repository_modules.dart';
part 'modules/ui_modules.dart';

void initDi({required SharedPreferences instance}) {
  _apiModulesInit();
  _remoteDataSourceModulesInit();
  _localDataSourceModulesInit(instance: instance);
  _repositoryModulesInit();
  _uiModulesInit();
}
