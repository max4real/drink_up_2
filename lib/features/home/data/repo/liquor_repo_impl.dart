import 'package:dartz/dartz.dart';
import 'package:drink_up_2/core/connection/network_info.dart';
import 'package:drink_up_2/core/errors/failure.dart';
import 'package:drink_up_2/features/home/business/entities/e_liquor.dart';
import 'package:drink_up_2/features/home/business/repo/liquor_repo.dart';
import 'package:drink_up_2/features/home/data/data_source/liquor_datasource_local.dart';
import 'package:drink_up_2/features/home/data/data_source/liquor_datasource_remote.dart';

import '../../../../core/errors/exceptions.dart';

class LiquorRepoImpl implements LiquorRepo {
  final LiquorDataSourceRemote dataSourceRemote;
  final LiquorDatasourceLocal datasourceLocal;
  final NetworkInfo networkInfo;

  LiquorRepoImpl({
    required this.dataSourceRemote,
    required this.datasourceLocal,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, List<LiquorEntities>>> getLiquor() async {
    if (await networkInfo.isConnected!) {
      try {
        final remoteLiquor = await dataSourceRemote.getLiquor();

        datasourceLocal.cacheLiquor(remoteLiquor);

        return Right(remoteLiquor);
      } on ServerException {
        return Left(ServerFailure(errorMessage: 'This is a server exception'));
      }
    } else {
      try {
        final localPokemon = await datasourceLocal.getLastLiquor();
        return Right(localPokemon);
      } on CacheException {
        return Left(CacheFailure(errorMessage: 'No local data found'));
      }
    }
  }
}
