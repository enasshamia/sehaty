import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:graduation/models/user.dart';
import 'package:graduation/screen/regestration_screen.dart';
import 'package:graduation/screen/slider_screen.dart';
import 'package:graduation/style/colors.dart';
import 'package:graduation/widget/register_widget.dart';

class HelloScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size ;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Directionality (
        textDirection: TextDirection.rtl,
        child:
                   Column(
            children: [
              Center(
                child: Container(
                  margin: EdgeInsets.only(top:  size.height*0.1),
                      width: size.width*0.4,
                      height: size.height * 0.42,

                      decoration: BoxDecoration(
                          image: DecorationImage(
                            alignment: Alignment.center,
                              fit: BoxFit.cover,
                              image: AssetImage("assets/doc.png"))),
                    ),
              ),
              Text("اختر طبيبك" , style: TextStyle(fontSize: 27 , fontWeight: FontWeight.bold ,),),
              Text("من السهل الأن تحديد موعد مع طبيبك" , style: TextStyle(fontSize: 17 , 
              fontWeight: FontWeight.bold, ),),
                SizedBox(height : size.height*0.04) ,
              Row(
                
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                RegisterWidget(buttonsText :"تسجيل مريض"  , imageUrl: "assets/Image 4.png"  , fun: () {
                  Get.to(RegisterScreen(userType.patient));
                },),
                SizedBox(width : size.width*0.04) ,
            RegisterWidget(buttonsText :"تسجيل طبيب"  , imageUrl: "assets/Image 2.png"  , fun: () {
               Get.to(RegisterScreen(userType.docotr));
            })  
              ],),
               SizedBox(height : size.height*0.04),
              GestureDetector(
                onTap: () {


                  Get.to(SliderScreen());
                },
                            child: Container (
                  width: size.width * 0.55,
                  height: size.height*0.05,
                  decoration: BoxDecoration(
                    color: primaryColor , 
                    borderRadius: BorderRadius.circular(size.width * 0.02)
                  ),
                  child: 
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                  Image.asset('assets/logo.png') ,
                  Text("عن التطبيق ؟ " , style: TextStyle(color: Colors.white , fontSize: 20 , fontWeight: FontWeight.bold),)
                ],)
                ,),
              )
            ],
          ),
        
      ),
    );
  }
}