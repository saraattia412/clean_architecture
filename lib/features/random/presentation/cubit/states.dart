import 'package:clean_architecture/features/random/domain/entities/quote.dart';
import 'package:equatable/equatable.dart';

abstract class RandomQuoteStates extends Equatable {
  @override
  List<Object?> get props => [];
}

class InitialRandomQuoteStates extends RandomQuoteStates{}

class LoadingRandomQuoteStates extends RandomQuoteStates{}

class SuccessRandomQuoteStates extends RandomQuoteStates{
  final Quote quote;

  SuccessRandomQuoteStates({required this.quote});
  @override
  List<Object?> get props => [quote];
}

class ErrorRandomQuoteStates extends RandomQuoteStates{
  final String error;

  ErrorRandomQuoteStates({required this.error});
  @override
  List<Object?> get props => [error];
}