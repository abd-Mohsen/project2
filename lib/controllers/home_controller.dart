import 'package:image/image.dart' as img;
import 'package:camera/camera.dart';
import 'package:get/get.dart';
import 'package:tflite/tflite.dart';
import '../main.dart';

class HomeController extends GetxController {
  //todo: recording even in home screen, make a separate controller for scanning?
  late CameraController cameraController;
  late Future<void> initializeControllerFuture;
  late CameraImage currentFrame; // Variable to store the current frame

  @override
  void onInit() async {
    Tflite.loadModel(model: "assets/paper_model.tflite");
    cameraController = CameraController(
      camera,
      ResolutionPreset.high,
      enableAudio: false,
    );

    initializeControllerFuture = cameraController.initialize().then((_) {
      cameraController.startImageStream((CameraImage image) {
        //currentFrame = image;
        processImage(image);
      });
    });

    super.onInit();
  }

  void processImage(CameraImage image) async {
    img.Image input = (processCameraImage(image, 300, 400));
    //if (input == null) print("null?");
    // Run the model on the image
    List? results = await Tflite.runModelOnFrame(
      bytesList: [input.toUint8List()],
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
    cameraController.stopImageStream();
    cameraController.dispose();
    Tflite.close();
    super.dispose();
  }
}
