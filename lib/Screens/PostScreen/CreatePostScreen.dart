import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import '../../FireStore/postData.dart';
import '../DashBoard/dashBoardScreen.dart';

class CreatePostScreen extends StatefulWidget {
  @override
  _CreatePostScreenState createState() => _CreatePostScreenState();
}

class _CreatePostScreenState extends State<CreatePostScreen> {
  TextEditingController _postTextController = TextEditingController();
  List<File> _selectedImages = []; // To store the selected images
  String selectedDropdownValue = 'Mudichur'; // Initial value for the dropdown

  bool _isUploading = false;

  Future<List<String>> _uploadImages() async {
    List<String> imageUrls = [];

    for (File imageFile in _selectedImages) {
      // Implement your image upload logic here and get the image URL
      // For example, you can use Firebase Storage to upload images
      // and get the download URL
      // String imageUrl = await uploadImageToStorage(imageFile);

      // For the sake of example, we'll use a placeholder URL
      String imageUrl = 'https://example.com/placeholder.jpg';

      imageUrls.add(imageUrl);
    }

    return imageUrls;
  }

  Future<void> _savePostDataToFirestore() async {
    try {
      setState(() {
        _isUploading = true;
      });

      FirebaseFirestore firestore = FirebaseFirestore.instance;
      List<String> imageUrls = await _uploadImages();

      PostData postData = PostData(
        imageUrls: imageUrls,
        comment: _postTextController.text,
        location: selectedDropdownValue,
        time: DateTime.now(),
        thought: _postTextController.text,
      );

      Map<String, dynamic> postDataMap = postData.toMap();
      await firestore.collection('BruhPost').add(postDataMap);
      print('Post data added to Firestore successfully.');

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => DashBoardScreen()),
      );
    } catch (e) {
      print('Error adding post data to Firestore: $e');
    } finally {
      setState(() {
        _isUploading = false;
      });
    }
  }
  void _showOptionsSheet() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListTile(
              leading: Icon(Icons.camera),
              title: Text('Take a Photo'),
              onTap: () {
                _getImageFromCamera();
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.photo),
              title: Text('Choose from Gallery'),
              onTap: () {
                _getImageFromGallery();
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  // Function to capture an image from the camera
  Future<void> _getImageFromCamera() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      setState(() {
        _selectedImages.add(File(pickedFile.path));
      });
    }
  }

  Future<void> _getImageFromGallery() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery); // Use ImageSource.gallery to open the gallery
    if (pickedFile != null) {
      setState(() {
        _selectedImages.add(File(pickedFile.path));
      });
    }
  }

  void _deleteImage(int index) {
    setState(() {
      _selectedImages.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Create Post', style: TextStyle(fontFamily: "MyFont")),
          leading: IconButton(
            icon: Icon(Icons.close),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          backgroundImage: NetworkImage('https://example.com/your_avatar_image_url.jpg'),
                          radius: 25, // Adjust the size as needed
                        ),
                        SizedBox(width: 10),
                        Text(
                          'Username', // Replace with the actual username
                          style: TextStyle(
                            fontFamily: "Regular",
                            fontSize: 15,
                          ),
                        ),
                      ],
                    ),
                    // Display selected images in a grid format with delete buttons
                    if (_selectedImages.isNotEmpty)
                      GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          crossAxisSpacing: 4.0,
                          mainAxisSpacing: 4.0,
                        ),
                        itemCount: _selectedImages.length,
                        shrinkWrap: true,
                        itemBuilder: (BuildContext context, int index) {
                          return Stack(
                            children: [
                              Image.file(_selectedImages[index], width: double.infinity, fit: BoxFit.cover),
                              Positioned(
                                top: 0,
                                right: 0,
                                child: IconButton(
                                  icon: Icon(Icons.delete,color: Colors.red,),
                                  onPressed: () {
                                    _deleteImage(index);
                                  },
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    ElevatedButton(
                      child: Text('Post', style: TextStyle(fontFamily: "Regular", color: Colors.white)),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.black,
                      ),
                      onPressed: () {
                        _savePostDataToFirestore();
                      },
                    ),
                    if (_isUploading)
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 10.0),
                        child: CircularProgressIndicator(),
                      ),
                  ],
                ),
                SizedBox(height: 5.0),
                TextField(
                  style: TextStyle(fontFamily: "Regular"),
                  controller: _postTextController,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'What\'s on your mind?',
                  ),
                  maxLines: null, // Allow multiple lines for longer posts.
                ),

                SizedBox(height: 50.0),

                if (_selectedImages.isNotEmpty)
                  GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 4.0,
                      mainAxisSpacing: 4.0,
                    ),
                    itemCount: _selectedImages.length,
                    shrinkWrap: true,
                    itemBuilder: (BuildContext context, int index) {
                      return Stack(
                        children: [
                          Image.file(_selectedImages[index],
                              width: double.infinity, fit: BoxFit.cover),
                          Positioned(
                            top: 0,
                            right: 0,
                            child: IconButton(
                              icon: Icon(Icons.delete),
                              onPressed: () {
                                _deleteImage(index);
                              },
                            ),
                          ),
                        ],
                      );
                    },
                  ),

                SizedBox(height: 20),

                TextField(
                  style: TextStyle(fontFamily: "Regular"),
                  decoration: InputDecoration(
                    hintText: 'Add a comment...',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                ),
                SizedBox(height: 16.0),

                // Add the dropdown with above outline border here
                DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                    labelText: 'Select an option',
                    border: OutlineInputBorder(
                      borderSide: BorderSide(),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  value: selectedDropdownValue,
                  items: <String>[
                    'Mudichur',
                    'East Tambaram',
                    'Vandalur',
                    'Chromepet',
                    'Pallavaram',
                    'Sholinganallur'
                  ]
                      .map<DropdownMenuItem<String>>(
                        (String value) => DropdownMenuItem<String>(
                      value: value,
                      child: Text(value, style: TextStyle(fontFamily: "Regular")),
                    ),
                  )
                      .toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedDropdownValue = newValue!;
                    });
                  },
                ),
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.black,
          onPressed: _showOptionsSheet,
          child: Icon(Icons.camera_alt_rounded, color: Colors.white),
        ),
      ),
    );
  }
}
