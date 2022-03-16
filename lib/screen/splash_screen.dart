
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:graduation/models/user.dart';
import 'package:graduation/screen/home_doctor_screen.dart';
import 'package:graduation/screen/home_patient_screen.dart';
import './welcome_screen.dart';
import '../backend/server.dart';
class SplashScreen extends StatefulWidget {
  userType type ;
  @override
  _SplashScreenState createState() => _SplashScreenState();
}


class _SplashScreenState extends State<SplashScreen> {
String userId;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    userId =getUserId();
    if(userId != null) {
      fetchData();
     
    }

  }
  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(seconds: 3)).then((value) {
    if(userId != null) {

    }else {
      Get.off(WelcomeScreen());
    }
    });
    Size size = MediaQuery.of(context).size;
    return Scaffold(
    
      body:Container(
        width: size.width,
        height: size.height,
        decoration: BoxDecoration(
          gradient: LinearGradient(
          stops: [0.1, 0.5,
            0.9],
            begin: FractionalOffset.topCenter,
            end: FractionalOffset.bottomCenter,
           // 10% of the width, so there are ten blinds.
          colors: <Color>[
            Color.fromRGBO(123, 173, 203, 1),
             Color.fromRGBO(74, 104, 147, 1),
            Color.fromRGBO(11, 7, 75, 1)
          ], // red to yellow
        // repeats the gradient over the canvas
        ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Stack(children: [
              
              Image.asset("assets/heart.png" , fit: BoxFit.cover,),
                  
                 
                 Positioned.fill(child:   Image.asset("assets/Path 2.png" ,),),
              ],),
              SizedBox(height: size.height*0.02),
              Text("تطبيق صحتي ", style: TextStyle(fontSize: 18 ,color: Colors.white ,fontWeight: FontWeight.w800),)
            ],),
        ),
      )
      
    );
  }
}