import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather_app_project/presentation/screens/home/home_screen.dart';
import 'package:weather_app_project/presentation/screens/splash/splash_screen.dart';
import 'package:weather_app_project/presentation/utils/weather_utils.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: WeatherUtils().determinePosition(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return HomeScreen(
            position: snapshot.data as Position,
          );
        } else {
          return const SplashScreen();
        }
      },
    );
  }
}
