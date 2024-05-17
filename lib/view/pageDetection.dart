// ignore_for_file: unused_local_variable, prefer_const_constructors

import 'dart:io';
import 'package:get/get.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tflite/flutter_tflite.dart';
import 'package:image_picker/image_picker.dart';

class TfliteModel extends StatefulWidget {
  const TfliteModel({Key? key}) : super(key: key);

  @override
  _TfliteModelState createState() => _TfliteModelState();
}

class _TfliteModelState extends State<TfliteModel> {
  File? _image;
  List? _results;
  bool imageSelect = false;

  @override
  void initState() {
    super.initState();
    loadModel();
  }

  Future<void> loadModel() async {
    Tflite.close();
    String res;
    res = (await Tflite.loadModel(
        model: "assets/model.tflite", labels: "assets/Labels.txt"))!;
    print("Models loading status: $res");
  }

  Future<void> imageClassification(File image) async {
    final List? recognitions = await Tflite.runModelOnImage(
      path: image.path,
      numResults: 6,
      threshold: 0.05,
      imageMean: 127.5,
      imageStd: 127.5,
    );
    setState(() {
      _results = recognitions;
      _image = image;
      imageSelect = true;
    });
  }

  Future<void> pickImage(ImageSource imageType) async {
    final photo = await ImagePicker().pickImage(source: imageType);
    if (photo == null) return;
    var imageFile = File(photo.path);
    setState(() {
      _image = imageFile;
    });
    imageClassification(imageFile); // Classify the image after picking it
  }

  void imagePickerOption() {
    Get.bottomSheet(
      SingleChildScrollView(
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(10.0),
            topRight: Radius.circular(10.0),
          ),
          child: Container(
            color: Colors.white,
            height: 250,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Text(
                    "Choisissez une source",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 108, 160, 220),
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton.icon(
                    onPressed: () {
                      pickImage(ImageSource.camera);
                    },
                    icon: const Icon(Icons.camera, color: Colors.white),
                    label: const Text(
                      "Camera",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.normal,
                        color: Colors.white,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 135, 206, 235),
                      minimumSize: const Size(200, 55),
                    ),
                  ),
                  const Spacer(),
                  ElevatedButton.icon(
                    onPressed: () {
                      pickImage(ImageSource.gallery);
                    },
                    icon: const Icon(Icons.image, color: Colors.white),
                    label: const Text(
                      "Gallery",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.normal,
                        color: Colors.white,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 135, 206, 235),
                      minimumSize: const Size(200, 55),
                    ),
                  ),
                  const Spacer(),
                  const SizedBox(height: 10),
                  ElevatedButton.icon(
                    onPressed: () {
                      Get.back();
                    },
                    icon: const Icon(Icons.close, color: Colors.white),
                    label: const Text(
                      "Cancel",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.normal,
                        color: Colors.white,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 135, 206, 235),
                      minimumSize: const Size(200, 55),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: const Color.fromARGB(255, 135, 206, 235),
          elevation: 0,
          title: Column(
            children: const [
              SizedBox(height: 2),
              Text(
                "EpidermoScan",
                style: TextStyle(color: Colors.white),
              ),
            ],
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(top: screenHeight * 0.01),
            child: Column(
              children: [
                Container(
                  height: 100,
                  width: 100,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: Image.asset(
                    "assets/logo/logo_5.jpg",
                    height: 500,
                    width: 500,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(height: screenHeight * 0.01),
                const Text(
                  "Pret à vérifier votre peau !",
                  style: TextStyle(
                    color: Color.fromARGB(255, 135, 206, 235),
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(height: 10),
                    Align(
                      alignment: Alignment.center,
                      child: Stack(
                        children: [
                          Card(
                            elevation: 20,
                            clipBehavior: Clip.hardEdge,
                            child: SizedBox(
                              width: 300,
                              child: SingleChildScrollView(
                                child: Column(
                                  children: [
                                    const SizedBox(height: 18),
                                    if (imageSelect)
                                      Container(
                                        padding:
                                            const EdgeInsets.only(bottom: 10),
                                        width: 250,
                                        height: 250,
                                        child: ClipPath(
                                          child: Padding(
                                            padding: EdgeInsets.only(
                                                top: screenHeight * 0.0001),
                                            child: _image != null
                                                ? Image.file(
                                                    _image!,
                                                    width: 250,
                                                    height: 250,
                                                    fit: BoxFit.cover,
                                                  )
                                                : Image.asset(
                                                    "assets/onboarding/onboarding_8.png",
                                                    width: 250,
                                                    height: 250,
                                                    fit: BoxFit.cover,
                                                  ),
                                          ),
                                        ),
                                      ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    if (imageSelect)
                                      SingleChildScrollView(
                                        child: Column(
                                          children: _results?.map((result) {
                                                return Card(
                                                  child: Container(
                                                    margin:
                                                        const EdgeInsets.all(
                                                            10),
                                                    child: Text(
                                                      "${result['label']} : ${(result['confidence'] * 100).toStringAsFixed(0)}%",
                                                      style: const TextStyle(
                                                          color: Color.fromARGB(
                                                              255,
                                                              54,
                                                              174,
                                                              244),
                                                          fontSize: 20),
                                                    ),
                                                  ),
                                                );
                                              }).toList() ??
                                              [],
                                        ),
                                      ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton.icon(
                    onPressed: imagePickerOption,
                    icon: const Icon(
                      Icons.add_a_photo_sharp,
                      color: Colors.white,
                    ),
                    label: const Text(
                      'Prendre une photo',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.normal,
                        color: Colors.white,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 135, 206, 235),
                      minimumSize: const Size(200, 55),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
