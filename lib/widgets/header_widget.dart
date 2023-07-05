import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:radio/apps/weather/view/weather_page.dart';
import 'package:radio/helpers/constant/app_styles.dart';
import 'package:radio/responsive.dart';

class Header extends StatefulWidget {
  final String title;
  const Header({
    super.key,
    required this.scaffoldKey,
    required this.title,
  });

  final GlobalKey<ScaffoldState> scaffoldKey;

  @override
  State<Header> createState() => _HeaderState();
}

class _HeaderState extends State<Header> {
  @override
  Widget build(BuildContext context) {
    if (Responsive.isMobile(context)) {
      return SliverAppBar.large(
        excludeHeaderSemantics: true,
        backgroundColor: appBarbg,
        centerTitle: false,
        title: Text(widget.title),
        leading: Builder(
          builder: (context) => IconButton(
            icon: const FaIcon(
              FontAwesomeIcons.bars,
            ),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (context, animation, secondaryAnimation) =>
                        const WeatherPage(),
                    transitionsBuilder:
                        (context, animation, secondaryAnimation, child) {
                      return SlideTransition(
                        position: Tween<Offset>(
                          begin: const Offset(0, 1),
                          end: Offset.zero,
                        ).animate(animation),
                        child: child,
                      );
                    },
                  ),
                );
              },
              icon: const FaIcon(
                FontAwesomeIcons.cloudRain,
                // color: Color.fromARGB(255, 250, 9, 5),
              ),
            ),
          )
        ],
      );
    } else if (Responsive.isTablet(context)) {
      return SliverAppBar.large(
        excludeHeaderSemantics: true,
        backgroundColor: appBarbg,
        floating: true,
        pinned: true,
        centerTitle: false,
        title: Text(widget.title),
        leading: Builder(
          builder: (context) => IconButton(
            icon: const FaIcon(
              FontAwesomeIcons.bars,
            ),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
      );
    } else {
      return SliverAppBar(
        backgroundColor: appBarbg,
        floating: true,
        pinned: true,
        centerTitle: false,
        title: Text(widget.title),
      );
    }
  }
}
