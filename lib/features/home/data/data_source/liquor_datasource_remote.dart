import 'package:drink_up_2/core/constants/constants.dart';
import 'package:drink_up_2/features/home/data/model/liquor_model.dart';
import 'package:get/get.dart';

import '../../../../core/errors/exceptions.dart';

abstract class LiquorDataSourceRemote {
  Future<List<LiquorModel>> getLiquor();
}

class LiquorDatasourceRemoteImpl implements LiquorDataSourceRemote {
  final GetConnect client;

  LiquorDatasourceRemoteImpl({required this.client});

  @override
  Future<List<LiquorModel>> getLiquor() async {
    final response = await client.get(baseUrl + getAllIngredientsUrl);

    if (response.isOk) {
      Iterable iterable = response.body["drinks"] ?? [];
      List<LiquorModel> temp = [];

      for (var element in iterable) {
        LiquorModel data = LiquorModel.fromAPI(data: element);
        temp.add(data);
      }

      return temp;
    } else {
      throw ServerException();
    }
  }
}
