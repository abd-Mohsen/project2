import 'package:camera/camera.dart';
import 'package:get/get.dart';

import '../main.dart';

class HomeController extends GetxController {
  late CameraController cameraController;
  late Future<void> initializeControllerFuture;

  @override
  void onInit() {
    super.onInit();
    cameraController = CameraController(
      camera,
      ResolutionPreset.high,
    );

    initializeControllerFuture = cameraController.initialize();
  }

  @override
  void dispose() {
    cameraController.dispose();
    super.dispose();
  }
}
