import 'package:data_connection_checker_tv/data_connection_checker.dart';
import 'package:drink_up_2/core/connection/network_info.dart';
import 'package:drink_up_2/features/home/business/usecase/get_liquor.dart';
import 'package:drink_up_2/features/home/data/data_source/liquor_datasource_local.dart';
import 'package:drink_up_2/features/home/data/data_source/liquor_datasource_remote.dart';
import 'package:drink_up_2/features/home/data/repo/liquor_repo_impl.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/errors/failure.dart';
import '../../business/entities/e_liquor.dart';

class HomeController extends GetxController {
  ValueNotifier<List<LiquorEntities>> liquorList = ValueNotifier([]);
  ValueNotifier<Failure?> failure = ValueNotifier(null);

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    eitherFailureOrLiquor();
  }

  void eitherFailureOrLiquor() async {
    LiquorRepoImpl liquorRepoImpl = LiquorRepoImpl(
      dataSourceRemote: LiquorDatasourceRemoteImpl(client: GetConnect()),
      datasourceLocal: LiquorDatasourceLocalImpl(
        sharedPreferences: await SharedPreferences.getInstance(),
      ),
      networkInfo: NetworkInfoImpl(DataConnectionChecker()),
    );

    final response =
        await GetLiquor(liquorRepo: liquorRepoImpl).fetchAllLiquor();

    response.fold(
      (newFailure) {
        liquorList.value = [];
        failure.value = newFailure;
      },
      (liquorData) {
        liquorList.value = liquorData;
        failure.value = null;
      },
    );
  }
}
