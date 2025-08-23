import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'weather.dart';

class WeatherProvider with ChangeNotifier {
  Weather? _weather;
  bool _isLoading = false;
  String? _error;

  Weather? get weather => _weather;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> fetchWeather(double lat, double lon) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    final url = Uri.parse(
      'https://api.open-meteo.com/v1/forecast?latitude=$lat&longitude=$lon&current_weather=true',
    );

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        _weather = Weather.fromJson(data);
      } else {
        _error = "Gagal memuat data(status: ${response.statusCode})";
      }
    } catch (e) {
      _error = "Terjadi kesalahan: $e";
    }

    _isLoading = false;
    notifyListeners();
  }
}
