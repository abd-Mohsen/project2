import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project2/controllers/scan_controller.dart';

class ScanView extends StatelessWidget {
  const ScanView({super.key});

  @override
  Widget build(BuildContext context) {
    ColorScheme cs = Theme.of(context).colorScheme;
    TextTheme tt = Theme.of(context).textTheme;

    return WillPopScope(
      onWillPop: () async {
        Get.delete<ScanController>();
        return true;
      },
      child: GetBuilder<ScanController>(
        init: ScanController(),
        builder: (controller) => Scaffold(
          appBar: AppBar(
            title: Text('scan paper'.tr),
            leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Get.delete<ScanController>();
                Get.back();
              },
            ),
          ),
          body: FutureBuilder<void>(
            future: controller.initializeControllerFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return Column(
                  children: [
                    Expanded(
                      flex: 7,
                      child: CameraPreview(controller.cameraController),
                    ),
                    Expanded(
                      flex: 1,
                      child: GetBuilder<ScanController>(
                        builder: (con) {
                          return Text(
                            con.detectedObject,
                            style: tt.headlineLarge!.copyWith(color: cs.secondary, fontWeight: FontWeight.bold),
                          );
                        },
                      ),
                    ),
                  ],
                );
              }
              return Center(child: CircularProgressIndicator());
            },
          ),
          floatingActionButton: FloatingActionButton(
            child: Icon(Icons.camera_alt),
            onPressed: () async {
              try {
                // await controller.initializeControllerFuture;
                // final image = await controller.cameraController.takePicture();
                // Get.to(DisplayPictureScreen(imagePath: image.path));
                controller.takePic();
              } catch (e) {
                print(e);
              }
            },
          ),
        ),
      ),
    );
  }
}
