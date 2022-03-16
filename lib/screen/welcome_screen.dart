import 'package:flutter/material.dart';
import 'package:graduation/screen/hello.dart';
import 'package:graduation/screen/login_screen.dart';
import 'package:graduation/screen/slider_screen.dart';
import 'package:graduation/style/colors.dart';
import 'package:get/get.dart';

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: primaryColor,
      body: Container(
        child: Directionality(
            textDirection: TextDirection.rtl,
            child: Column(children: [
              ClipPath(
                clipper: MyClipper(),
                child: Container(
                  width: size.width,
                  height: size.height * 0.55,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          image: AssetImage("assets/splash.png"))),
                ),
              ),
              Container(
                width: size.width * 0.8,
                child: Center(
                  child: Column(
                    children: [
                      Text(
                        "تطبيق صحتي ",
                        style: primaryText,
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(
                        height: size.height * 0.03,
                      ),
                      Text(
                          "تطبيق يهتم بتقديم الخدمات الصحية والاستشارية للحفاظ عل صحتك",
                          style: primaryText,
                          textAlign: TextAlign.center),
                      SizedBox(
                        height: size.height * 0.04,
                      ),
                      Container(
                        child: FlatButton(
                          child: Text(
                            "تسجيل الدخول ",
                            style: buttonText,
                          ),
                          onPressed: (){
                            Get.to(LoginScreen()) ;
                          },
                        ),
                        width: size.width * 0.5,
                        height: size.height * 0.04,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white),
                      ),
                      SizedBox(
                        height: size.height * 0.02,
                      ),
                      Container(
                        child: FlatButton(
                          child: Text(
                            "انضم الان  ",
                            style: buttonText,
                          ),
                          onPressed: () {
                            Get.to(HelloScreen());
                          },
                        ),
                        width: size.width * 0.5,
                        height: size.height * 0.04,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white),
                      ),
                      SizedBox(
                        height: size.height * 0.02,
                      ),
                      Container(
                        child: FlatButton(
                          child: Text(
                            "   عن التطبيق",
                            style: buttonText,
                          ),
                          onPressed: () {
                            Get.to(SliderScreen());
                          },
                        ),
                        width: size.width * 0.5,
                        height: size.height * 0.04,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ),
             
            ])),
      ),
    );
  }
}

class MyClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();

    path.moveTo(0, size.height * 0.65);

    path.quadraticBezierTo(
        size.width / 2, size.height, size.width, size.height * 0.65);
    path.lineTo(size.width, 0);
    path.lineTo(0, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}

