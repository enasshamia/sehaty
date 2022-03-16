import 'package:flutter/material.dart';
import 'package:graduation/models/slide.dart';
import 'package:google_fonts/google_fonts.dart';
class SlideItem extends StatelessWidget {
  final int index;
  SlideItem(this.index);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size ;
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
           width: size.width*0.8,
           height: size.height*0.33,
            decoration: BoxDecoration(
             
              image: DecorationImage(
                image: AssetImage(slideList[index].imageUrl),
              
              ),
            ),
          ),
          SizedBox(
            height: size.height*0.02,
          ),
          
        
          Text(
            slideList[index].description , style:GoogleFonts.cairo(fontWeight: FontWeight.w600),
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: size.height*0.02,
          ),
        ],
      ),
    );
  }
}