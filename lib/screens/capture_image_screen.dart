import 'dart:io';
import 'dart:math';
import 'package:camera/camera.dart';
import 'package:citizen_watch/constants/app_state.dart';
import 'package:citizen_watch/screens/report_screen.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

class CaptureImageScreen extends StatefulWidget {
  final CameraDescription camera;

  const CaptureImageScreen({this.camera});

  @override
  _CaptureImageScreenState createState() => _CaptureImageScreenState();
}

class _CaptureImageScreenState extends State<CaptureImageScreen> {
  CameraController _controller;
  Future<void> _initializeControllerFuture;

  @override
  void initState() {
    super.initState();
    _controller = CameraController(
      widget.camera,
      ResolutionPreset.high,
    );

    _initializeControllerFuture = _controller.initialize();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String capturedImageUrl = "";
    String imgUrl = generateRandomNumber();
    final size = MediaQuery.of(context).size;
    final deviceRatio = size.width / size.height;
    final appState = Provider.of<AppState>(context);
    return Scaffold(
      body: FutureBuilder<void>(
        future: _initializeControllerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Transform.scale(
              scale: _controller.value.aspectRatio / deviceRatio + 0.14,
              child: Center(
                child: AspectRatio(
                    aspectRatio: _controller.value.aspectRatio,
                    child: CameraPreview(_controller)),
              ),
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black,
        child: Icon(
          Icons.camera_alt,
          color: Colors.white,
        ),
        onPressed: () async {
          appState.setIsRequestRunning(true);
          try {
            await _initializeControllerFuture;

            final path = join(
              (await getTemporaryDirectory()).path,
              '${DateTime.now()}.png',
            );

            await _controller.takePicture(path);

            FirebaseStorage storage = FirebaseStorage(
                storageBucket: 'gs://citizen-watch-f823c.appspot.com');
            StorageReference storageReference = storage.ref();
            StorageReference imageReference =
                storageReference.child('image$imgUrl/image.jpg');
            StorageUploadTask storageUploadTask =
                imageReference.putFile(File(path));

            await (await storageUploadTask.onComplete)
                .ref
                .getDownloadURL()
                .then((url) {
              setState(() {
                capturedImageUrl = url;
              });
            });
            appState.setIsRequestRunning(false);
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => ReportScreen(
                  imagePath: capturedImageUrl,
                  camera: widget.camera,
                ),
              ),
            );
          } catch (e) {}
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  String generateRandomNumber() {
    var random = Random();
    String imgUrl = '';
    for (int i = 0; i < 10; i++) {
      imgUrl = imgUrl + random.nextInt(100).toString();
    }
    return imgUrl;
  }
}
