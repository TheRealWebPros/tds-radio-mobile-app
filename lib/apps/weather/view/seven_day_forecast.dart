import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:radio/apps/weather/model/daily_weather.dart';
import 'package:radio/helpers/utils/weather_utils.dart';

class SevenDayForecast extends StatelessWidget {
  final Daily weather;

  const SevenDayForecast({super.key, required this.weather});

  @override
  Widget build(BuildContext context) {
    final date = DateTime.fromMillisecondsSinceEpoch(weather.dt! * 1000);

    final dayOfWeek = DateFormat('EEE').format(date);
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 7),
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.8),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(5),
          bottomLeft: Radius.circular(5),
          topRight: Radius.circular(5),
          bottomRight: Radius.circular(5),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4),
        child: Column(
          children: [
            FittedBox(
              child: Text(
                dayOfWeek,
                style: const TextStyle(
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
              child: MapString.mapStringToIcon(
                  context, weather.weather![0].main!, 35),
            ),
            Text(weather.weather![0].main!),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Text("Min: ${weather.temp!.min!.toStringAsFixed(0)} °C"),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Text("Max: ${weather.temp!.max!.toStringAsFixed(0)} °C"),
            ),
          ],
        ),
      ),
    );
  }
}
