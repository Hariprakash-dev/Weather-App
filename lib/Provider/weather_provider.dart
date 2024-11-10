import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class WeatherProvider with ChangeNotifier {
  String _temperature = "";
  String _cityName = "";
  String _humidity = "";
  String _description = "";
  String _windspeed = "";
  String _iconCode = "";
  // bool _isLoading = false;

  String get temperature => _temperature;
  String get cityName => _cityName;
  String get humidity => _humidity;
  String get description => _description;
  String get windspeed => _windspeed;
  String get iconCode => _iconCode;
  // bool get isLoading => _isLoading;

  Future<void> fetchWeather(String city) async {
    // _isLoading = true;//start loading
    // notifyListeners(); //notify listerners about loading status
    const apikey = "766253fec1a27ad47179045a17b53d75";
    final url = Uri.parse(
        "https://api.openweathermap.org/data/2.5/weather?q=$city&APPID=$apikey&units=metric");

    try {
      final res = await http.get(url);
      if (res.statusCode == 200) {
        final data = jsonDecode(res.body);
        _temperature = data['main']['temp'].toString();
        _cityName = data['name'];
        _humidity = data['main']['humidity'].toString();
        _description = data['weather'][0]['description'];
        _windspeed = data['wind']['speed'].toString();
        _iconCode = data['weather'][0]['icon'];

        notifyListeners();
      } else {
        throw Exception("Failed to load weather");
      }
    } catch (e) {
      print("Error fetching weather: $e");
      rethrow;
    }
  }
}
