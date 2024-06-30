part of 'weather_bloc.dart';

sealed class WeatherEvent extends Equatable {
  const WeatherEvent();

  @override
  List<Object> get props => [];
}

class WeatherInitialFetchEvent extends WeatherEvent {
  final Position position;

  const WeatherInitialFetchEvent(this.position);

  @override
  List<Object> get props => [position];
}
