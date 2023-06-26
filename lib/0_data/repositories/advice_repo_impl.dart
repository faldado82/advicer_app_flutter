import 'package:advicer/0_data/datasources/advice_remote_datasource.dart';
import 'package:dartz/dartz.dart';
import 'package:advicer/1_domain/failures/failures.dart';
import 'package:advicer/1_domain/entities/advice_entity.dart';
import '../../1_domain/repositories/advice_repo.dart';
import '../datasources/exceptions/exceptions.dart';

class AdviceRepoImpl implements AdviceRepo {
  AdviceRepoImpl({required this.adviceRemoteDataSource});
  final AdviceRemoteDataSource adviceRemoteDataSource;

  @override
  Future<Either<Failure, AdviceEntity>> getAdviceFromDataSource() async {
    try {
      final result = await adviceRemoteDataSource.getRandomAdviceFromAPI();
      return right(result);
    } on ServerException catch (_) {
      return left(ServerFailure());
    } catch (e) {
      // handle the exception
      return left(GeneralFailure());
    }
  }
}
