import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project2/controllers/home_controller.dart';
import 'display_picture_screen.dart';

class ScanView extends StatelessWidget {
  const ScanView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      builder: (controller) => Scaffold(
        appBar: AppBar(title: Text('scan paper'.tr)),
        body: FutureBuilder<void>(
          future: controller.initializeControllerFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return CameraPreview(controller.cameraController);
            } else {
              return Center(child: CircularProgressIndicator());
            }
          },
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.camera_alt),
          onPressed: () async {
            try {
              await controller.initializeControllerFuture;
              final image = await controller.cameraController.takePicture();
              Get.to(DisplayPictureScreen(imagePath: image.path));
            } catch (e) {
              print(e);
            }
          },
        ),
      ),
    );
  }
}
