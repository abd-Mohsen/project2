import 'package:camera/camera.dart';
import 'package:get/get.dart';

import '../main.dart';

class HomeController extends GetxController {
  //todo: recording even in home screen, make a separate controller for scanning?
  late CameraController cameraController;
  late Future<void> initializeControllerFuture;
  late CameraImage currentFrame; // Variable to store the current frame

  @override
  void onInit() {
    super.onInit();
    cameraController = CameraController(
      camera,
      ResolutionPreset.high,
      enableAudio: false,
    );

    initializeControllerFuture = cameraController.initialize().then((_) {
      cameraController.startImageStream((CameraImage image) {
        currentFrame = image;
        //check if paper
      });
    });

    //currentFrame = Rx<CameraImage?>(null);
  }

  @override
  void dispose() {
    cameraController.stopImageStream();
    cameraController.dispose();
    super.dispose();
  }
}
