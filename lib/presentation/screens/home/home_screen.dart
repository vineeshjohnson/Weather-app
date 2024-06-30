import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:weather_app_project/bloc/weather_bloc.dart';
import 'package:weather_app_project/presentation/utils/weather_utils.dart';
import 'package:weather_app_project/presentation/screens/home/widgets/background_widget.dart';
import 'package:weather_app_project/presentation/screens/home/widgets/bottom_widget.dart';
import 'package:weather_app_project/presentation/screens/home/widgets/local_greeting_widget.dart';
import 'package:weather_app_project/presentation/screens/home/widgets/weather_detail_widget.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({
    super.key,
    required this.position,
  });

  final Position position;
  final WeatherUtils weatherUtils = WeatherUtils();

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<WeatherBloc>().add(WeatherInitialFetchEvent(position));
    });
    return Scaffold(
      backgroundColor: Colors.black,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(40, 1.2 * kToolbarHeight, 40, 20),
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Stack(
            children: [
              const BackgroundWidget(),
              BlocBuilder<WeatherBloc, WeatherState>(
                builder: (context, state) {
                  switch (state.runtimeType) {
                    case WeatherLoadingState:
                      return const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Weather',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 25,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          LinearProgressIndicator(
                            color: Colors.white,
                            minHeight: 2,
                          ),
                        ],
                      );

                    case WeatherSuccessState:
                      final succesState = state as WeatherSuccessState;
                      return LayoutBuilder(builder: (context, constraints) {
                        return RefreshIndicator(
                          onRefresh: () async {
                            return weatherUtils.onRefresh(context, position);
                          },
                          displacement: 20,
                          child: SingleChildScrollView(
                            physics: const AlwaysScrollableScrollPhysics(),
                            child: ConstrainedBox(
                              constraints: BoxConstraints(
                                minHeight: constraints.maxHeight,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Greeting And Location
                                  LocalAndGreetingWidget(
                                    succesState: succesState,
                                    weatherUtils: weatherUtils,
                                  ),

                                  // Weather Icon
                                  weatherUtils.getWeatherIcon(
                                    succesState.weather.weatherConditionCode!,
                                  ),

                                  // Weather Details
                                  WeatherDetailWidget(succesState: succesState),
                                  const SizedBox(height: 40),

                                  // Other details: Sunrise and sunset time, Max and min temperature
                                  BottomWidget(
                                    icon1: 'assets/images/11.png',
                                    icon2: 'assets/images/12.png',
                                    title1: 'Sunrise',
                                    title2: 'Sunset',
                                    subTitle1: DateFormat()
                                        .add_jm()
                                        .format(succesState.weather.sunrise!),
                                    subTitle2: DateFormat()
                                        .add_jm()
                                        .format(succesState.weather.sunset!),
                                  ),
                                  Divider(
                                    height: 40,
                                    color: Colors.grey.shade900,
                                  ),
                                  BottomWidget(
                                    icon1: 'assets/images/13.png',
                                    icon2: 'assets/images/14.png',
                                    title1: 'Temp Max',
                                    title2: 'Temp Min',
                                    subTitle1:
                                        '${succesState.weather.tempMax!.celsius!.round()}°C',
                                    subTitle2:
                                        '${succesState.weather.tempMin!.celsius!.round()}°C',
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      });

                    default:
                      return const SizedBox();
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
