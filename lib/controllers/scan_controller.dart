import 'package:image/image.dart' as img;
import 'package:camera/camera.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:tflite_v2/tflite_v2.dart';
import '../main.dart';
import 'dart:io';

class ScanController extends GetxController {
  //todo: recording even in home screen, make a separate controller for scanning?
  late CameraController cameraController;
  late Future<void> initializeControllerFuture;
  late CameraImage currentFrame; // Variable to store the current frame
  int frames = 1;
  String detectedObject = "";

  @override
  void onInit() async {
    //await initializeControllerFuture;
    Tflite.loadModel(
      model: "assets/models/object_detection.tflite",
      labels: "assets/models/object_detection.txt",
    );
    cameraController = CameraController(
      camera,
      ResolutionPreset.high,
      enableAudio: false,
    );
    initializeControllerFuture = cameraController.initialize().then((_) {
      cameraController.startImageStream((CameraImage image) {
        //currentFrame = image;
        if (frames % 45 == 0) processImage(image);
        //print("planes in the captured image " + image.planes.length.toString());
        frames++;
      });
    });

    super.onInit();
  }

  void takePic() async {
    print("=========================================================");
    await initializeControllerFuture;
    XFile imageFile = await cameraController.takePicture();
    File file = File(imageFile.path);
    img.Image? image = img.decodeImage(await file.readAsBytes());

    // Resize and preprocess the image to match model input
    img.Image resizedImage = img.copyResize(image!, width: 300, height: 400);

    final Directory tempDir = await getTemporaryDirectory();
    String tempPath = '${tempDir.path}/temp_image.jpg';
    File resizedFile = File(tempPath)..writeAsBytesSync(img.encodeJpg(resizedImage));
    List? results = await Tflite.runModelOnImage(
      path: resizedFile.path,
      numResults: 1,
    );
    print("=========================================================");
    print(results);
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

    print(results);
    detectedObject = results![0]["label"];
    // if (results != null && results.isNotEmpty) {
    //   var isPaper = results[0]["label"] == 1;
    //   if (isPaper) {
    //     Get.snackbar("paper detected", DateTime.now().toIso8601String());
    //   }
    // } else {
    //   print("no result");
    // }
    int endTime = DateTime.now().millisecondsSinceEpoch;
    print("Inference took ${endTime - startTime}ms");
    update();
  }

  List<List<List<double>>> expandDims(List<List<double>> imgNormalized) {
    int height = imgNormalized.length;
    int width = imgNormalized[0].length;

    // Create a new list with dimensions (1, height, width, 1)
    List<List<List<double>>> imgExpanded = List.generate(
      1,
      (_) => List.generate(height, (_) => List.generate(width, (_) => 0.0, growable: false), growable: false),
      growable: false,
    );

    for (int i = 0; i < height; i++) {
      for (int j = 0; j < width; j++) {
        imgExpanded[0][i][j] = imgNormalized[i][j];
      }
    }

    return imgExpanded;
  }

  img.Image processCameraImage(CameraImage savedImage, int newWidth, int newHeight) {
    // Convert CameraImage to image package's Image
    // img.Image? resizedImage = ProcessingCameraImage().processCameraImageToRGB(
    //   bytesPerPixelPlan1: savedImage.planes[1].bytesPerPixel,
    //   bytesPerRowPlane0: savedImage.planes[0].bytesPerRow,
    //   bytesPerRowPlane1: savedImage.planes[1].bytesPerRow,
    //   height: newHeight,
    //   plane0: savedImage.planes[0].bytes,
    //   plane1: savedImage.planes[1].bytes,
    //   plane2: savedImage.planes[2].bytes,
    //   // rotationAngle: 15,
    //   width: newWidth,
    //   // isFlipHoriozntal: true,
    //   // isFlipVectical: true,
    // );

    img.Image image = img.Image.fromBytes(
      width: savedImage.planes[0].width!,
      height: savedImage.planes[0].height!,
      bytes: savedImage.planes[0].bytes.buffer,
      format: img.Format.uint8,
    );

    img.Image resizedImage = img.copyResize(image, width: newWidth, height: newHeight);
    img.Image grayscaleImage = img.grayscale(resizedImage);

    for (int y = 0; y < newHeight; y++) {
      for (int x = 0; x < newWidth; x++) {
        img.Pixel pixel = grayscaleImage.getPixel(x, y);
        num grayscaleValue = pixel.r;
        pixel.setRgb(grayscaleValue / 255.0, grayscaleValue / 255.0, grayscaleValue / 255.0);
      }
    }
    return grayscaleImage;
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
