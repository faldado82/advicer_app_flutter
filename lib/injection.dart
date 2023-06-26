import 'package:advicer/0_data/datasources/advice_remote_datasource.dart';
import 'package:advicer/1_domain/usecases/advice_usecases.dart';
import 'package:advicer/3_application/pages/advice/cubit/advicer_cubit.dart';
import 'package:get_it/get_it.dart';
import '0_data/repositories/advice_repo_impl.dart';
import '1_domain/repositories/advice_repo.dart';
import 'package:http/http.dart' as http;

final sl = GetIt.I; // sl is service locator

Future<void> init() async {
  // ! aplication layer
  // Factory = every time a new/fresh instance of that class is created
  sl.registerFactory(() => AdvicerCubit(adviceUseCases: sl()));

  // ! domain layer
  sl.registerFactory(() => AdviceUseCases(adviceRepo: sl()));

  // ! data layer
  sl.registerFactory<AdviceRepo>(
      () => AdviceRepoImpl(adviceRemoteDataSource: sl()));
  sl.registerFactory<AdviceRemoteDataSource>(
      () => AdviceRemoteDataSourceImpl(client: sl()));

  // ! externs
  sl.registerFactory(() => http.Client());
}
