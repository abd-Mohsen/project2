import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project2/constants.dart';
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
        //todo: show button when it is paper (try to use full res image and downsize it)
        //backgroundColor: cs.primary,
        appBar: AppBar(
          title: Text('scan paper'.tr),
          backgroundColor: kAppBarColor,
          actions: [
            IconButton(
              onPressed: () {
                sC.toggleDebugVisibility();
              },
              icon: Icon(Icons.video_label),
            )
          ],
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
              return Column(
                children: [
                  Expanded(
                    flex: 3,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        CameraPreview(sC.cameraController),
                        Positioned(
                          bottom: MediaQuery.sizeOf(context).height / 10,
                          child: Center(
                            child: GetBuilder<ScanController>(
                              builder: (con) {
                                return Visibility(
                                  visible: con.debug,
                                  child: Column(
                                    children: [
                                      Text(
                                        "${con.timeTaken}ms",
                                        style: tt.headlineLarge!.copyWith(
                                            color: con.detectedObject == "paper" && con.confidence > 0.99
                                                ? Colors.green
                                                : Colors.red,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        "${con.confidence.toPrecision(2) * 100}%",
                                        style: tt.headlineMedium!.copyWith(
                                            color: con.detectedObject == "paper" && con.confidence > 0.99
                                                ? Colors.green
                                                : Colors.red,
                                            fontWeight: FontWeight.bold),
                                      )
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 3,
                            child: GetBuilder<ScanController>(
                              builder: (con) {
                                return GestureDetector(
                                  onTap: con.detectedObject == "paper" && con.confidence > 0.99
                                      ? () {
                                          //
                                        }
                                      : null,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: con.detectedObject == "paper" && con.confidence > 0.99
                                          ? cs.secondary
                                          : Colors.grey,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(vertical: 16),
                                      child: Icon(
                                        Icons.camera,
                                        color: cs.onSecondary,
                                        size: 30,
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                color: cs.secondary,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(vertical: 16),
                                child: Icon(
                                  Icons.photo,
                                  color: cs.onSecondary,
                                  size: 30,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
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
