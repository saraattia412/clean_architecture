import 'package:equatable/equatable.dart';

abstract class Failures extends Equatable{
  @override
  List<Object?> get props => [];

}

class ServerFailures extends Failures{}

class CacheFailures extends Failures{}