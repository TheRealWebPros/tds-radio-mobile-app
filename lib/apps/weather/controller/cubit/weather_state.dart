part of 'weather_cubit.dart';

@immutable
abstract class WeatherState {}

class WeatherInitial extends WeatherState {}

class WeatherLoading extends WeatherState {}

class WeatherLoaded extends WeatherState {
  final Weather weatherData;

  WeatherLoaded({required this.weatherData});
}

class WeatherError extends WeatherState {
  final String message;

  WeatherError({required this.message});
}
