import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../../AuthClass/AuthService.dart';
import '../../CommonUtils/commonString.dart';
import '../DashBoard/DashboardPost/dasboardPost.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  TextEditingController _otpController = TextEditingController();
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.05),
              child: Align(
                alignment: Alignment.topCenter,
                child: Text(
                  CommonString().appName,
                  style: TextStyle(fontFamily: 'MyFont', fontSize: 30),
                ),
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.05),
            Image.asset("assets/welcome.png", height: MediaQuery.of(context).size.height * 0.35),
            SizedBox(height: MediaQuery.of(context).size.height * 0.03),
            Padding(
              padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.1),
              child: Text(
                CommonString().welcomeText,
                textAlign: TextAlign.justify,
                style: TextStyle(fontFamily: 'Regular', fontSize: 15),
              ),
            ),
            Text(
              CommonString().description,
              style: TextStyle(fontFamily: 'MyFont', fontSize: 20),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.03),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  child: _isLoading
                      ? CircularProgressIndicator(
                    color: Colors.black,
                  )
                      : RawMaterialButton(
                    elevation: 0.0,
                    // onPressed: (){
                    //   Navigator.pushReplacement(
                    //     context,
                    //     MaterialPageRoute(builder: (context) => DashBoard()),
                    //   );
                    //
                    // },
                    onPressed: () async {
                      setState(() {
                        _isLoading = true;
                      });
                      var user = (await AuthService().signInWithGoogle());
                      if (user != null) {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => DashBoard()),
                        );
                      } else {
                        print("Sign in failed");
                      }
                      setState(() {
                        _isLoading = false;
                      });
                    },
                    fillColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(45.0),
                      side: BorderSide(color: Colors.grey),
                    ),
                    constraints: BoxConstraints(
                      minWidth: MediaQuery.of(context).size.width * 0.9,
                      minHeight: 60.0,
                    ),
                    child: Center(
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Image.asset(
                            'assets/gicon.png',
                            height: 30,
                            width: 30,
                          ),
                          SizedBox(width: 10.0),
                          Text(
                            'Sign in with Google',
                            style: TextStyle(
                              fontFamily: "MyFont",
                              color: Colors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
