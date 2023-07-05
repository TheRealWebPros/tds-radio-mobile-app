import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:provider/provider.dart';
import 'package:radio/apps/radio/bloc/radio_bloc.dart';
import 'package:radio/apps/radio/services/repository/radio_repository.dart';
import 'package:radio/apps/weather/controller/cubit/weather_cubit.dart';
import 'package:radio/apps/weather/services/repository/daily_weather_repository.dart';
import 'package:radio/apps/weather/services/repository/location_repository.dart';
import 'package:radio/config.dart';
import 'package:radio/all_screens.dart';
import 'package:radio/helpers/constant/app_styles.dart';

import 'apps/weather/controller/cubit/daily_weather_cubit.dart';

Future<void> main() async {
  await Hive.initFlutter();
  final box = await Hive.openBox("cache");
  box.clear();

  await JustAudioBackground.init(
    androidNotificationChannelId: 'com.ryanheise.bg_demo.channel.audio',
    androidNotificationChannelName: 'Audio playback',
    androidNotificationOngoing: true,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        BlocProvider<RadioBloc>(
          create: (_) => RadioBloc(
            repository: RadioRepository(),
          ),
        ),
        BlocProvider<WeatherCubit>(
            create: (context) => WeatherCubit(LocationRepository())),
        BlocProvider<DailyWeatherCubit>(
            create: (context) => DailyWeatherCubit(DailyWeatherRepository())),
      ],
      child: MaterialApp(
          title: Config.appName,
          debugShowCheckedModeBanner: false,
          themeMode: ThemeMode.dark,
          theme: ThemeData(
              useMaterial3: true,
              primaryColor: MaterialColor(
                primaryColorCode,
                <int, Color>{
                  50: const Color(primaryColorCode).withOpacity(0.1),
                  100: const Color(primaryColorCode).withOpacity(0.2),
                  200: const Color(primaryColorCode).withOpacity(0.3),
                  300: const Color(primaryColorCode).withOpacity(0.4),
                  400: const Color(primaryColorCode).withOpacity(0.5),
                  500: const Color(primaryColorCode).withOpacity(0.6),
                  600: const Color(primaryColorCode).withOpacity(0.7),
                  700: const Color(primaryColorCode).withOpacity(0.8),
                  800: const Color(primaryColorCode).withOpacity(0.9),
                  900: const Color(primaryColorCode).withOpacity(1.0),
                },
              ),
              scaffoldBackgroundColor: const Color(0xFF171821),
              fontFamily: 'IBMPlexSans',
              brightness: Brightness.dark),
          home: HomeScreen(),
          onGenerateRoute: (settings) {
            final routes = {
              "/": MaterialPageRoute(
                builder: (_) => HomeScreen(),
              ),
              // "/player": MaterialPageRoute(builder: (_) => const PlayerPage()),
            };

            return routes[settings.name];
          }),
    );
  }
}
