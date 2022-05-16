import 'dart:convert';
import 'package:flutter_weather/components/weather.dart';
import 'package:flutter_weather/screens/location_screen.dart';
import 'location_screen.dart';
import "package:http/http.dart" as http;
import 'package:flutter/material.dart';

class CityScreen extends StatefulWidget {
  static const apiKey = 'b8fa200bcb0ac85c859300673693da59';
  const CityScreen({Key? key}) : super(key: key);

  @override
  _CityScreenState createState() => _CityScreenState();
}

class _CityScreenState extends State<CityScreen> {
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
              icon: const Icon(Icons.search),
              onPressed: () async {
                showSearch(context: context, delegate: CitySearch());
              },
            )
          ],
        ),
      );
}

class CitySearch extends SearchDelegate<String> {
  @override
  List<Widget> buildActions(BuildContext context) => [
        IconButton(
          icon: const Icon(Icons.clear),
          onPressed: () {
            if (query.isEmpty) {
              close(context, '');
            } else {
              query = '';
              showSuggestions(context);
            }
          },
        )
      ];

  @override
  Widget buildLeading(BuildContext context) => IconButton(
      icon: const Icon(Icons.arrow_back), onPressed: () => close(context, ''));

  @override
  Widget buildResults(BuildContext context) => FutureBuilder<String>(
        future: WeatherApi.getWeather(city: query),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return const Center(child: CircularProgressIndicator());
            default:
              if (snapshot.hasError) {
                print('Data is been excetuted ${snapshot.data}');
                return Container(
                  color: Colors.black,
                  alignment: Alignment.center,
                  child: Text(
                    'Something went wrong! ${snapshot.error.toString()}',
                    style: const TextStyle(fontSize: 28, color: Colors.white),
                  ),
                );
              } else {
                return Container();
              }
          }
        },
      );

  @override
  Widget buildSuggestions(BuildContext context) => Container(
        color: Colors.black,
        child: FutureBuilder<List<String>>(
          future: WeatherApi.searchCities(query: query),
          builder: (context, snapshot) {
            if (query.isEmpty) return buildNoSuggestions();

            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return const Center(child: CircularProgressIndicator());
              default:
                if (snapshot.hasError) {
                  return buildNoSuggestions();
                } else {
                  print('Suggesion city has been searched ${snapshot.data}');
                  return buildSuggestionsSuccess(snapshot.data);
                }
            }
          },
        ),
      );

  Widget buildNoSuggestions() => const Center(
        child: Text(
          'No suggestions!',
          style: TextStyle(fontSize: 28, color: Colors.white),
        ),
      );

  Widget buildSuggestionsSuccess(List<String>? suggestions) => ListView.builder(
        itemCount: suggestions!.length,
        itemBuilder: (context, index) {
          final suggestion = suggestions[index];
          final queryText = suggestion.substring(0, query.length);
          final remainingText = suggestion.substring(query.length);
          return ListTile(
            onTap: () {
              query = suggestion;
              showResults(context);
              print('context is $suggestion');
              WeatherModel weatherModel = WeatherModel();
              var weatherData =
                  weatherModel.getCityWeather(suggestion.split(',')[0]);
              Navigator.pop(context);
              Navigator.pop(context, weatherData);
            },
            leading: const Icon(Icons.location_city),
            // title: Text(suggestion),
            title: RichText(
              text: TextSpan(
                text: queryText,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
                children: [
                  TextSpan(
                    text: remainingText,
                    style: const TextStyle(
                      color: Colors.white54,
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      );

  Widget buildResultSuccess(weather) => Container();
  Widget buildDegrees(weather) {
    const style = TextStyle(
      fontSize: 100,
      fontWeight: FontWeight.bold,
      color: Colors.white,
    );

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Opacity(
          opacity: 0,
          child: Text('°', style: style),
        ),
        Text('${weather.degrees}°', style: style),
      ],
    );
  }
}

class WeatherApi {
  static Future<List<String>> searchCities({required String query}) async {
    const limit = 1;
    final url = Uri.parse(
        'https://api.openweathermap.org/geo/1.0/direct?q=$query&limit=$limit&appid=$apiKey');

    final response = await http.get(url);
    final body = json.decode(response.body);

    return body.map<String>((json) {
      final city = json['name'];
      final country = json['country'];
      print(city);
      print(country);
      return '$city, $country';
    }).toList();
  }

  static Future<String> getWeather({required String city}) async {
    final url = Uri.parse(
        'https://api.openweathermap.org/data/2.5/weather?q=$city&units=metric&appid=$apiKey');
    final response = await http.get(url);
    final body = json.decode(response.body);
    final city1 = body['name'];
    print('i am city: $city1');
    return city1;
  }

  Widget buildResultSuccess(LocationScreen weather) => Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF3279e2), Colors.purple],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
      );
}
