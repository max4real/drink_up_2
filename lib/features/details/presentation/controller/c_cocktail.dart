import 'package:data_connection_checker_tv/data_connection_checker.dart';
import 'package:drink_up_2/core/connection/network_info.dart';
import 'package:drink_up_2/features/details/business/usecase/get_drink_detail.dart';
import 'package:drink_up_2/features/details/data/data_source/liquor_datasource_local.dart';
import 'package:drink_up_2/features/details/data/data_source/liquor_datasource_remote.dart';
import 'package:drink_up_2/features/details/data/repo/liquor_repo_impl.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/errors/failure.dart';
import '../../business/entities/e_cock_tail_detail.dart';

class DrinkDetailControlller extends GetxController {
  ValueNotifier<DrinkDetialEntities?> drinkDetailEntities = ValueNotifier(null);
  ValueNotifier<Failure?> failure = ValueNotifier(null);

  void eitherFailureOrDrinkdetail({required String id}) async {
    DrinkDetailRepoImpl repo = DrinkDetailRepoImpl(
      dataSourceRemote: DrinkDetailRemoteDataSourceImpl(client: GetConnect()),
      datasourceLocal: DrinkDetailLocalDataSourceImpl(
          sharedPreferences: await SharedPreferences.getInstance()),
      networkInfo: NetworkInfoImpl(DataConnectionChecker()),
    );

    final response =
        await GetDrinkDetial(drinkDetailRepo: repo).fetchDrinkDetail(id: id);

    response.fold(
      (newFailure) {
        drinkDetailEntities.value = null;
        failure.value = newFailure;
      },
      (liquorData) {
        drinkDetailEntities.value = liquorData;
        failure.value = null;
      },
    );
  }
}
