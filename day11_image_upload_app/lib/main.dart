import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_picker_platform_interface/image_picker_platform_interface.dart';

// Custom delegate untuk desktop
class MyCameraDelegate extends ImagePickerCameraDelegate {
  @override
  Future<XFile?> takePhoto({
    ImagePickerCameraDelegateOptions options =
        const ImagePickerCameraDelegateOptions(),
  }) async {
    // 👉 di sini kamu bisa integrasikan dengan package camera,
    // atau sementara return null untuk dummy
    debugPrint("Desktop camera not implemented, returning null");
    return null;
  }

  @override
  Future<XFile?> takeVideo({
    ImagePickerCameraDelegateOptions options =
        const ImagePickerCameraDelegateOptions(),
  }) async {
    // sama seperti di atas
    debugPrint("Desktop video not implemented, returning null");
    return null;
  }
}

void setUpCameraDelegate() {
  final ImagePickerPlatform instance = ImagePickerPlatform.instance;
  if (instance is CameraDelegatingImagePickerPlatform) {
    instance.cameraDelegate = MyCameraDelegate();
  }
}

class ImageProviderNotifier with ChangeNotifier {
  File? _selectedImage;
  bool _isUploading = false;

  File? get selectedImage => _selectedImage;
  bool get isUploading => _isUploading;

  Future<void> pickImage(ImageSource source) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: source);

    if (pickedFile != null) {
      _selectedImage = File(pickedFile.path);
      notifyListeners();
    }
  }

  Future<void> uploadImage() async {
    if (_selectedImage == null) return;

    _isUploading = true;
    notifyListeners();

    await Future.delayed(const Duration(seconds: 3));

    _isUploading = false;
    notifyListeners();
  }

  void clearImage() {
    _selectedImage = null;
    notifyListeners();
  }
}

void main() {
  setUpCameraDelegate();

  runApp(
    ChangeNotifierProvider(
      create: (_) => ImageProviderNotifier(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Image Upload App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final imageProvider = context.watch<ImageProviderNotifier>();

    return Scaffold(
      appBar: AppBar(title: const Text("Image Picker + Upload Simulation")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (imageProvider.selectedImage != null)
              SizedBox(
                height: 200,
                child: Image.file(imageProvider.selectedImage!),
              )
            else
              const Icon(Icons.image, size: 120, color: Colors.grey),
            const SizedBox(height: 20),

            if (imageProvider.isUploading)
              const Column(
                children: [
                  CircularProgressIndicator(),
                  SizedBox(height: 19),
                  Text("uploading..."),
                ],
              ),
            const SizedBox(height: 20),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton.icon(
                  icon: const Icon(Icons.photo),
                  label: const Text("Galeri"),
                  onPressed: () => context
                      .read<ImageProviderNotifier>()
                      .pickImage(ImageSource.gallery),
                ),
                const SizedBox(width: 10),
                ElevatedButton.icon(
                  icon: const Icon(Icons.camera),
                  label: const Text("Kamera"),
                  onPressed: () => context
                      .read<ImageProviderNotifier>()
                      .pickImage(ImageSource.camera),
                ),
              ],
            ),

            const SizedBox(height: 20),

            if (imageProvider.selectedImage != null &&
                !imageProvider.isUploading)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () =>
                        context.read<ImageProviderNotifier>().uploadImage(),
                    child: const Text("Upload"),
                  ),
                  const SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: () =>
                        context.read<ImageProviderNotifier>().clearImage(),
                    child: const Text("Reset"),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
