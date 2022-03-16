import 'package:flutter/material.dart';

class HeartWidget extends StatefulWidget {
    @override
    _HeartWidgetState createState() => _HeartWidgetState();
  }

  class _HeartWidgetState extends State<HeartWidget> {
    @override
    Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Testing'),
        ),
        body: Center(
        child: CustomPaint(
            size: Size(100, 100),
            painter: RPSCustomPainter(),
          ),
        ),
      );
    }
  }
class RPSCustomPainter extends CustomPainter{
  
  @override
  void paint(Canvas canvas, Size size) {
    
    

  Paint paint_0 = new Paint()
      ..color = Color.fromARGB(255, 124, 193, 221)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4.33;
     
         
    Path path_0 = Path();
    path_0.moveTo(size.width*0.3066667,size.height*0.4988571);
    path_0.lineTo(size.width*0.3350000,size.height*0.4985714);
    path_0.lineTo(size.width*0.3516667,size.height*0.4414286);
    path_0.lineTo(size.width*0.3733333,size.height*0.5400000);
    path_0.lineTo(size.width*0.3916667,size.height*0.4971429);
    path_0.lineTo(size.width*0.4025000,size.height*0.4971429);

    canvas.drawPath(path_0, paint_0);
  
    
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
  
}
