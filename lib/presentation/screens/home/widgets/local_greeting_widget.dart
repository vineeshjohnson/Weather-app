import 'package:flutter/material.dart';
import 'package:weather_app_project/bloc/weather_bloc.dart';
import 'package:weather_app_project/presentation/utils/weather_utils.dart';


class LocalAndGreetingWidget extends StatelessWidget {
  const LocalAndGreetingWidget({
    super.key,
    required this.succesState,
    required this.weatherUtils,
  });

  final WeatherSuccessState succesState;
  final WeatherUtils weatherUtils;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '${succesState.weather.areaName} 📍',
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w300,
          ),
        ),
        Text(
          weatherUtils.greeting(),
          style: const TextStyle(
            color: Colors.white,
            fontSize: 25,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }
}
