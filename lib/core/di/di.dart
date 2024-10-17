import 'dart:async';

import 'package:food_macros/core/database/database_handler.dart';
import 'package:food_macros/core/network/dio_http_client.dart';
import 'package:food_macros/data/data_source/addite_data_source.dart';
import 'package:food_macros/data/data_source/aliment_data_source.dart';
import 'package:food_macros/data/data_source/monthly_spent_data_source.dart';
import 'package:food_macros/data/data_source/recipe_data_source.dart';
import 'package:food_macros/data/data_source_contracts/additives_data_source_contract.dart';
import 'package:food_macros/data/repositories/additive_repository.dart';
import 'package:food_macros/data/repositories/aliment_repository.dart';
import 'package:food_macros/data/data_source_contracts/aliment_data_source_contract.dart';
import 'package:food_macros/data/data_source_contracts/monthly_spent_data_source_contract.dart';
import 'package:food_macros/data/data_source_contracts/recipe_data_source_contract.dart';
import 'package:food_macros/data/repositories/monthly_spent_repository.dart';
import 'package:food_macros/data/repositories/recipe_repository.dart';
import 'package:food_macros/domain/models/monthly_spent_entity.dart';
import 'package:food_macros/domain/repository_contracts/additive_repository_contract.dart';
import 'package:food_macros/domain/repository_contracts/aliment_repository_contract.dart';
import 'package:food_macros/domain/repository_contracts/monthly_spent_repository_contract.dart';
import 'package:food_macros/domain/repository_contracts/recipe_repository_contract.dart';
import 'package:food_macros/presentation/screens/aliments_feature/add_aliment/bloc/add_aliment_bloc.dart';
import 'package:food_macros/presentation/screens/aliments_feature/aliments/bloc/aliments_bloc.dart';
import 'package:food_macros/presentation/screens/recipes_feature/add_recipe/bloc/add_recipe_bloc.dart';
import 'package:food_macros/presentation/screens/aliments_feature/aliment_detail/bloc/aliment_detail_bloc.dart';
import 'package:food_macros/presentation/screens/base_screen/bloc/base_screen_bloc.dart';
import 'package:food_macros/presentation/screens/home/bloc/home_bloc.dart';
import 'package:food_macros/presentation/screens/recipes_feature/recipe_detail/bloc/recipe_detail_bloc.dart';
import 'package:food_macros/presentation/screens/recipes_feature/recipes/bloc/recipe_bloc.dart';
import 'package:food_macros/presentation/screens/splash/bloc/splash_bloc.dart';
import 'package:food_macros/presentation/shared/aliment_action.dart';
import 'package:food_macros/presentation/shared/recipe_action.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'modules/api_modules.dart';
part 'modules/remote_datasource_modules.dart';
part 'modules/local_datasource_modules.dart';
part 'modules/repository_modules.dart';
part 'modules/ui_modules.dart';

void initDi(
    {required SharedPreferences instance,
    required DatabaseHandler dbInstance}) {
  _apiModulesInit();
  _remoteDataSourceModulesInit();
  _localDataSourceModulesInit(instance: instance, dbInstance: dbInstance);
  _repositoryModulesInit();
  _uiModulesInit();
}
