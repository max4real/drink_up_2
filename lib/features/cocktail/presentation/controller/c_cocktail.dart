import 'package:data_connection_checker_tv/data_connection_checker.dart';
import 'package:drink_up_2/core/connection/network_info.dart';
import 'package:drink_up_2/features/cocktail/business/usecase/get_liquor.dart';
import 'package:drink_up_2/features/cocktail/data/data_source/liquor_datasource_local.dart';
import 'package:drink_up_2/features/cocktail/data/data_source/liquor_datasource_remote.dart';
import 'package:drink_up_2/features/cocktail/data/repo/liquor_repo_impl.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/errors/failure.dart';
import '../../business/entities/e_cock_tail.dart';

class CockTailController extends GetxController {
  ValueNotifier<List<CockTailEntities>> cocktailList = ValueNotifier([]);
  ValueNotifier<Failure?> failure = ValueNotifier(null);

  void eitherFailureOrCockTail({required String name}) async {
    CocktailRepoImpl repo = CocktailRepoImpl(
      dataSourceRemote: CockTailRemoteDataSourceImpl(client: GetConnect()),
      datasourceLocal: CockTailLocalDataSourceImpl(
        sharedPreferences: await SharedPreferences.getInstance(),
      ),
      networkInfo: NetworkInfoImpl(DataConnectionChecker()),
    );

    final response =
        await GetCockTail(cocktailRepo: repo).fetchAllCocktail(name: name);

    response.fold(
      (newFailure) {
        cocktailList.value = [];
        failure.value = newFailure;
      },
      (liquorData) {
        cocktailList.value = liquorData;
        failure.value = null;
      },
    );
  }
}
