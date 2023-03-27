import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lottie/lottie.dart';

// const String id = 'Upload';
final storageRef = FirebaseStorage.instance.ref();

class AddFile extends StatefulWidget {
  static String id = "add_file";
  const AddFile({Key? key}) : super(key: key);

  @override
  State<AddFile> createState() => _AddFileState();
}

class _AddFileState extends State<AddFile> {
  final firestore = FirebaseFirestore.instance;
  DateTime selectedDate = DateTime.now();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  String selectedFileName = '';
  String selectedTitle = '';
  String selectedDescription = '';
  String selectedClass = '1';

  late PlatformFile file;
  late UploadTask uploadTask;
  bool showLoading = false;

  Future<void> uploadFile(String storagePath, PlatformFile storageFile) async {
    setState(() {
      showLoading = true;
    });
    final file = File(storageFile.path!);
    uploadTask = storageRef.child(storagePath).putFile(file);
    await uploadTask.whenComplete(() {});
  }

  Future<void> pickFile() async {
    FilePickerResult? pickedFile =
        await FilePicker.platform.pickFiles(type: FileType.any);
    if (pickedFile != null) {
      setState(() {
        file = pickedFile.files.first;
        selectedFileName = file.name;
      });
    }
  }

  void pushData() {
    firestore.collection('assignment').add({
      "class": selectedClass,
      'title': selectedTitle,
      'description': selectedDescription,
      'file_name': selectedFileName,
      "due_date": selectedDate.toIso8601String()
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: (() => Navigator.pop(context)),
          child: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
        title: const Text(
          "Create Diary",
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: ListView(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Class',
                        style: GoogleFonts.montserrat(
                          textStyle: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                            fontSize: 30,
                          ),
                        ),
                      ),
                      DropdownButton(
                        dropdownColor: Colors.white,
                        value: selectedClass,
                        style: GoogleFonts.lato(
                            textStyle: const TextStyle(
                                color: Colors.black, fontSize: 20)),
                        borderRadius: BorderRadius.circular(15),
                        underline: Container(),
                        items: const [
                          DropdownMenuItem(
                            value: "1",
                            child: Text("Class 1"),
                          ),
                          DropdownMenuItem(
                            value: "2",
                            child: Text("Class 2"),
                          ),
                          DropdownMenuItem(
                            value: "3",
                            child: Text("Class 3"),
                          ),
                          DropdownMenuItem(
                            value: "4",
                            child: Text("Class 4"),
                          ),
                        ],
                        onChanged: (String? value) {
                          setState(() {
                            selectedClass = value!;
                          });
                        },
                      )
                    ],
                  ),
                  const SizedBox(height: 30),
                  Text(
                    'Title',
                    style: GoogleFonts.montserrat(
                      textStyle: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                        fontSize: 30,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    child: TextField(
                      style: const TextStyle(color: Colors.black),
                      decoration: InputDecoration(
                        hintText: 'Enter title',
                        labelText: 'Title',
                        labelStyle: TextStyle(color: Colors.purple.shade900),
                        enabledBorder: const OutlineInputBorder(
                            borderSide: BorderSide(
                          color: Colors.black,
                          width: 1.0,
                        )),
                        border: const OutlineInputBorder(
                            borderSide: BorderSide(
                          color: Colors.black,
                          width: 1.0,
                        )),
                        focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide(
                          color: Colors.black,
                          width: 1.0,
                        )),
                      ),
                      onChanged: (String title) {
                        setState(() {
                          selectedTitle = title;
                        });
                      },
                    ),
                  ),
                  const SizedBox(height: 30),
                  Text(
                    'Description',
                    style: GoogleFonts.montserrat(
                      textStyle: const TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                        fontSize: 30,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    child: TextField(
                      style: const TextStyle(color: Colors.black),
                      decoration: InputDecoration(
                        hintText: 'Enter description',
                        labelText: 'Description',
                        labelStyle: TextStyle(color: Colors.purple.shade900),
                        enabledBorder: const OutlineInputBorder(
                            borderSide: BorderSide(
                          color: Colors.black,
                          width: 1.0,
                        )),
                        border: const OutlineInputBorder(
                            borderSide: BorderSide(
                          color: Colors.black,
                          width: 1.0,
                        )),
                        focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide(
                          color: Colors.black,
                          width: 1.0,
                        )),
                      ),
                      onChanged: (String description) {
                        setState(() {
                          selectedDescription = description;
                        });
                      },
                    ),
                  ),
                  const SizedBox(height: 30),
                  Text(
                    'Attachment',
                    style: GoogleFonts.montserrat(
                      textStyle: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                        fontSize: 30,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    selectedFileName,
                    style: const TextStyle(fontSize: 15),
                  ),
                  OutlinedButton(
                    style: ButtonStyle(
                        side: MaterialStateProperty.all(const BorderSide(
                          color: Colors.black,
                          width: 1.0,
                        )),
                        foregroundColor: MaterialStateProperty.all<Color>(
                            Colors.purple.shade900)),
                    onPressed: () async {
                      await pickFile();
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(Icons.add),
                        SizedBox(width: 10),
                        Text('Add attachment'),
                      ],
                    ),
                  ),
                  const SizedBox(height: 30),
                  const SizedBox(height: 10),
                  Text(
                    'Due Date',
                    style: GoogleFonts.montserrat(
                      textStyle: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                        fontSize: 30,
                      ),
                    ),
                  ),
                  Text(
                    "${selectedDate.day} - ${selectedDate.month} - ${selectedDate.year}",
                    style: const TextStyle(fontSize: 15),
                  ),
                  OutlinedButton(
                    style: ButtonStyle(
                        side: MaterialStateProperty.all(const BorderSide(
                          color: Colors.black,
                          width: 1.0,
                        )),
                        foregroundColor: MaterialStateProperty.all<Color>(
                            Colors.purple.shade900)),
                    onPressed: () async {
                      await _selectDate(context);
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(Icons.calendar_today_outlined),
                        SizedBox(width: 10),
                        Text('Select due date'),
                      ],
                    ),
                  ),
                  const SizedBox(height: 30),
                ],
              ),
            ),
          ),
          showLoading
              ? Container(
                  height: double.infinity,
                  width: double.infinity,
                  color: Colors.white,
                  child: Center(
                      child: Lottie.asset('assets/animations/loading.json')),
                )
              : Container(),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Colors.purple.shade900,
        onPressed: () async {
          await uploadFile(selectedFileName, file);
          pushData();
          Navigator.pop(context);
        },
        label: const Text("Create"),
        icon: const Icon(Icons.add),
      ),
    );
  }
}
