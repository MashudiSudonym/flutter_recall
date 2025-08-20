import 'dart:convert';
import 'package:http/http.dart' as http;
import 'country.dart';

class CountryService {
  static Future<List<Country>> fetchCountries() async {
    final url = Uri.parse("https://restcountries.com/v3.1/all");
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final List data = jsonDecode(response.body);

      return data.map((json) => Country.fromJson(json)).toList();
    } else {
      throw Exception("Failed to load countries");
    }
  }
}
