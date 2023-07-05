import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:radio/apps/weather/model/weather.dart';
import 'package:radio/helpers/utils/weather_utils.dart';

class MainWeather extends StatelessWidget {
  final Weather weather;
  final TextStyle _style1 = const TextStyle(
    fontWeight: FontWeight.w500,
    fontSize: 20,
  );
  final TextStyle _style2 = TextStyle(
    fontWeight: FontWeight.w400,
    color: Colors.grey[700],
    fontSize: 16,
  );

  MainWeather({super.key, required this.weather});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(25, 15, 25, 5),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.location_on_outlined),
              Text(weather.cityName, style: _style1),
            ],
          ),
          const SizedBox(height: 5.0),
          Text(
            DateFormat.yMMMEd().add_jm().format(DateTime.now()),
            style: _style2,
          ),
          const SizedBox(height: 10.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              MapString.mapStringToIcon(
                context,
                weather.currently,
                55,
              ),
              const SizedBox(width: 16.0),
              Text(
                '${weather.temp.toStringAsFixed(0)}°C',
                style: const TextStyle(
                  fontSize: 55,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10.0),
          Text(
            'Feels like ${weather.feelsLike.toStringAsFixed(0)}°C',
            style: _style1.copyWith(fontSize: 19),
          ),
          const SizedBox(height: 5.0),
          Text(
            toBeginningOfSentenceCase(weather.description) ?? '',
            style: _style1.copyWith(fontSize: 19),
          ),
        ],
      ),
    );
  }
}
