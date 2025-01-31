import 'dart:convert';

import 'package:drink_up_2/features/details/data/model/liquor_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/errors/exceptions.dart';

abstract class DrinkDetailLocalDataSource {
  Future<void> cacheDrinkDetail(DrinkDetailModel? cacheDrinkDetail);

  Future<DrinkDetailModel> getLastDrinkDetail();
}

const cachedString = 'CACHED_DRINK_DETAIL';

class DrinkDetailLocalDataSourceImpl implements DrinkDetailLocalDataSource {
  final SharedPreferences sharedPreferences;

  DrinkDetailLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<void> cacheDrinkDetail(DrinkDetailModel? cacheDrinkDetail) async {
    if (cacheDrinkDetail != null) {
      sharedPreferences.setString(
        cachedString,
        json.encode(
          cacheDrinkDetail.toString(),
        ),
      );
    } else {
      throw CacheException();
    }
  }

  @override
  Future<DrinkDetailModel> getLastDrinkDetail() {
    final jsonString = sharedPreferences.getString(cachedString);

    if (jsonString != null) {
      final decodedList = json.decode(jsonString);
      DrinkDetailModel cacheDrinkDetail =
          DrinkDetailModel.fromApi(data: decodedList);

      return Future.value(cacheDrinkDetail);
    } else {
      throw CacheException();
    }
  }
}
