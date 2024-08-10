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
    ScanController sC = Get.put(ScanController());

    return WillPopScope(
      onWillPop: () async {
        Get.delete<ScanController>();
        return true;
      },
      child: Scaffold(
        //backgroundColor: cs.primary,
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
          future: sC.initializeControllerFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return Center(
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    CameraPreview(sC.cameraController),
                    Positioned(
                      bottom: MediaQuery.sizeOf(context).height / 10,
                      child: Center(
                        child: GetBuilder<ScanController>(
                          builder: (con) {
                            return Column(
                              children: [
                                Icon(
                                  Icons.newspaper,
                                  size: 50,
                                  color:
                                      con.detectedObject == "paper" && con.confidence > 0.9 ? Colors.green : Colors.red,
                                ),
                                Text(
                                  "${con.timeTaken}ms",
                                  style: tt.headlineLarge!.copyWith(
                                      color: con.detectedObject == "paper" && con.confidence > 0.9
                                          ? Colors.green
                                          : Colors.red,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  "${con.confidence.toPrecision(2) * 100}%",
                                  style: tt.headlineMedium!.copyWith(
                                      color: con.detectedObject == "paper" && con.confidence > 0.9
                                          ? Colors.green
                                          : Colors.red,
                                      fontWeight: FontWeight.bold),
                                )
                              ],
                            );
                            // return Text(
                            //   con.detectedObject,
                            //   style: tt.headlineLarge!.copyWith(color: cs.secondary, fontWeight: FontWeight.bold),
                            // );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }
            return const Center(child: CircularProgressIndicator());
          },
        ),
        // floatingActionButton: FloatingActionButton(
        //   child: Icon(Icons.camera_alt),
        //   onPressed: () async {
        //     try {
        //       // await controller.initializeControllerFuture;
        //       // final image = await controller.cameraController.takePicture();
        //       // Get.to(DisplayPictureScreen(imagePath: image.path));
        //       controller.takePic();
        //     } catch (e) {
        //       print(e);
        //     }
        //   },
        // ),
      ),
    );
  }
}
