import 'package:flutter/material.dart';
import 'package:radio/apps/weather/model/daily_weather.dart';

@immutable
abstract class DailyWeatherState {}

class DailyWeatherInitial extends DailyWeatherState {}

class DailyWeatherLoading extends DailyWeatherState {}

class DailyWeatherLoaded extends DailyWeatherState {
  final DailyWeather dailyweatherData;

  DailyWeatherLoaded({required this.dailyweatherData});
}

class DailyWeatherError extends DailyWeatherState {
  final String message;

  DailyWeatherError({required this.message});
}
