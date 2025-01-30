import 'package:drink_up_2/features/cocktail/business/entities/e_cock_tail.dart';

class CockTailModel extends CockTailEntities {
  CockTailModel({
    required super.id,
    required super.name,
    required super.image,
  });

  factory CockTailModel.fromAPI({required Map<String, dynamic> data}) {
    return CockTailModel(
      id: data["idDrink"].toString(),
      name: data["strDrink"].toString(),
      image: data["strDrinkThumb"].toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "idDrink": id,
      "strDrink": name,
      "strDrinkThumb": image,
    };
  }
}
