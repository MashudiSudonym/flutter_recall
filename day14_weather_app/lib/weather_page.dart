import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'weather_provider.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  final _latController = TextEditingController(text: "-6.2"); // default Jakarta
  final _lonController = TextEditingController(text: "106.8");

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<WeatherProvider>();

    return Scaffold(
      appBar: AppBar(title: const Text("Weather App")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _latController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: "Latitude"),
            ),
            TextField(
              controller: _lonController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: "Longitude"),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                final lat = double.tryParse(_latController.text);
                final lon = double.tryParse(_lonController.text);
                if (lat != null && lon != null) {
                  context.read<WeatherProvider>().fetchWeather(lat, lon);
                }
              },
              child: const Text("Cek Cuaca"),
            ),
            const SizedBox(height: 20),

            if (provider.isLoading) const CircularProgressIndicator(),
            if (provider.error != null)
              Text(provider.error!, style: const TextStyle(color: Colors.red)),
            if (provider.weather != null)
              Card(
                margin: const EdgeInsets.all(16),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      Text(
                        "Suhu: ${provider.weather!.temperature}°C",
                        style: const TextStyle(fontSize: 20),
                      ),
                      Text("Angin: ${provider.weather!.windspeed} km/h"),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
