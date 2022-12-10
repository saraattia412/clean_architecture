// ignore_for_file: avoid_types_as_parameter_names, non_constant_identifier_names

import 'package:clean_architecture/core/error/failures.dart';
import 'package:clean_architecture/core/use_cases/use_case.dart';
import 'package:clean_architecture/core/utils/app_strings.dart';
import 'package:clean_architecture/features/random/domain/entities/quote.dart';
import 'package:clean_architecture/features/random/presentation/cubit/states.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/use_cases/get_random_quote.dart';

class RandomQuoteCubit extends Cubit<RandomQuoteStates>{
  final GetRandomQuote getRandomQuoteUseCase;
  RandomQuoteCubit({required this.getRandomQuoteUseCase}) : super(InitialRandomQuoteStates());


  Future<void> getRandomQuote() async {
    emit(LoadingRandomQuoteStates());
    Either<Failures, Quote> response = await getRandomQuoteUseCase(NoParams());

    emit(response.fold(
            (Failures) => ErrorRandomQuoteStates(error: mapFailuresToMessage(Failures)),
            (Quote) => SuccessRandomQuoteStates(quote: (Quote))),
    );
  }

  String mapFailuresToMessage (Failures failures){
    switch(failures.runtimeType){
      case ServerFailures :
        return AppStrings.serverFailures;
      case CacheFailures :
        return AppStrings.cachedFailures;
      default :
        return AppStrings.unExpectedError;
    }

  }


}