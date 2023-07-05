import 'package:flutter/material.dart';
import 'package:radio/apps/radio/views/player/player_component.dart';
import 'package:radio/apps/weather/view/current_weather_component.dart';
import 'package:radio/apps/weather/view/daily_weather_component.dart';
import 'package:radio/helpers/constant/app_styles.dart';
import 'package:radio/responsive.dart';

class RightSidebar extends StatelessWidget {
  const RightSidebar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: Responsive.isMobile(context)
          ? MediaQuery.of(context).size.width
          : null,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(Responsive.isMobile(context) ? 20 : 0.0),
          topLeft: Radius.circular(Responsive.isMobile(context) ? 20 : 0.0),
          topRight: Radius.circular(Responsive.isMobile(context) ? 20 : 0.0),
        ),
        color: cardBackgroundColor,
      ),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(0.0),
          child: Column(
            children: [
              const SizedBox(
                height: 50,
              ),
              const CurrentWeathercomponent(),
              const SizedBox(
                height: 15,
              ),
              const DailyWeatherComponent(),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: Responsive.isMobile(context) ? 0 : 5.0,
                    vertical: Responsive.isMobile(context) ? 0 : 20.0),
                child: !Responsive.isMobile(context)
                    ? const PlayerComponent()
                    : null,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
