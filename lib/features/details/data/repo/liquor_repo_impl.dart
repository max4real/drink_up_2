import 'package:dartz/dartz.dart';
import 'package:drink_up_2/core/connection/network_info.dart';
import 'package:drink_up_2/core/errors/failure.dart';
import 'package:drink_up_2/features/details/business/entities/e_cock_tail_detail.dart';
import 'package:drink_up_2/features/details/data/data_source/liquor_datasource_local.dart';
import 'package:drink_up_2/features/details/data/data_source/liquor_datasource_remote.dart';

import '../../../../core/errors/exceptions.dart';
import '../../business/repo/drink_detail_repo.dart';

class DrinkDetailRepoImpl implements DrinkDetailRepo {
  final DrinkDetailRemoteDataSource dataSourceRemote;
  final DrinkDetailLocalDataSource datasourceLocal;
  final NetworkInfo networkInfo;

  DrinkDetailRepoImpl({
    required this.dataSourceRemote,
    required this.datasourceLocal,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, DrinkDetialEntities>> getDrinkDetail(
      {required String id}) async {
    if (await networkInfo.isConnected!) {
      try {
        final remoteDrinkDetail = await dataSourceRemote.getDrinkDetail(id: id);

        datasourceLocal.cacheDrinkDetail(remoteDrinkDetail);

        return Right(remoteDrinkDetail);
      } on ServerException {
        return Left(ServerFailure(errorMessage: 'This is a server exception'));
      }
    } else {
      try {
        final localPokemon = await datasourceLocal.getLastDrinkDetail();
        return Right(localPokemon);
      } on CacheException {
        return Left(CacheFailure(errorMessage: 'No local data found'));
      }
    }
  }
}
