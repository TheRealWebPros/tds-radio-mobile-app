part of 'station_cubit.dart';

@immutable
abstract class StationState {}

class StationInitial extends StationState {}

class StationLoading extends StationState {}

class StationLoaded extends StationState {
  final Station data;

  StationLoaded({required this.data});
}

class StationError extends StationState {
  final String error;

  StationError({required this.error});
}

class StationEmpty extends StationState {
  final Station data;
  final bool isEmpty;

  StationEmpty({required this.data, required this.isEmpty});
}
