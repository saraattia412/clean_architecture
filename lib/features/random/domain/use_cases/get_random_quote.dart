
import 'package:clean_architecture/core/use_cases/use_case.dart';
import 'package:clean_architecture/features/random/domain/entities/quote.dart';
import 'package:clean_architecture/features/random/domain/repositories/quote_repositories.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';

class GetRandomQuote implements UseCase<Quote,NoParams>{

  final QuoteRepositories quoteRepositories;

  GetRandomQuote({required this.quoteRepositories});

  @override
  Future<Either<Failures, Quote>> call(NoParams params) =>
    quoteRepositories.getRandomQuote();

}