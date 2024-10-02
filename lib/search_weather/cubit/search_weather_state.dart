part of 'search_weather_cubit.dart';

sealed class SearchWeatherState {}

final class InitialSearchWeather extends SearchWeatherState {}

// API =>
// data {city, temperature, isSunny} =>
// PostSearchedWeather(city, temperature, isSunny)=>
// Cubit to emit this =>
// UI to show this.
final class PostSearchedWeather extends SearchWeatherState {
  final String city;
  final double temperature;
  final bool isSunny;

  PostSearchedWeather({
    required this.city,
    required this.temperature,
    required this.isSunny,
  });
}

class ErrorSearchWeather extends SearchWeatherState {
  final String message;

  ErrorSearchWeather({required this.message});
}