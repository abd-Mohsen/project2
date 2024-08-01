import 'dart:io';
import 'dart:typed_data';
import 'package:path_provider/path_provider.dart';
import 'package:image/image.dart' as img;
import 'package:camera/camera.dart';
import 'package:get/get.dart';
import 'package:tflite/tflite.dart';
import '../main.dart';
import 'package:opencv_4/opencv_4.dart';

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
        Tflite.loadModel(model: "assets/paper_model.tflite");
      });
    });
  }

  void processImage(CameraImage image) async {
    CameraImage? input = (await preprocessCameraImage(image));
    if (input == null) print("null?");
    // Run the model on the image
    List? results = await Tflite.runModelOnFrame(
      bytesList: input!.planes.map((plane) {
        return plane.bytes;
      }).toList(),
      imageHeight: image.height,
      imageWidth: image.width,
      numResults: 1,
    );

    // Handle the results
    if (results != null && results.isNotEmpty) {
      var isPaper = results[0]["label"] == "paper";
      if (isPaper) {
        print("Paper detected");
      } else {
        print("No paper detected");
      }
    }
  }

  // Future<String> saveCameraImageToFile(CameraImage image) async {
  //   // Convert CameraImage to Image package's Image object
  //   img.Image imageBuffer = img.Image.fromBytes(
  //     image.width,
  //     image.height,
  //     image.planes[0].bytes,
  //     format: img.Format.bgra, // or img.Format.rgb, depending on your format
  //   );
  //
  //   // Encode Image object to PNG
  //   Uint8List pngBytes = Uint8List.fromList(img.encodePng(imageBuffer));
  //
  //   // Get temporary directory
  //   final Directory tempDir = await getTemporaryDirectory();
  //
  //   // Create a file path
  //   final String filePath = '${tempDir.path}/temp_image.png';
  //
  //   // Write PNG bytes to the file
  //   File file = File(filePath);
  //   await file.writeAsBytes(pngBytes);
  //
  //   return filePath;
  // }

  Future<CameraImage?> preprocessCameraImage(CameraImage image) async {
    //Uint8List? result = await Cv2.cvtColor(pathString: , outputType: Cv2.COLOR_BGR2GRAY);
    // Implement the necessary preprocessing here
    // Convert image to the required input tensor format
    // This typically involves resizing, normalizing, etc.
    // Return the processed image as a list of bytes
  }

  @override
  void dispose() {
    cameraController.stopImageStream();
    cameraController.dispose();
    Tflite.close();
    super.dispose();
  }
}
