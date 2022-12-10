import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entities/quote.dart';

abstract class QuoteRepositories{
  Future<Either<Failures, Quote>> getRandomQuote();
}