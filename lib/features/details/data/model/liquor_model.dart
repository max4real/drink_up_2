import 'package:drink_up_2/features/details/business/entities/e_cock_tail_detail.dart';
import 'package:drink_up_2/features/home/data/model/liquor_model.dart';

class DrinkDetailModel extends DrinkDetialEntities {
  DrinkDetailModel({
    required super.id,
    required super.name,
    required super.image,
    required super.instructions,
    required super.cockTaillDetailEntitiesList,
  });

  factory DrinkDetailModel.fromApi({required Map<String, dynamic> data}) {
    String id;
    id = data["idDrink"].toString();

    List<CockTaillDetailEntities> temp = [];

    for (var i = 1; i <= 15; i++) {
      String? strIngredient = data["strIngredient$i"];
      String? strMeasure = data["strMeasure$i"];

      if (strIngredient == null) {
        break;
      } else {
        LiquorModel ingredientModel_ =
            LiquorModel.fromAPI(data: {"strIngredient1": strIngredient});

        CockTaillDetailEntities mesure = CockTaillDetailEntities(
            liquorEntities: ingredientModel_, measurement: strMeasure);

        temp.add(mesure);
      }
    }

    return DrinkDetailModel(
      name: data["strDrink"].toString(),
      image: data["strDrinkThumb"].toString(),
      id: id,
      instructions: data["strInstructions"].toString(),
      cockTaillDetailEntitiesList: temp,
    );
  }
}
