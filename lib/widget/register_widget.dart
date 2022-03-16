
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:graduation/screen/regestration_screen.dart';
import 'package:graduation/style/colors.dart'; 
class RegisterWidget extends StatelessWidget {
  String buttonsText ;
  String imageUrl ;
  Function fun ; 
  RegisterWidget({this.buttonsText , this.imageUrl, this.fun });
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size ;
    return Container(
     padding: EdgeInsets.symmetric(vertical: size.height*0.023),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.black , width: 0.5),
        boxShadow: [
      BoxShadow(
        color: Color.fromRGBO(51, 51, 51, 1).withOpacity(0.57),
         // changes position of shadow
         spreadRadius: 3,
        blurRadius: 5,
        offset: Offset(0, 3),
      ),
    ],
      ),
      width: size.width*0.38,
      height: size.height*0.2,
      child: Column (children: [
        Image.asset(imageUrl , width:size.width*0.3, height: size.height*0.1,) ,
        SizedBox(height: size.height*0.01,),
        Container(
         child: FlatButton(
        child: FittedBox(
                  child: Text(buttonsText
  ,
                   style: TextStyle(fontSize: 15 , color: Colors.white , fontWeight: FontWeight.bold),
                       ),
        ),
                          onPressed: fun ,
                    ),
                        width: size.width*0.28,
                       height: size.height * 0.04,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: primaryColor),
                      ),
      ],),
    );
  }
}