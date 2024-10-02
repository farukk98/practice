import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_1/search_weather/cubit/search_weather_cubit.dart';

class SearchWeatherUI extends StatefulWidget {
  const SearchWeatherUI({super.key});

  @override
  State<SearchWeatherUI> createState() => _SearchWeatherUIState();
}

class _SearchWeatherUIState extends State<SearchWeatherUI> {
  late TextEditingController controller;
  late SearchWeatherCubit searchWeatherCubit;

  @override
  void initState() {
    controller = TextEditingController();
    searchWeatherCubit = SearchWeatherCubit();
    super.initState();
    // controller.addListener(() {
    //   if (controller.text.isNotEmpty) {
    //     searchWeatherCubit.searchWeather(controller.text);
    //   }
    // });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchWeatherCubit, SearchWeatherState>(
      bloc: searchWeatherCubit,
      builder: (context, state) {
        return Scaffold(
          ///appbar
          appBar: AppBar(
            title: SearchBar(
              controller: controller,
              elevation: const WidgetStatePropertyAll(0),
              hintText: 'Search for a city',
              onSubmitted: (value) {
                searchWeatherCubit.searchWeather(value);
              },
            ),
          ),

          body:

              ///Error State
              state is ErrorSearchWeather
                  ? Center(
                      child: Text(
                        (state).message,
                        style: const TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    )
                  :

                  ///Initial State
                  state is InitialSearchWeather
                      ? const Center(child: Text('Search for a city'))
                      :

                      ///Searched State
                      Card(
                          color: (state as PostSearchedWeather).isSunny
                              ? Colors.yellow
                              : Colors.grey,
                          margin: const EdgeInsets.all(16),
                          child: Container(
                            height: 100,
                            margin: const EdgeInsets.all(16),
                            child: Row(
                              children: [
                                const Icon(
                                  Icons.location_city,
                                ),
                                const SizedBox(width: 16),
                                Text(
                                  (state).city,
                                  style:
                                      Theme.of(context).textTheme.titleMedium,
                                ),
                                const Spacer(),
                                Text(
                                  (state).temperature.toString(),
                                  style: Theme.of(context).textTheme.labelLarge,
                                ),
                                const SizedBox(width: 16),
                                state.isSunny
                                    ? const Icon(Icons.sunny)
                                    : const Icon(Icons.cloud),
                              ],
                            ),
                          ),
                        ),
        );
      },
    );
  }
}
