import 'package:equatable/equatable.dart';

abstract class Usecase<Output, Input> {
  Future<Output> call(Input params);
}

class NoParams extends Equatable {
  @override
  List<Object?> get props => [];
}
