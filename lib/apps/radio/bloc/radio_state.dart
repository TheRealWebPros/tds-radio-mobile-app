import 'package:radio/apps/radio/model/station.dart';

//abstract class RadioState extends Equatable {}

abstract class RadioState {}

class InitialState extends RadioState {
  List<Object> get props => [];
}

// class LoadingState extends RadioState {
//   @override
//   List<Object?> get props => [];
// }
class LoadingState extends RadioState {
  final Station station;
  LoadingState(this.station);
}

class RadioLoadedState extends RadioState {
  final Station station;

  RadioLoadedState({required this.station});
}

class PlayingState extends RadioState {
  final bool playing;
  final Station station;

  PlayingState(
    this.playing,
    this.station,
  );
}

class VolumeState extends RadioState {
  VolumeState(this.volume);

  final double volume;

  List<Object?> get props => [volume];
}

class ErrorState extends RadioState {
  final bool playing;
  final Station station;

  ErrorState(this.playing, this.station);
}
