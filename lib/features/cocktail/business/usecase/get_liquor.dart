import 'package:dartz/dartz.dart';
import 'package:drink_up_2/core/errors/failure.dart';
import 'package:drink_up_2/features/cocktail/business/entities/e_cock_tail.dart';
import 'package:drink_up_2/features/cocktail/business/repo/cocktail_repo.dart';

class GetCockTail {
  final CocktailRepo cocktailRepo;

  GetCockTail({required this.cocktailRepo});

  Future<Either<Failure, List<CockTailEntities>>> fetchAllCocktail(
      {required String name}) async {
    return await cocktailRepo.getCockTail(name: name);
  }
}
