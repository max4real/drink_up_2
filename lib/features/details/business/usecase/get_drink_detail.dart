import 'package:dartz/dartz.dart';
import 'package:drink_up_2/core/errors/failure.dart';
import 'package:drink_up_2/features/details/business/entities/e_cock_tail_detail.dart';
import 'package:drink_up_2/features/details/business/repo/drink_detail_repo.dart';

class GetDrinkDetial {
  final DrinkDetailRepo drinkDetailRepo;

  GetDrinkDetial({required this.drinkDetailRepo});

  Future<Either<Failure, DrinkDetialEntities>> fetchDrinkDetail(
      {required String id}) async {
    return await drinkDetailRepo.getDrinkDetail(id: id);
  }
}
