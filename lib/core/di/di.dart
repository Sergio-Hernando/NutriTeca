import 'dart:async';

import 'package:nutri_teca/core/constants/app_urls.dart';
import 'package:nutri_teca/core/database/database_handler.dart';
import 'package:nutri_teca/core/network/dio_http_client.dart';
import 'package:nutri_teca/data/data_source/local_data_source/additives_data_source.dart';
import 'package:nutri_teca/data/data_source/local_data_source/aliment_data_source.dart';
import 'package:nutri_teca/data/data_source/local_data_source/monthly_spent_data_source.dart';
import 'package:nutri_teca/data/data_source/local_data_source/recipe_data_source.dart';
import 'package:nutri_teca/data/data_source/remote_data_source/api/additives_api.dart';
import 'package:nutri_teca/data/data_source/remote_data_source/api/aliment_api.dart';
import 'package:nutri_teca/data/data_source/remote_data_source/api/monthly_spent_api.dart';
import 'package:nutri_teca/data/data_source/remote_data_source/api/recipe_api.dart';
import 'package:nutri_teca/data/data_source_contracts/additives_data_source_contract.dart';
import 'package:nutri_teca/data/repositories/additive_repository.dart';
import 'package:nutri_teca/data/repositories/aliment_repository.dart';
import 'package:nutri_teca/data/data_source_contracts/aliment_data_source_contract.dart';
import 'package:nutri_teca/data/data_source_contracts/monthly_spent_data_source_contract.dart';
import 'package:nutri_teca/data/data_source_contracts/recipe_data_source_contract.dart';
import 'package:nutri_teca/data/repositories/monthly_spent_repository.dart';
import 'package:nutri_teca/data/repositories/recipe_repository.dart';
import 'package:nutri_teca/domain/models/monthly_spent_entity.dart';
import 'package:nutri_teca/domain/repository_contracts/additive_repository_contract.dart';
import 'package:nutri_teca/domain/repository_contracts/aliment_repository_contract.dart';
import 'package:nutri_teca/domain/repository_contracts/monthly_spent_repository_contract.dart';
import 'package:nutri_teca/domain/repository_contracts/recipe_repository_contract.dart';
import 'package:nutri_teca/presentation/screens/aliments_feature/add_aliment/bloc/add_aliment_bloc.dart';
import 'package:nutri_teca/presentation/screens/aliments_feature/aliments/bloc/aliments_bloc.dart';
import 'package:nutri_teca/presentation/screens/recipes_feature/add_recipe/bloc/add_recipe_bloc.dart';
import 'package:nutri_teca/presentation/screens/aliments_feature/aliment_detail/bloc/aliment_detail_bloc.dart';
import 'package:nutri_teca/presentation/screens/base_screen/bloc/base_screen_bloc.dart';
import 'package:nutri_teca/presentation/screens/home/bloc/home_bloc.dart';
import 'package:nutri_teca/presentation/screens/recipes_feature/recipe_detail/bloc/recipe_detail_bloc.dart';
import 'package:nutri_teca/presentation/screens/recipes_feature/recipes/bloc/recipe_bloc.dart';
import 'package:nutri_teca/presentation/screens/splash/bloc/splash_bloc.dart';
import 'package:nutri_teca/presentation/shared/aliment_action.dart';
import 'package:nutri_teca/presentation/shared/recipe_action.dart';
import 'package:get_it/get_it.dart';

part 'modules/api_modules.dart';
part 'modules/local_data_source_modules.dart';
part 'modules/remote_data_source_modules.dart';
part 'modules/repository_modules.dart';
part 'modules/ui_modules.dart';

void initDi({required DatabaseHandler dbInstance}) {
  _apiModulesInit();
  _remoteDataSourceModulesInit();
  _localDataSourceModulesInit(dbInstance: dbInstance);
  _repositoryModulesInit();
  _uiModulesInit();
}
