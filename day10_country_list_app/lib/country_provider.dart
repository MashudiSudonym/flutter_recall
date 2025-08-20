import 'package:flutter/material.dart';

import 'country.dart';
import 'country_service.dart';

class CountryProvider with ChangeNotifier {
  List<Country> _countries = [];
  List<Country> _filtered = [];
  bool _isLoading = false;
  String _error = "";

  List<Country> get countries => _filtered;
  bool get isLoading => _isLoading;
  String get error => _error;

  Future<void> fetchCountries() async {
    _isLoading = true;
    _error = "";
    notifyListeners();

    try {
      final list = await CountryService.fetchCountries();
      _countries = list;
      _filtered = list;
    } catch (e) {
      _error = e.toString();
    }

    _isLoading = false;
    notifyListeners();
  }

  void filterCountries(String keyword) {
    if (keyword.isEmpty) {
      _filtered = _countries;
    } else {
      _filtered = _countries
          .where((c) => c.name.toLowerCase().contains(keyword.toLowerCase()))
          .toList();
    }
    notifyListeners();
  }
}
