import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

import 'package:bloc/bloc.dart';
import 'package:radio/apps/weather/model/weather.dart';
import 'package:radio/apps/weather/services/repository/location_repository.dart';
import 'package:radio/helpers/cache_helper.dart';
import 'package:radio/config.dart';
import 'package:radio/helpers/http_cached_helper.dart';

part 'weather_state.dart';

class WeatherCubit extends Cubit<WeatherState> {
  WeatherCubit(
    this._repository,
  ) : super(WeatherInitial());

  final LocationRepository _repository;
  final httpBase =
      HttpCached(CacheHelper(CacheOptions(const Duration(minutes: 10))));
  void fetchCurretWeather() async {
    try {
      emit(WeatherLoading());

      LocationPermission permission =
          await _repository.requestLocationPermission(
        onError: (message) {
          emit(WeatherError(message: message));
        },
      );

      if (permission == LocationPermission.denied ||
          permission == LocationPermission.deniedForever) {
        emit(WeatherError(message: 'Location permission denied.'));
        return;
      }

      Position position = await Geolocator.getCurrentPosition();
      String url =
          'https://api.openweathermap.org/data/2.5/weather?lat=${position.latitude}&lon=${position.longitude}&appid=${Config.weatherApiKey}&units=${Config.weatherUnits}';

      //http.Response response = await http.get(Uri.parse(url));
      final response = await httpBase.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final weatherData = jsonDecode(response.body);
        final weather = Weather.fromJson(weatherData);
        if (isClosed) return;
        emit(WeatherLoaded(weatherData: weather));
      } else {
        emit(WeatherError(message: 'Failed to fetch weather data'));
      }
    } catch (e) {
      emit(WeatherError(message: 'Error: $e'));
    }
  }
}
