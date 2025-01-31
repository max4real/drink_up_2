import 'package:drink_up_2/features/cocktail/business/entities/e_cock_tail.dart';
import 'package:drink_up_2/features/home/business/entities/e_liquor.dart';

class DrinkDetialEntities extends CockTailEntities {
  String instructions;
  List<CockTaillDetailEntities> cockTaillDetailEntitiesList;

  DrinkDetialEntities({
    required super.id,
    required super.name,
    required super.image,
    required this.instructions,
    required this.cockTaillDetailEntitiesList,
  });
}

class CockTaillDetailEntities {
  LiquorEntities liquorEntities;

  String? measurement;

  CockTaillDetailEntities({
    required this.liquorEntities,
    required this.measurement,
  });
}
