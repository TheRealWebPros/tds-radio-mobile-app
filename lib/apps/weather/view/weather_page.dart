import 'package:flutter/material.dart';
import 'package:radio/widgets/right_sidebar.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({Key? key}) : super(key: key);

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(
              Icons.close,
            ),
            onPressed: () => Navigator.pop(context),
          ),
        ),
      ),
      body: const RightSidebar(),
    );
  }
}
