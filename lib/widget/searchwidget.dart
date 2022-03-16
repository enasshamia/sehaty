import 'package:flutter/material.dart';
import 'package:graduation/models/user.dart';

class SearchWidget extends StatelessWidget {
userType type ;

  @override
  Widget build(BuildContext context) {
    return Container(
      child:Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
        Text( 
        "يمكنك الان البحث عن المريض الذي تريده"
        ),
           Text(
         "اضغط على اشارة البحث وأدخل اسم المريض  "
         ),
       
         SizedBox(height: 30,),
         Image.asset("assets/search.png"),
      ],)
    );
  }
}
class SearchWidget2 extends StatelessWidget {
userType type ;

  @override
  Widget build(BuildContext context) {
    return Container(
      child:Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
        Text(  " يمكنك الان البحث عن الطبيب الذي تريد الحجز معه " 
    
        ),
         Text("اضغط على اشارة البحث وأدخل اسم الطبيب "  
        
         ),
         SizedBox(height: 30,),
         Image.asset("assets/search.png"),
      ],)
    );
  }
}