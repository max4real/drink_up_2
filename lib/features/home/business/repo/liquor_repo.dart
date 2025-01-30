import 'package:dartz/dartz.dart';
import 'package:drink_up_2/features/home/business/entities/e_liquor.dart';
import '../../../../../core/errors/failure.dart';

abstract class LiquorRepo {
  Future<Either<Failure, List<LiquorEntities>>> getLiquor();
}
