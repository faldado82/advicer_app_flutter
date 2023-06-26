//import 'package:advicer/0_data/repositories/advice_repo_impl.dart';
import 'package:advicer/1_domain/entities/advice_entity.dart';
import 'package:advicer/1_domain/failures/failures.dart';
import 'package:advicer/1_domain/repositories/advice_repo.dart';
import 'package:dartz/dartz.dart';

class AdviceUseCases {
  AdviceUseCases({required this.adviceRepo});
  final AdviceRepo adviceRepo;
  
  Future<Either<Failure, AdviceEntity>> getAdvice() async {
    // call a repository to get data (failure or data)
    // proceed with business logic (manipulate data)
    return adviceRepo.getAdviceFromDataSource();
  }
}
