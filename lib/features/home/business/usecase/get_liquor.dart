import 'package:dartz/dartz.dart';
import 'package:drink_up_2/core/errors/failure.dart';
import 'package:drink_up_2/features/home/business/entities/e_liquor.dart';
import 'package:drink_up_2/features/home/business/repo/liquor_repo.dart';

class GetLiquor {
  final LiquorRepo liquorRepo;

  GetLiquor({required this.liquorRepo});

  Future<Either<Failure, List<LiquorEntities>>> fetchAllLiquor() async {
    return await liquorRepo.getLiquor();
  }
}
