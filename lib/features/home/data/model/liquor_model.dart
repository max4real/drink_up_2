import 'package:drink_up_2/core/constants/constants.dart';
import 'package:drink_up_2/features/home/business/entities/e_liquor.dart';

class LiquorModel extends LiquorEntities {
  LiquorModel({
    required super.name,
    required super.image,
  });

  factory LiquorModel.fromAPI({required Map<String, dynamic> data}) {
    return LiquorModel(
        name: data["strIngredient1"].toString(),
        image: "$ingredientImageBaseUrl/" + data["strIngredient1"] + ".png");
  }

  Map<String, dynamic> toJson() {
    return {
      "strIngredient1": name,
      "$ingredientImageBaseUrl/$name.png": image,
    };
  }
}
