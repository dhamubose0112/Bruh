import 'package:flutter/material.dart';

import '../../../../CommonUtils/commonString.dart';

class AboutScreen extends StatefulWidget {
  const AboutScreen({Key? key}) : super(key: key);

  @override
  State<AboutScreen> createState() => _AboutUsScreenState();
}

class _AboutUsScreenState extends State<AboutScreen> {
  String appVersion = '';

  @override
  void initState() {
    super.initState();

  }


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(

        body: SingleChildScrollView(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 20, left:0),
                    child: GestureDetector(
                      onTap: (){
                        Navigator.pop(context);

                      },
                        child: Icon(Icons.arrow_left)),
                  ),
                  SizedBox(width: 10,),
                  Padding(
                    padding: const EdgeInsets.only(top: 20, left:0),
                    child: Text("About Us",style: TextStyle(fontSize:25,fontFamily: "MyFont" ),),
                  ),
                ],
              ),
              Align(
                alignment: Alignment.topCenter,
                child: Image.asset(
                  'assets/about.png',
                  width: 450,
                  height: 250,
                ),
              ),
              Text(
                CommonString().greet,
                style: TextStyle(
                    fontSize: 16.0,
                    fontFamily: "Regular",
                ),
              ),
              SizedBox(height: 8.0),

              Text(
                CommonString().poetryBreath,
                style: TextStyle(
                    fontSize: 15.0,
                    fontFamily: "Regular"
                ),
              ),
              SizedBox(height: 8.0),
              Text(
                CommonString().better,
                style: TextStyle(
                  fontSize: 12.0,
                  fontFamily: "Regular",
                ),
              ),
              SizedBox(height: 8.0),
              Text(
                CommonString().platformDescription,
                style: TextStyle(fontSize: 14.0, fontFamily: "Regular"),
              ),
              SizedBox(height: 16.0),
              Text(
                CommonString().creativePlatformDescription,
                style: TextStyle(fontSize: 14.0, fontFamily: "Regular"),
              ),
              SizedBox(height: 16.0),
              Text(
                CommonString().paradiseForWriters,
                style: TextStyle( fontSize: 12.0,
                    fontFamily: "Regular",),
              ),
              SizedBox(height: 16.0),
              Text(
                CommonString().heartMusingsDescription,
                style: TextStyle(fontSize: 12.0, fontFamily: "Regular"),
              ),
              SizedBox(height: 16.0),
              Text(
                CommonString().beCreative,
                style: TextStyle(fontSize: 12.0,
                    fontFamily: "Regular",),
              ),
              SizedBox(height: 16.0),
              Padding(
                padding: const EdgeInsets.only(right: 20),
                child: Text(
                  CommonString().honeWritingSkillsDescription,
                  textAlign: TextAlign.justify,
                  style: TextStyle(fontSize: 12.0, fontFamily: "Regular",),
                ),
              ),
              SizedBox(height: 16.0),
              Text(
                CommonString().socialNetworking,
                style: TextStyle(fontSize: 12.0,
                  fontFamily: "Regular",),
              ),
              SizedBox(height: 16.0),
              Text(
                CommonString().readStoriesDescription,
                style: TextStyle(fontSize: 12.0, fontFamily: "Regular"),
              ),
              SizedBox(height: 16.0),
              Text(
                CommonString().userFriendlyAppDescription,
                style: TextStyle(fontSize: 14.0, fontFamily: "Regular"),
              ),
              SizedBox(height: 16.0),

              Text(
                CommonString().moral,
                style: TextStyle(fontSize: 12.0, fontFamily: "Regular"),
              ),
              SizedBox(height: 16.0),


              Text(
                CommonString().pourYourHeart,
                style: TextStyle(fontSize: 14.0, fontFamily: "Regular"),
              ),
              SizedBox(height: 16.0),
              Text(
                CommonString().privacyRespectDescription,
                style: TextStyle(fontSize: 14.0, fontFamily: "Regular"),
              ),



              SizedBox(height: 50.0),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  width: double.infinity,
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      'This app is Copyright © 2023. Yaash School of technology Version $appVersion',
                      style: TextStyle(fontSize: 10.0, color: Colors.grey),
                      textAlign: TextAlign.center,
                    ),
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