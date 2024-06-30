import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather_app_project/bloc/weather_bloc.dart';
import 'package:weather_app_project/core/assets.dart';

class WeatherUtils {
  final WeatherIcons weatherIcons = WeatherIcons();

  Widget getWeatherIcon(int code) {
    switch (code) {
      case > 200 && < 300:
        return Image.asset(
          weatherIcons.thunderstorm,
        );
      case >= 300 && < 400:
        return Image.asset(
          weatherIcons.drizzle,
        );

      case >= 500 && < 600:
        return Image.asset(
          weatherIcons.rain,
        );
      case >= 600 && < 700:
        return Image.asset(
          weatherIcons.snow,
        );
      case >= 700 && < 800:
        return Image.asset(
          weatherIcons.atmosphere,
        );
      case == 800:
        return Image.asset(
          weatherIcons.clear,
        );
      case > 800 && <= 804:
        return Image.asset(
          weatherIcons.clouds,
        );
      default:
        return Image.asset(
          weatherIcons.clouds,
        );
    }
  }

  String greeting() {
    var hour = DateTime.now().hour;
    if (hour < 12) {
      return 'Good morning';
    }
    if (hour < 17) {
      return 'Good Afternoon';
    }
    return 'Good Evening';
  }

  Future<Position> determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    return await Geolocator.getCurrentPosition();
  }

  Future<void> onRefresh(BuildContext context, Position position) {
    return Future.delayed(const Duration(seconds: 1), () async {
      context.read<WeatherBloc>().add(WeatherInitialFetchEvent(position));
    });
  }
}
