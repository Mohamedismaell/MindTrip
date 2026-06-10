import 'package:equatable/equatable.dart';

abstract class TripShareState extends Equatable {
  const TripShareState();
  @override
  List<Object?> get props => [];
}

class TripShareInitial extends TripShareState {}

class TripShareLoading extends TripShareState {}

class TripShareSuccess extends TripShareState {}

class TripShareError extends TripShareState {
  final String message;
  const TripShareError(this.message);
  @override
  List<Object?> get props => [message];
}
