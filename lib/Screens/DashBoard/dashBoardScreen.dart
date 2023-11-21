import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../PostScreen/CreatePostScreen.dart';
import 'BottomNavScreens/Profile/Profile.dart';
import 'BottomNavScreens/notificationPage.dart';

class DashBoardScreen extends StatefulWidget {
  @override
  _DashBoardScreenState createState() => _DashBoardScreenState();
}

class _DashBoardScreenState extends State<DashBoardScreen> {
  bool isLiked = false;
  bool isCommented = false;
  bool isShared = false;
  late User? _user;


  GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email', 'profile']);
  GoogleSignInAccount? _googleSignInAccount;

  @override
  void initState() {
    super.initState();
    _initGoogleSignIn();
    _user = FirebaseAuth.instance.currentUser;
  }

  void _initGoogleSignIn() async {
    await _googleSignIn.signInSilently();
    _googleSignIn.onCurrentUserChanged.listen((GoogleSignInAccount? account) {
      setState(() {
        _googleSignInAccount = account;
      });
    });
  }



  List<String> dropdownItems = [
    'Mudichur',
    'Perungalathur',
    'Chromepet',
    'Pallavaram',
    'Sholinganallur',
    'Thirusulam',
    'Meenambakkam',
    'Palavandhangal'
  ];
  String selectedDropdownItem = 'Mudichur';

  void _showCommentBottomSheet() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              Text(
                "Add a Comment",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  fontFamily: "Regular",
                ),
              ),
              SizedBox(height: 10),
              // Add your comment input widgets here
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      showCursor: true,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white70,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50),
                            borderSide: BorderSide.none),
                        hintText: 'Comment...',
                        hintStyle: TextStyle(
                          color: Colors.grey,
                          fontFamily: "Regular",
                        ),
                      ),
                    ),
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.send, // Replace with your desired icon
                      color: Colors.black, // Change the color as needed
                    ),
                    onPressed: () {
                      // Add functionality for the icon here
                    },
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 30, left: 30),
            child: Row(
              children: [
                Text(
                  "Bruh",
                  style: TextStyle(fontSize: 25, fontFamily: "MyFont"),
                ),
                Spacer(),
                DropdownButton<String>(
                  value: selectedDropdownItem,
                  onChanged: (String? newValue) {
                    // Update the parameter type to String?
                    setState(() {
                      selectedDropdownItem = newValue ??
                          'Mudichur'; // Use the null-aware operator to handle null values
                    });
                  },
                  items: dropdownItems.map((String item) {
                    return DropdownMenuItem<String>(
                      value: item,
                      child: Text(
                        item,
                        style: TextStyle(fontFamily: "Regular"),
                      ),
                    );
                  }).toList(),
                ),
                SizedBox(
                  width: 60,
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 20),
                  child: Icon(
                    Icons.search_outlined,
                    size: 30,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 20),
          Stack(
            alignment: Alignment.topRight,
            children: [
              GestureDetector(
                onTap: () {
                  // Navigate to another page when the card is clicked
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => CreatePostScreen()),
                  );
                },
                child: Card(
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      children: [
                        CircleAvatar(
                          backgroundImage: _user != null ? NetworkImage(_user!.photoURL ?? '') : null,
                          radius: 25,
                        ),
                        SizedBox(width: 10),
                        Text(
                          "Share your review !",
                          style: TextStyle(fontSize: 13, fontFamily: "Regular"),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    top: 30, right: 40), // Adjust the padding as needed
                child: Icon(
                  Icons
                      .photo_library_outlined, // You can change this to the icon you want
                  size: 25,
                  color: Colors.black,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 30,
          ),
          Card(
            margin: EdgeInsets.symmetric(horizontal: 20),
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 25,
                        backgroundImage: AssetImage('assets/logo.png'),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Column(
                        children: [
                          Text(
                            "Username",
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                fontFamily: "MyFont"),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 50),
                            child: Row(
                              children: [
                                Text(
                                  "1hr",
                                  style: TextStyle(
                                      fontSize: 9,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: "Regular"),
                                ),
                                Icon(
                                  Icons.access_time_sharp,
                                  size: 10,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 1),

                  // Add the image view below the username
                  // Image.asset(
                  //   'assets/welcome.png',
                  //   width: 200,
                  //   height: 200, // Adjust the height as needed
                  //   fit: BoxFit.fill, // Adjust the fit as needed
                  // ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "This is your sample post content. You can put anything here.",
                      style: TextStyle(fontSize: 12, fontFamily: "Regular"),
                    ),
                  ),

                  SizedBox(height: 10),
                  // Padding(
                  //   padding: const EdgeInsets.all(8.0),
                  //   child: Text(
                  //     "This is your sample post content. You can put anything here.",
                  //     style: TextStyle(fontSize: 15,fontFamily: "Regular"),
                  //   ),
                  // ),
                  Image.asset(
                    'assets/welcome.png',
                    width: 200,
                    height: 200, // Adjust the height as needed
                    fit: BoxFit.fill, // Adjust the fit as needed
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.thumb_up_off_alt_sharp,
                        size: 15,
                        color: Colors.grey,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        "1087.Likes",
                        style: TextStyle(
                            fontSize: 10,
                            color: Colors.grey,
                            fontFamily: "Regular"),
                      ),
                      SizedBox(
                        width: 145,
                      ),
                      Text(
                        "187 Comments",
                        style: TextStyle(
                            fontSize: 10,
                            color: Colors.grey,
                            fontFamily: "Regular"),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        "3 Share",
                        style: TextStyle(
                            fontSize: 10,
                            color: Colors.grey,
                            fontFamily: "Regular"),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  // Align like, comment, and share icons horizontally
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          IconButton(
                            icon: Icon(
                              isLiked
                                  ? Icons.thumb_up
                                  : Icons.thumb_up_alt_outlined,
                              color: isLiked ? Colors.black : Colors.grey,
                            ),
                            onPressed: () {
                              // Toggle the like status
                              setState(() {
                                isLiked = !isLiked;
                              });
                              // Add functionality for liking the post
                            },
                          ),
                          Text(
                            "Like",
                            style:
                                TextStyle(fontSize: 10, fontFamily: "Regular"),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          IconButton(
                            icon: Icon(
                              Icons.mode_comment_outlined,
                              color: Colors.grey,
                            ),
                            onPressed: () {
                              // Toggle the comment status
                              setState(() {
                                isCommented = !isCommented;
                              });
                              // Add functionality for commenting on the post
                              if (isCommented) {
                                _showCommentBottomSheet(); // Show the comment bottom sheet
                              }
                            },
                          ),
                          Text(
                            "Comment",
                            style:
                                TextStyle(fontSize: 10, fontFamily: "Regular"),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          IconButton(
                            icon: Icon(
                              isShared
                                  ? Icons.ios_share
                                  : Icons.ios_share_rounded,
                              color: isShared ? Colors.black : Colors.grey,
                            ),
                            onPressed: () {
                              // Toggle the share status
                              setState(() {
                                isShared = !isShared;
                              });
                              // Add functionality for sharing the post
                            },
                          ),
                          Text(
                            "Share",
                            style:
                                TextStyle(fontSize: 10, fontFamily: "Regular"),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
