import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gallery Photo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const PhotoGallery(),
    );
  }
}

class PhotoGallery extends StatelessWidget {
  const PhotoGallery({super.key});

  final List<String> assetImages = const [
    'assets/images/1.jpg',
    'assets/images/2.jpg',
    'assets/images/3.jpg',
  ];

  final List<String> networkImages = const [
    'https://picsum.photos/200/300?random=1',
    'https://picsum.photos/200/300?random=2',
    'https://picsum.photos/200/300?random=3',
  ];

  @override
  Widget build(BuildContext context) {
    final allImages = [...assetImages, ...networkImages];

    return Scaffold(
      appBar: AppBar(title: const Text('Gallery Photo')),
      body: GridView.builder(
        padding: const EdgeInsets.all(10),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        itemCount: allImages.length,
        itemBuilder: (BuildContext context, int index) {
          final imagePath = allImages[index];
          final isNetwork = imagePath.startsWith('http');

          return Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              image: DecorationImage(
                image: isNetwork
                    ? NetworkImage(imagePath)
                    : AssetImage(imagePath) as ImageProvider,
                fit: BoxFit.cover,
              ),
            ),
          );
        },
      ),
    );
  }
}
