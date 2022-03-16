
import 'package:flutter/material.dart';


class CustomTextField extends StatelessWidget {
  Function saveFun;
  Function validateFun;
  String labelName;
  Function onFields ;
    FocusNode focusNode = new FocusNode();
 bool isHidden;
  CustomTextField( {this.labelName, this.saveFun, this.validateFun , this.focusNode ,this.onFields , this.isHidden= false} );
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size ;
    // TODO: implement build
    return Column(
      children: [
      Container(
        width: size.width*0.8,
       // height: size.height*0.06,
   
        child: TextFormField(
          obscureText: isHidden,
          focusNode: focusNode,
          onSaved: (value) {
            this.saveFun(value);
          },
          validator: (valu) =>
            this.validateFun(valu)
          
          ,
          onFieldSubmitted: (value) {
this.onFields() ;
          },
          decoration: InputDecoration(
            contentPadding: EdgeInsets.all(size.height*0.015),
              labelText: this.labelName,
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(8))),
        ),
      ),
      SizedBox(height: size.height*0.03,)

      ],
          
    );
  }
}