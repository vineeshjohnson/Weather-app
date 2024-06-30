import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather_app_project/bloc/weather_bloc.dart';

class WeatherDetailWidget extends StatelessWidget {
  const WeatherDetailWidget({
    super.key,
    required this.succesState,
  });

  final WeatherSuccessState succesState;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(
          child: Text(
            '${succesState.weather.temperature!.celsius!.round()}°C',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 55,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        Center(
          child: Text(
            succesState.weather.weatherMain!.toUpperCase(),
            style: const TextStyle(
              color: Colors.white,
              fontSize: 25,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        const SizedBox(height: 5),
        Center(
          child: Text(
            DateFormat('EEEE dd ·').add_jm().format(succesState.weather.date!),
            style: const TextStyle(
              color: Colors.white,
              fontSize: 15,
              fontWeight: FontWeight.w300,
            ),
          ),
        ),
      ],
    );
  }
}
