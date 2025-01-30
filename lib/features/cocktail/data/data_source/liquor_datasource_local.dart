import 'dart:convert';

import 'package:drink_up_2/features/cocktail/data/model/liquor_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/errors/exceptions.dart';

abstract class CockTailLocalDataSource {
  Future<void> cacheCockTail(List<CockTailModel>? cacheCockTail);

  Future<List<CockTailModel>> getLastCockTail();
}

const cachedString = 'CACHED_COCK_TAIL';

class CockTailLocalDataSourceImpl implements CockTailLocalDataSource {
  final SharedPreferences sharedPreferences;

  CockTailLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<void> cacheCockTail(List<CockTailModel>? cacheCockTail) async {
    if (cacheCockTail != null) {
      sharedPreferences.setString(
        cachedString,
        json.encode(
          cacheCockTail.map((liquor) => liquor.toJson()).toList(),
        ),
      );
    } else {
      throw CacheException();
    }
  }

  @override
  Future<List<CockTailModel>> getLastCockTail() {
    final jsonString = sharedPreferences.getString(cachedString);

    if (jsonString != null) {
      List<dynamic> decodedList = json.decode(jsonString);
      List<CockTailModel> cocktailList =
          decodedList.map((data) => CockTailModel.fromAPI(data: data)).toList();

      return Future.value(cocktailList);
    } else {
      throw CacheException();
    }
  }
}
