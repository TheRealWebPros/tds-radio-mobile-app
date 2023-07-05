import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:radio/apps/weather/controller/cubit/weather_cubit.dart';
import 'package:radio/apps/weather/services/repository/location_repository.dart';
import 'package:radio/apps/weather/view/main_weather.dart';

class CurrentWeathercomponent extends StatefulWidget {
  const CurrentWeathercomponent({Key? key}) : super(key: key);

  @override
  State<CurrentWeathercomponent> createState() =>
      _CurrentWeathercomponentState();
}

class _CurrentWeathercomponentState extends State<CurrentWeathercomponent> {
  late final WeatherCubit _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = WeatherCubit(LocationRepository());
    _bloc.fetchCurretWeather();
  }

  @override
  void dispose() {
    _bloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WeatherCubit, WeatherState>(
      bloc: _bloc,
      builder: (context, state) {
        if (kDebugMode) {
          print("Current.... $state");
        }

        if (state is WeatherLoading) {
          return const Text("Loading...");
        }
        if (state is WeatherLoaded) {
          return MainWeather(
            weather: state.weatherData,
          );
        }

        if (state is WeatherError) {
          if (kDebugMode) {
            print(state.message);
          }
          return Text(state.message);
        }

        return const Text("");
      },
    );
  }
}
