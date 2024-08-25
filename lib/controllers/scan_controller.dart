import 'package:camera/camera.dart';
import 'package:get/get.dart';
import 'package:tflite_v2/tflite_v2.dart';
import '../main.dart';

class ScanController extends GetxController {
  late CameraController cameraController;
  late Future<void> initializeControllerFuture;
  late CameraImage currentFrame; // Variable to store the current frame
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
    print("frames is ${capturedImage.width} * ${capturedImage.height} ");
    print(results);
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

  //todo: image picker, take photo and scan request

  @override
  void dispose() {
    //todo: camera and tflite arent disposing with scan controller
    Tflite.close();
    cameraController.dispose();
    cameraController.stopImageStream();
    super.dispose();
  }
}
