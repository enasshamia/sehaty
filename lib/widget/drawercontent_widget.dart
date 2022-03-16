
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ContentDrawer extends StatelessWidget {
  String title ;
  IconData icon ;
  Function fun ;
  ContentDrawer({this.title , this.icon ,this.fun});



  @override
  Widget build(BuildContext context) {
    return Container(
      child: GestureDetector(
        onTap: () {
       fun();
        },
              child: ListTile(
          title: Text(title,style: GoogleFonts.cairo(fontSize: 14),),
          trailing: Icon(icon , size: 23,color: Colors.blue,),
        ),
      ),
    );
  }
}