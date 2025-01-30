import 'dart:convert';

import 'package:drink_up_2/features/home/data/model/liquor_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/errors/exceptions.dart';

abstract class LiquorDatasourceLocal {
  Future<void> cacheLiquor(List<LiquorModel>? cacheLiquor);

  Future<List<LiquorModel>> getLastLiquor();
}

const cachedString = 'CACHED_LIQUOR';

class LiquorDatasourceLocalImpl implements LiquorDatasourceLocal {
  final SharedPreferences sharedPreferences;

  LiquorDatasourceLocalImpl({required this.sharedPreferences});

  @override
  Future<void> cacheLiquor(List<LiquorModel>? cacheLiquor) async {
    if (cacheLiquor != null) {
      sharedPreferences.setString(
        cachedString,
        json.encode(
          cacheLiquor.map((liquor) => liquor.toJson()).toList(),
        ),
      );
    } else {
      throw CacheException();
    }
  }

  @override
  Future<List<LiquorModel>> getLastLiquor() {
    final jsonString = sharedPreferences.getString(cachedString);

    if (jsonString != null) {
      List<dynamic> decodedList = json.decode(jsonString);
      List<LiquorModel> liquorList =
          decodedList.map((data) => LiquorModel.fromAPI(data: data)).toList();

      return Future.value(liquorList);
    } else {
      throw CacheException();
    }
  }
}
