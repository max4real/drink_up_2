import 'package:drink_up_2/core/constants/constants.dart';
import 'package:drink_up_2/features/cocktail/data/model/liquor_model.dart';
import 'package:get/get.dart';

import '../../../../core/errors/exceptions.dart';

abstract class CockTailRemoteDataSource {
  Future<List<CockTailModel>> getCocktail({required String name});
}

class CockTailRemoteDataSourceImpl implements CockTailRemoteDataSource {
  final GetConnect client;

  CockTailRemoteDataSourceImpl({required this.client});

  @override
  Future<List<CockTailModel>> getCocktail({required String name}) async {
    final response =
        await client.get(baseUrl + getDrinkByIngredientsUrl + name);

    if (response.isOk) {
      Iterable iterable = response.body["drinks"] ?? [];
      List<CockTailModel> temp = [];

      for (var element in iterable) {
        CockTailModel data = CockTailModel.fromAPI(data: element);
        temp.add(data);
      }

      return temp;
    } else {
      throw ServerException();
    }
  }
}
