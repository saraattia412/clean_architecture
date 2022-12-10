import 'package:clean_architecture/core/api/api_consumer.dart';
import 'package:clean_architecture/core/api/dio_consumer.dart';
import 'package:clean_architecture/core/network/network_info.dart';
import 'package:clean_architecture/features/random/data/data_source/random_quote_local_data_source.dart';
import 'package:clean_architecture/features/random/data/data_source/random_quote_remote_data_source.dart';
import 'package:clean_architecture/features/random/data/repositories/quote_repositories_impl.dart';
import 'package:clean_architecture/features/random/domain/repositories/quote_repositories.dart';
import 'package:clean_architecture/features/random/domain/use_cases/get_random_quote.dart';
import 'package:clean_architecture/features/random/presentation/cubit/cubit.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/api/app_intercepters.dart';

final sl = GetIt.instance;

Future<void> init() async {


  //! Features
     //Blocs

  sl.registerFactory(() => RandomQuoteCubit(getRandomQuoteUseCase: sl()));

    //Use Cases
  sl.registerLazySingleton(() => GetRandomQuote(quoteRepositories: sl()));

    // Repository
  sl.registerLazySingleton<QuoteRepositories>(
          () =>QuoteRepositoriesImpl(
      networkInfo: sl(),
      randomQuoteRemoteDataSource: sl(),
      randomQuoteLocalDataSource: sl()) ,
  );

    // Data Sources
  sl.registerLazySingleton<RandomQuoteLocalDataSource>(
          () => RandomQuoteLocalDataSourceImpl(sharedPreferences: sl()));

  sl.registerLazySingleton<RandomQuoteRemoteDataSource>(
          () => RandomQuoteRemoteDataSourceImpl(apiConsumer: sl()));


  //! Core
    //Network Info
  sl.registerLazySingleton<NetworkInfo>(() =>NetworkInfoImpl(connectionChecker: sl()));
  sl.registerLazySingleton<ApiConsumer>(() => DioConsumer(client: sl()));


  //! External
  sl.registerLazySingleton(() => Dio());
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => InternetConnectionChecker());
  sl.registerLazySingleton(() => AppInterceptors());
  sl.registerLazySingleton(() => LogInterceptor(
    //print all:
    request: true,
    requestBody: true,
    requestHeader: true,
    responseBody: true,
    responseHeader: true,
    error: true,
  ));

}