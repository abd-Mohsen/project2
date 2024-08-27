import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:project2/services/local_services/exam_selection_service.dart';
import 'package:project2/services/remote_services/scan_service.dart';
import 'package:tflite_v2/tflite_v2.dart';
import '../main.dart';
//import 'dart:io';

class ScanController extends GetxController {
  ScanController({required this.scanService, required this.examSelectionService});

  late ScanService scanService;
  late ExamSelectionService examSelectionService;

  late CameraController cameraController;
  late Future<void> initializeControllerFuture;
  late CameraImage currentFrame;

  int frames = 1;
  String detectedObject = "";
  double confidence = 0.0;
  int timeTaken = 0;

  @override
  void onInit() async {
    Tflite.loadModel(
      model: "assets/paper_model2.tflite",
      labels: "assets/paper_model2.txt",
      useGpuDelegate: false,
    );
    cameraController = CameraController(
      cameras[0],
      ResolutionPreset.medium,
      enableAudio: false,
      //imageFormatGroup: ImageFormatGroup.jpeg,
    );
    initializeControllerFuture = cameraController.initialize().then((_) {
      //if (!mounted) return;
      cameraController.startImageStream((CameraImage image) {
        if (frames % 20 == 0) processImage(image);
        frames++;
        currentFrame = image;
        //
        if (frames > 1e6) frames = 0;
      });
    });

    super.onInit();
  }

  void processImage(CameraImage capturedImage) async {
    int startTime = DateTime.now().millisecondsSinceEpoch;
    //img.Image input = (processCameraImage(capturedImage, 300, 400));
    List? results = await Tflite.runModelOnFrame(
      bytesList: capturedImage.planes.map((plane) {
        return plane.bytes;
      }).toList(),
      imageHeight: capturedImage.height,
      imageWidth: capturedImage.width,
      numResults: 1,
    );
    // print("frames is ${capturedImage.width} * ${capturedImage.height} ");
    // print(results);
    detectedObject = results![0]["label"];
    confidence = results[0]["confidence"];
    int endTime = DateTime.now().millisecondsSinceEpoch;
    timeTaken = endTime - startTime;
    update();
  }

  bool debug = false;
  void toggleDebugVisibility() {
    debug = !debug;
    update();
  }

  Future pickImage() async {
    XFile? selectedImage = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (selectedImage == null) {
      Get.snackbar("error", "no image has been selected");
      return;
    }
    scanPaper(selectedImage);
  }

  void takeImage() async {
    //todo: solve: phone must stay on paper while correcting in backend
    XFile takenImage = await cameraController.takePicture();
    scanPaper(takenImage);
  }

  void scanPaper(XFile paperImage) async {
    //File file = File(paperImage.path);
    int examID = examSelectionService.loadSelectedExamId();
    if (examID == -1) Get.snackbar("warning", "select exam first", backgroundColor: Colors.yellow);
    //todo make selected exam -1 when deleting the selected exam
    int? res = await scanService.scanPaper(paperImage, examID);
    if (res == null) {
      Get.snackbar("error", "couldn't scan", backgroundColor: Colors.yellow);
      return;
    } else {
      Get.defaultDialog(title: "your result", middleText: res.toString());
      print(res.toString());
    }
  }

  @override
  void dispose() {
    //todo: camera and tflite arent disposing with scan controller
    Tflite.close();
    cameraController.dispose();
    cameraController.stopImageStream();
    super.dispose();
  }
}
