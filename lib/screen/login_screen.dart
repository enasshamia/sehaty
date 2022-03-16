import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:graduation/backend/server.dart';

import 'package:graduation/widget/dialog.dart';
import 'package:string_validator/string_validator.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String email;
  String password;
   FocusNode f1 = new FocusNode();
  FocusNode f2 = new FocusNode();
  savepassword(String value) {
    this.password = value;
  }

  saveEmail(String value) {
    this.email = value;
  }

  showLoaderDialog(BuildContext context) {
    AlertDialog alert = AlertDialog(
      content: new Row(
        children: [
          CircularProgressIndicator(),
          Container(
              margin: EdgeInsets.only(left: 15), child: Text("جاري تسجيل الدخول...")),
        ],
      ),
    );
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  GlobalKey<FormState> formKey = GlobalKey();
  saveForm() {
    if (formKey.currentState.validate()) {
     
      showLoaderDialog(context);
      loginUsingEmailAndPassword(email, password,context);
    } else {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.black, //change your color here
        ),
        title: Text(
          "تسجيل الدخول ",
          style: GoogleFonts.cairo(color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: Container(
          height: size.height,
          width: size.width,
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/Background.png"), fit: BoxFit.cover),
          ),
          child: Container(
            margin: EdgeInsets.symmetric(vertical: size.height * 0.06),
            child: Form(
                key: formKey,
                child: Column(
                  children: [
                    Container(
                      width: size.width * 0.8,
                      child: TextFormField(
                       onChanged: (value) {
                         this.email = value;
                       },
                        focusNode: f1,
                     
                        validator: (String value) {
                          if (value.length == 0) {
                            return "يرجى ادخال البريد الالكتروني ";
                          } else if (!isEmail(value)) {
                            return "البريد الالكتروني غير صحيح ";
                          } else {
                            return null;
                          }
                        },
                           onFieldSubmitted: (value) {
                             
                              FocusScope.of(context).requestFocus(f2);
                               f1.unfocus();
                            },
                        decoration: InputDecoration(
                            contentPadding: EdgeInsets.all(size.height * 0.015),
                            labelText: " البريد الالكتروني  ",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8))),
                      ),
                    ),
                    SizedBox(height: size.height * 0.04),
                    Container(
                      width: size.width * 0.8,
                      child: TextFormField(
                      obscureText: true,
                        focusNode:f2,
                         onChanged: (value) {
                         this.password = value;
                       },
                    
                        validator: (String value) {
                          if (value.length == 0) {
                            return "    يرجى ادخال كلمة المرور";
                          
                          } else {
                            return null;
                          }
                        },
                           onFieldSubmitted: (value) {
                             
                              FocusScope.of(context).requestFocus();
                               f2.unfocus();
                            },
                        decoration: InputDecoration(
                            contentPadding: EdgeInsets.all(size.height * 0.015),
                            labelText: "كلمة السر  ",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8))),
                      ),
                    ),
                    TextButton(onPressed: () =>resetpassword(email), child: Text("هل نسيت كلمة المرور ؟")),
                    SizedBox(height: size.height * 0.04),
                    Container(
                        width: size.width * 0.7,
                        decoration: BoxDecoration(
                            color: Color.fromRGBO(123, 173, 203, 1),
                            boxShadow: [
                              BoxShadow(
                                color: Color.fromRGBO(123, 173, 203, 1)
                                    .withOpacity(0.3),
                                spreadRadius: 3,
                                blurRadius: 5,
                                offset: Offset(0, 3),
                              ),
                            ],
                            borderRadius: BorderRadius.circular(20)),
                        child: FlatButton(
                            child: Text('تسجيل الدخول',
                                style: GoogleFonts.cairo(
                                    fontSize: 15, color: Colors.black)),
                            onPressed: () {
                              saveForm();
                            })),
                  ],
                )),
          ),
        ),
      ),
    );
  }
}
