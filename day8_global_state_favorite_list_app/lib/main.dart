import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FavoritesProvider extends ChangeNotifier {
  final List<String> _favorites = [];

  List<String> get favorites => _favorites;

  void toggleFavorite(String item) {
    if (_favorites.contains(item)) {
      _favorites.remove(item);
    } else {
      _favorites.add(item);
    }
    notifyListeners();
  }

  bool isFavorite(String item) => _favorites.contains(item);
}

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => FavoritesProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Favorites App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MoviesPage(),
    );
  }
}

class MoviesPage extends StatelessWidget {
  const MoviesPage({super.key});

  final movies = const ["Inception", "Interstellar", "Tenet", "Dunkirk"];

  @override
  Widget build(BuildContext context) {
    final favorites = context.watch<FavoritesProvider>();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Movies"),
        actions: [
          IconButton(
            icon: const Icon(Icons.favorite),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const FavoritesPage()),
            ),
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: movies.length,
        itemBuilder: (ctx, index) {
          final movie = movies[index];
          final isFav = favorites.isFavorite(movie);

          return ListTile(
            title: Text(movie),
            trailing: IconButton(
              onPressed: () => favorites.toggleFavorite(movie),
              icon: Icon(
                isFav ? Icons.favorite : Icons.favorite_border,
                color: isFav ? Colors.red : null,
              ),
            ),
          );
        },
      ),
    );
  }
}

class FavoritesPage extends StatelessWidget {
  const FavoritesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final favorites = context.watch<FavoritesProvider>().favorites;

    return Scaffold(
      appBar: AppBar(title: const Text("My Favorites")),
      body: favorites.isEmpty
          ? const Center(child: Text("No favorites yet"))
          : ListView(
              children: favorites
                  .map((movie) => ListTile(title: Text(movie)))
                  .toList(),
            ),
    );
  }
}
