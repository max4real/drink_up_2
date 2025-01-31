import 'package:dartz/dartz.dart';
import 'package:drink_up_2/features/details/business/entities/e_cock_tail_detail.dart';
import '../../../../../core/errors/failure.dart';

abstract class DrinkDetailRepo {
  Future<Either<Failure, DrinkDetialEntities>> getDrinkDetail(
      {required String id});
}
