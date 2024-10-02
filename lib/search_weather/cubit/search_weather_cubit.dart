import 'package:flutter_bloc/flutter_bloc.dart';

part 'search_weather_state.dart';

class SearchWeatherCubit extends Cubit<SearchWeatherState> {
  ///initial state of the cubit
  SearchWeatherCubit() : super(InitialSearchWeather());

  void searchWeather(String city) async {
    ///if city is empty, emit an error state
    if (city.isEmpty || city.trim() == '') {
      emit(ErrorSearchWeather(message: 'City name cannot be empty'));
      return;
    }

    try {
      ///TODO create an API call here and put data into emit state
      await Future.delayed(const Duration(seconds: 2));
      double? temperature;
      emit(PostSearchedWeather(
        city: city,
        temperature: temperature!,
        isSunny: true,
      ));
    } catch (e) {
      emit(ErrorSearchWeather(message: e.toString()));
    }
  }
}
