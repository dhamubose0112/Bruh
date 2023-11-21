import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class UserPersonalInfo extends StatefulWidget {
  const UserPersonalInfo({Key? key}) : super(key: key);

  @override
  _UserPersonalInfoState createState() => _UserPersonalInfoState();
}

class _UserPersonalInfoState extends State<UserPersonalInfo> {
  File? _image;

  Future getImage(ImageSource source) async {
    final pickedFile = await ImagePicker().pickImage(source: source);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 20, right: 140),
                child: Text(
                  "User Personal Info",
                  style: TextStyle(fontSize: 25, fontFamily: "MyFont"),
                ),
              ),
              SizedBox(height: 40,),
              Align(
                alignment: Alignment.center,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.black12,
                      radius: 90,
                      backgroundImage: _image != null ? FileImage(_image!) : null,
                    ),
                    Positioned(
                      bottom: 0,
                      right: 10,
                      child: FloatingActionButton(
                        shape: CircleBorder(),
                        backgroundColor: Colors.black,
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text("Choose an option"),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                      getImage(ImageSource.camera);
                                    },
                                    child: Text("Camera"),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                      getImage(ImageSource.gallery);
                                    },
                                    child: Text("Gallery"),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                        child: Icon(
                          Icons.camera_alt,
                          size: 20,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 40), // Add some space between the profile picture and the TextField
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Username', // Customize this label as needed
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              SizedBox(height: 20,),
              SizedBox(height: 400,),
              ElevatedButton(
                onPressed: () {
                  // Add your onPressed logic for the button here
                },
                child: Text('Continue',style: TextStyle(fontSize: 15,fontFamily: "Regular",color: Colors.white),),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  padding: EdgeInsets.symmetric(vertical: 15, horizontal: 150), // Adjust the padding as needed
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(45), // Adjust the radius as needed
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
