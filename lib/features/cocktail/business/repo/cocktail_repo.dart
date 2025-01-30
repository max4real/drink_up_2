import 'package:dartz/dartz.dart';
import 'package:drink_up_2/features/cocktail/business/entities/e_cock_tail.dart';
import '../../../../../core/errors/failure.dart';

abstract class CocktailRepo {
  Future<Either<Failure, List<CockTailEntities>>> getCockTail({required String name});
}
