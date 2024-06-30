import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather/weather.dart';
import 'package:weather_app_project/data/weather_data.dart';

part 'weather_event.dart';
part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  WeatherBloc() : super(WeatherInitial()) {
    on<WeatherInitialFetchEvent>((event, emit) async {
      try {
        emit(WeatherLoadingState());
        WeatherFactory wf = WeatherFactory(apiKey, language: Language.ENGLISH);
        Weather weather = await wf.currentWeatherByLocation(
          event.position.latitude,
          event.position.longitude,
        );
        debugPrint("$weather");
        emit(WeatherSuccessState(weather));
      } catch (e) {
        emit(WeatherFailureState());
      }
    });
  }
}
