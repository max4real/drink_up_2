import 'package:drink_up_2/core/constants/constants.dart';
import 'package:drink_up_2/features/details/data/model/liquor_model.dart';
import 'package:get/get.dart';

import '../../../../core/errors/exceptions.dart';

abstract class DrinkDetailRemoteDataSource {
  Future<DrinkDetailModel> getDrinkDetail({required String id});
}

class DrinkDetailRemoteDataSourceImpl implements DrinkDetailRemoteDataSource {
  final GetConnect client;

  DrinkDetailRemoteDataSourceImpl({required this.client});

  @override
  Future<DrinkDetailModel> getDrinkDetail({required String id}) async {
    final response = await client.get(baseUrl + getDrinkDetailUrl + id);

    if (response.isOk) {
      Iterable iterable = response.body["drinks"] ?? [];
      Map<String, dynamic> rawData = iterable.firstOrNull ?? {};
      return DrinkDetailModel.fromApi(data: rawData);
    } else {
      throw ServerException();
    }
  }
}
