import 'package:dartz/dartz.dart';
import 'package:drink_up_2/core/connection/network_info.dart';
import 'package:drink_up_2/core/errors/failure.dart';
import 'package:drink_up_2/features/cocktail/business/entities/e_cock_tail.dart';
import 'package:drink_up_2/features/cocktail/business/repo/cocktail_repo.dart';
import 'package:drink_up_2/features/cocktail/data/data_source/liquor_datasource_local.dart';
import 'package:drink_up_2/features/cocktail/data/data_source/liquor_datasource_remote.dart';

import '../../../../core/errors/exceptions.dart';

class CocktailRepoImpl implements CocktailRepo {
  final CockTailRemoteDataSource dataSourceRemote;
  final CockTailLocalDataSource datasourceLocal;
  final NetworkInfo networkInfo;

  CocktailRepoImpl({
    required this.dataSourceRemote,
    required this.datasourceLocal,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, List<CockTailEntities>>> getCockTail(
      {required String name}) async {
    if (await networkInfo.isConnected!) {
      try {
        final remoteCocktail = await dataSourceRemote.getCocktail(name: name);

        datasourceLocal.cacheCockTail(remoteCocktail);

        return Right(remoteCocktail);
      } on ServerException {
        return Left(ServerFailure(errorMessage: 'This is a server exception'));
      }
    } else {
      try {
        final localPokemon = await datasourceLocal.getLastCockTail();
        return Right(localPokemon);
      } on CacheException {
        return Left(CacheFailure(errorMessage: 'No local data found'));
      }
    }
  }
}
