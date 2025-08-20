import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'country_provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => CountryProvider()..fetchCountries(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const CountryPage(),
    );
  }
}

class CountryPage extends StatelessWidget {
  const CountryPage({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<CountryProvider>();
    return Scaffold(
      appBar: AppBar(title: const Text("Countries")),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsetsGeometry.all(8),
            child: TextField(
              decoration: const InputDecoration(
                labelText: 'Search Country',
                border: OutlineInputBorder(),
              ),
              onChanged: provider.filterCountries,
            ),
          ),
          Expanded(
            child: Builder(
              builder: (context) {
                if (provider.isLoading) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (provider.error.isNotEmpty) {
                  return Center(child: Text("Error: ${provider.error}"));
                }
                if (provider.countries.isNotEmpty) {
                  return const Center(child: Text("No Countries Page"));
                }

                return ListView.builder(
                  itemCount: provider.countries.length,
                  itemBuilder: (context, index) {
                    final country = provider.countries[index];

                    return ListTile(
                      leading: Image.network(
                        country.flagUrl,
                        width: 40,
                        height: 30,
                        fit: BoxFit.cover,
                      ),
                      title: Text(country.name),
                      subtitle: Text(country.region),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
