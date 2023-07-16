import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<String> myList = [];
  bool showAdditionalText = false;
  bool showstatus = false;
  late File selectImageFile;
  TextEditingController controller = TextEditingController();
  void navigateToAnotherScreen() async {
    final result =
        await Navigator.pushNamed(context, '/widget_add', arguments: myList);
    if (result != null && result is List<String>) {
      setState(() {
        myList = result;
        print(myList);
      });
    }
  }

  Future<void> _pickImageFromGallery() async {
    final ImagePicker _picker = ImagePicker();
    XFile? image = await _picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      selectImageFile = File(image.path);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Assignment App",
          style: TextStyle(color: Colors.black, fontSize: 20),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              SizedBox(
                height: 570,
                width: double.infinity,
                child: Container(
                  child: Card(
                    color: const Color.fromARGB(255, 218, 238, 218),
                    child: myList.isEmpty
                        ? const Center(
                            child: Text(
                              "No Widgets is Added",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20),
                            ),
                          )
                        : Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              if (myList.contains("Text Widget"))
                                Container(
                                  margin:
                                      const EdgeInsets.fromLTRB(20, 50, 20, 50),
                                  height: 30,
                                  decoration: const BoxDecoration(
                                    color: Colors.grey,
                                  ),
                                  child: TextFormField(
                                    controller: controller,
                                    decoration: const InputDecoration(
                                      hintText: 'Enter Text',
                                    ),
                                  ),
                                ),
                              const SizedBox(
                                height: 10,
                              ),
                              if (myList.contains("Image Widget"))
                                Container(
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 20),
                                  height: 250,
                                  decoration:
                                      const BoxDecoration(color: Colors.grey),
                                  child: Center(
                                      child: InkWell(
                                    onTap: () {
                                      _pickImageFromGallery();
                                    },
                                    child: selectImageFile == null
                                        ? Text("Upload Image")
                                        : Image.file(selectImageFile),
                                  )),
                                ),
                              const SizedBox(
                                height: 20,
                              ),
                              if (showAdditionalText)
                                const Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 20),
                                  child: Text(
                                    "Add at-least a widget to Save",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 25),
                                  ),
                                ),
                              const SizedBox(
                                height: 20,
                              ),
                              if (myList.contains("Button Widget"))
                                ElevatedButton(
                                  onPressed: () {
                                    if (myList.contains("Button Widget") &&
                                        !myList.contains("Image Widget") &&
                                        !myList.contains("Text Widget")) {
                                      setState(() {
                                        showAdditionalText = true;
                                      });
                                    } else {
                                      setState(() {
                                        CollectionReference usersCollection =
                                            FirebaseFirestore.instance
                                                .collection('users');
                                        Future<void> adddata() {
                                          return usersCollection.add({
                                            'text': controller.text,
                                            'image': selectImageFile,
                                          });
                                        }

                                        showstatus = true;
                                      });
                                    }
                                  },
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.green,
                                      side: const BorderSide(
                                          color: Colors.black)),
                                  child: const Text(
                                    "Save",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                            ],
                          ),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                height: 50,
                width: 150,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.greenAccent),
                child: Center(
                  child: InkWell(
                    child: const Text("Add Widget"),
                    onTap: () {
                      setState(() {
                        showAdditionalText = false;
                        showstatus = false;
                      });
                      navigateToAnotherScreen();
                    },
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              if (showstatus)
                Container(
                  height: 40,
                  width: double.infinity,
                  decoration: const BoxDecoration(color: Colors.green),
                  child: const Center(
                      child: Text(
                    "SuccessFully Saved",
                    style: TextStyle(color: Colors.black, fontSize: 20),
                  )),
                )
            ],
          ),
        ),
      ),
    );
  }
}
