import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:radio/apps/weather/controller/cubit/daily_weather_cubit.dart';
import 'package:radio/apps/weather/controller/cubit/daily_weather_state.dart';
import 'package:radio/apps/weather/services/repository/daily_weather_repository.dart';
import 'package:radio/apps/weather/view/seven_day_forecast.dart';

class DailyWeatherComponent extends StatefulWidget {
  const DailyWeatherComponent({Key? key}) : super(key: key);

  @override
  State<DailyWeatherComponent> createState() => _DailyWeatherComponentState();
}

class _DailyWeatherComponentState extends State<DailyWeatherComponent> {
  late final DailyWeatherCubit _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = DailyWeatherCubit(DailyWeatherRepository());
    _bloc.fetchDailyWeather();
  }

  @override
  void dispose() {
    _bloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DailyWeatherCubit, DailyWeatherState>(
      bloc: _bloc,
      builder: (context, state) {
        if (kDebugMode) {
          print("Daily.... $state");
        }
        if (state is DailyWeatherLoaded) {
          final list = state.dailyweatherData.daily;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.only(top: 15.0, left: 10.0),
                child: Text(
                  'Next 7 Days',
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Container(
                height: 160,
                margin: const EdgeInsets.all(8),
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: state.dailyweatherData.daily!.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (BuildContext context, int index) {
                    return SevenDayForecast(
                      weather: list![index],
                    );
                  },
                ),
              ),
            ],
          );
        } else if (state is DailyWeatherLoading) {
          return const Text("Loading forecast...");
        } else if (state is DailyWeatherError) {
          if (kDebugMode) {
            print(state.message);
          }
          return const SizedBox(
            height: 0,
            width: 0,
          );
        }
        return const SizedBox(
          height: 0,
          width: 0,
        );
      },
    );
  }
}
