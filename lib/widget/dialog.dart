import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

showAlertDialog(BuildContext context , String text) {
    // set up the buttons
    Widget cancelButton = TextButton(
      child: Text("لا"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
    Widget continueButton = TextButton(
      child: Text("نعم"),
      onPressed: ()async {
     
        Navigator.of(context).pop();
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      
      content: Text( text,textDirection: TextDirection.rtl ,style: GoogleFonts.cairo(),),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }