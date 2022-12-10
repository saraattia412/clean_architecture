import 'package:clean_architecture/core/error/exceptions.dart';
import 'package:clean_architecture/core/error/failures.dart';
import 'package:clean_architecture/core/network/network_info.dart';
import 'package:clean_architecture/features/random/domain/entities/quote.dart';
import 'package:clean_architecture/features/random/domain/repositories/quote_repositories.dart';
import 'package:dartz/dartz.dart';

import '../data_source/random_quote_local_data_source.dart';
import '../data_source/random_quote_remote_data_source.dart';

class QuoteRepositoriesImpl implements QuoteRepositories{

  final NetworkInfo networkInfo;
  final RandomQuoteRemoteDataSource randomQuoteRemoteDataSource;
  final RandomQuoteLocalDataSource randomQuoteLocalDataSource;

  QuoteRepositoriesImpl({
    required this.networkInfo,
    required this.randomQuoteRemoteDataSource,
    required this.randomQuoteLocalDataSource
  });

  @override
  Future<Either<Failures, Quote>> getRandomQuote() async{
    if(await networkInfo.isConnected){
      try{
        final remoteRandomQuote =await randomQuoteRemoteDataSource.getRandomQuote();
        randomQuoteLocalDataSource.cacheQuote(remoteRandomQuote);
        return Right(remoteRandomQuote);
      }
      on ServerExceptions{
        return Left(ServerFailures());
      }
    }else{
      try{
        final cacheRandomQuote =await randomQuoteLocalDataSource.getLastRandomQuote();
        return Right(cacheRandomQuote);
      }
      on CacheExceptions{
        return Left(CacheFailures());
      }
    }


  }

}