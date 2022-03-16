
import 'dart:async';

import 'package:custom_navigation_bar/custom_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class FullImage extends StatelessWidget {
  String imageUrl ; 
String title ;
  FullImage(this.imageUrl , this.title);
  @override
  Widget build(BuildContext context) {
return   AppBar(
  
    flexibleSpace: Container(
  
      decoration:
  
        BoxDecoration(
  
          image: DecorationImage(
  
            image: NetworkImage(imageUrl)
  
          ),
  
        ),
  
    ),
  
    backgroundColor: Colors.transparent,
  
    title: Text(title),
  
  
);
  }
}
  