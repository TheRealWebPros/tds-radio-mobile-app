import 'dart:convert';

import 'package:radio/apps/weather/model/daily_weather.dart';
import 'package:radio/helpers/cache_helper.dart';
import 'package:radio/config.dart';
import 'package:radio/helpers/http_cached_helper.dart';

class DailyWeatherRepository {
  final httpBase =
      HttpCached(CacheHelper(CacheOptions(const Duration(minutes: 10))));

  Future<DailyWeather> fetchWeatherForecast(
      double latitude, double longitude) async {
    String url =
        'https://api.openweathermap.org/data/2.5/onecall?lat=$latitude&lon=$longitude&appid=${Config.weatherApiKey}&exclude=minutely,current&units=${Config.weatherUnits}';
    final response = await httpBase.get(Uri.parse(url));

    if (response.statusCode == 200) {
      return DailyWeather.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed');
    }
  }
}
