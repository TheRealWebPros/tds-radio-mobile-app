import 'package:bloc/bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:radio/apps/weather/services/repository/daily_weather_repository.dart';

import 'daily_weather_state.dart';

class DailyWeatherCubit extends Cubit<DailyWeatherState> {
  final DailyWeatherRepository _repository;

  bool _isRequestingPermission = false;

  DailyWeatherCubit(this._repository) : super(DailyWeatherInitial());

  void fetchDailyWeather() async {
    try {
      emit(DailyWeatherLoading());

      // Check if a permission request is already in progress
      if (_isRequestingPermission) {
        return;
      }

      // Set the flag to indicate a permission request is in progress
      _isRequestingPermission = true;

      // LocationPermission permission =
      //     await _repository.requestLocationPermission(
      //   onError: (message) {
      //     emit(DailyWeatherError(message: message));
      //   },
      // );

      // if (permission == LocationPermission.denied ||
      //     permission == LocationPermission.deniedForever) {
      //   emit(DailyWeatherError(message: 'Location permission denied.'));
      //   return;
      // }

      Position position = await Geolocator.getCurrentPosition();
      final forecast = await _repository.fetchWeatherForecast(
          position.latitude, position.longitude);
      if (isClosed) return;

      if (forecast.daily!.isNotEmpty) {
        emit(DailyWeatherLoaded(dailyweatherData: forecast));
      } else {
        emit(DailyWeatherError(message: 'Failed to fetch weather forecast'));
      }
    } catch (e) {
      emit(DailyWeatherError(message: 'Error: $e'));
    } finally {
      // Reset the flag to indicate the permission request is complete
      _isRequestingPermission = false;
    }
  }
}
