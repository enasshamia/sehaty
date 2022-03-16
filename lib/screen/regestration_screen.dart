import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_crop/image_crop.dart';

import 'package:string_validator/string_validator.dart';
import 'package:graduation/backend/appProvider.dart';
import 'package:graduation/backend/server.dart';
import 'package:graduation/models/user.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:graduation/style/colors.dart';
import 'package:graduation/widget/custometextfield.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class RegisterScreen extends StatefulWidget {
  userType type;
  RegisterScreen(this.type);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  String username;
  String email;
  String password;
  String age;
  String mobileNumber;
  String description;
  String state;
  File logo;
  String filrUrl;
  String address;
  String selectedRadio;

  FocusNode f1 = new FocusNode();
  FocusNode f2 = new FocusNode();
  FocusNode f3 = new FocusNode();
  FocusNode f4 = new FocusNode();
  FocusNode f5 = new FocusNode();
  FocusNode f6 = new FocusNode();
  FocusNode f7 = new FocusNode();
  FocusNode f8 = new FocusNode();
  FocusNode f9 = new FocusNode();

  showLoaderDialog(BuildContext context) {
    AlertDialog alert = AlertDialog(
      content: new Row(
        children: [
          CircularProgressIndicator(),
          Container(
              margin: EdgeInsets.only(left: 15), child: Text("جاري التسجيل...")),
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
   
  savepassword(String value) {
    this.password = value;
  }

  saveAge(String value) {
    this.age = value;
  }

  saveAddress(String value) {
    this.address = value;
  }

  savePhone(String value) {
    this.mobileNumber = value;
  }

  saveDescription(String value) {
    this.description = value;
  }

  savelogo(File value) {
    this.logo = value;
  }

  passwordValidation(String value) {
    if (value.length == 0) {
      return "يرجى ادخال كلمة المرور .  ";
    } else if (value.length < 9) {
      return "يجب ان لا تقل كلمة المرور عن 9 .";
    } else {
      return null;
    }
  }

  ageValidation(String value) {
    if (value.length == 0) {
      return "يرجى ادخال العمر .";
    } else {
      return null;
    }
  }

  phoneValidation(String value) {
    if (value.length == 0) {
      return ".يرجى ادخال رقم الجوال";
    } else if (value.length != 10) {
      return "يجب ان لا يقل رقم الجوال عن 10 أرقام. ";
    } else {
      return null;
    }
  }

  descriptioValidate(String value) {
    if (value.length == 0) {
      return "يرجى ادخال الخبرة العلمية .";
    } else {
      return null;
    }
  }

  adressValidate(String value) {
    if (value.length == 0) {
      return "يرجى ادخال العنوان كامل .";
    } else {
      return null;
    }
  }
  GlobalKey<FormState> formKey = GlobalKey();
  saveForm() {
    if (formKey.currentState.validate()) {
      formKey.currentState.save();
      AppUser appUser = widget.type == userType.docotr
          ? AppUser.doctorUser({
              "email": this.email,
              "userName": this.username,
              "password": this.password,
              "mobileNumber": this.mobileNumber,
              "address": this.address,
              "age": this.age,
              "description": this.description,
              "isMale": this.selectedRadio,
            })
          : AppUser.patientUser({
              "email": this.email,
              "userName": this.username,
              "password": this.password,
              "mobileNumber": this.mobileNumber,
              "age": this.age,
              "address": this.address,
              "isMale": this.selectedRadio,
              "fileUrl": this.filrUrl,
              "state": this.state
            });
      showLoaderDialog(context);
      saveUserInFirestore(appUser);
    } else {
      print("error");
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
          "صفحة التسجيل",
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: Container(
          height: size.height,
          width: size.width,
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [primaryColor, Colors.white, primaryColor],
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter)),
          child: Stack(
            children: [
              Container(
                height: size.height,
                width: size.width,
                child: Image.asset(
                  "assets/Texture.png",
                  fit: BoxFit.cover,
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: size.height * 0.03),
                child: Form(
                    key: formKey,
                    child: ListView(
                      children: [
                        Container(
                          padding: EdgeInsets.only(
                              top: size.height * 0.03,
                              right: size.width * 0.1,
                              left: size.width * 0.1),
                          child: TextFormField(
                            focusNode: f1,
                            onSaved: (value) {
                              this.username = value;
                            },
                            validator: (String value) {
                              if (value.length == 0 || value.length <= 5) {
                                return "يرجي ادخال الاسم كامل";
                              } else {
                                return null;
                              }
                            },
                            onChanged: (value) {
                              this.username = value;
                            },
                            onFieldSubmitted: (value) {
                         
                              FocusScope.of(context).requestFocus(f2);
                                   f1.unfocus();
                            },
                            decoration: InputDecoration(
                                contentPadding:
                                    EdgeInsets.all(size.height * 0.015),
                                labelText: " الاسم كامل",
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8))),
                          ),
                        ),
                        SizedBox(
                          height: size.height * 0.03,
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: size.width * 0.1,
                          ),
                          child: TextFormField(
                            focusNode: f2,
                            onSaved: (value) {
                              this.email = value;
                            },
                            validator: (String value) {
                              if (value.length == 0) {
                                return "يرجى ادخال البريد الالكتروني ";
                              }else if (!isEmail(value)) {
                                return "يرجى ادخال البريد الالكتروني بشكل صحيح";
                              }else {
                                return null;
                              }
                            },
                            onChanged: (value) {
                              this.email = value;
                            },
                            onFieldSubmitted: (value) {
                             
                              FocusScope.of(context).requestFocus(f3);
                               f2.unfocus();
                            },
                            decoration: InputDecoration(
                                contentPadding:
                                    EdgeInsets.all(size.height * 0.015),
                                labelText: "البريد الالكتروني",
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8))),
                          ),
                        ),
                        SizedBox(
                          height: size.height * 0.03,
                        ),
                        CustomTextField(
                          isHidden: true,
                          labelName: "كلمة السر  ",
                          saveFun: savepassword,
                          validateFun: passwordValidation,
                          focusNode: f3,
                          onFields: () {
                            f3.unfocus();
                            FocusScope.of(context).requestFocus(f4);
                          },
                        ),
                        CustomTextField(
                          labelName: " العمر ",
                          saveFun: saveAge,
                          validateFun: ageValidation,
                          focusNode: f4,
                          onFields: () {
                            f4.unfocus();
                            FocusScope.of(context).requestFocus(f5);
                          },
                        ),
                        CustomTextField(
                          labelName: "رقم الجوال ",
                          saveFun: savePhone,
                          validateFun: phoneValidation,
                          focusNode: f5,
                          onFields: () {
                            f5.unfocus();

                            FocusScope.of(context).requestFocus(f7);
                          },
                        ),
                        widget.type == userType.docotr
                            ? CustomTextField(
                                labelName: "الخبرة العلمية   ",
                                saveFun: saveDescription,
                                validateFun: descriptioValidate,
                                focusNode: f6,
                                onFields: () {
                                  f6.unfocus();

                                  FocusScope.of(context).requestFocus(f8);
                                },
                              )
                            : Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: size.width * 0.1,
                                ),
                                child: TextFormField(
                                  focusNode: f7,
                                  onSaved: (value) {
                                    this.state = value;
                                  },
                                  validator: (String value) {
                                    if (value.length == 0) {
                                      return "  يرجى ادخال الحالة الاجتماعية. ";
                                    } else {
                                      return null;
                                    }
                                  },
                                  onFieldSubmitted: (value) {
                                    f7.unfocus();
                                    FocusScope.of(context).requestFocus(f8);
                                  },
                                  onChanged: (value) {
                                    this.state = value;
                                  },
                                  decoration: InputDecoration(
                                      contentPadding:
                                          EdgeInsets.all(size.height * 0.015),
                                      labelText: " الحالة الاجتماعية",
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(8))),
                                ),
                              ),
                        widget.type == userType.docotr
                            ? Container()
                            : SizedBox(
                                height: size.height * 0.03,
                              ),
                        CustomTextField(
                          labelName: " العنوان  ",
                          saveFun: saveAddress,
                          validateFun: adressValidate,
                          focusNode: f8,
                          onFields: () {
                            f8.unfocus();
                            FocusScope.of(context).requestFocus(f9);
                          },
                        ),
                        widget.type == userType.docotr
                            ? Container()
                            : Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: size.width * 0.1,
                                ),
                                child: TextFormField(
                                  focusNode: f9,
                                  onSaved: (value) {
                                    this.filrUrl = value;
                                  },
                                  validator: (String value) {
                                    if (value.length == 0) {
                                      return "يرجى ادخال رابط الكتروني ";
                                    } else if(!isURL(value)) {
                                      return"يرجى ادخال رابط الكتروني ";
                                    }else {
                                      return null ;
                                    }
                                    
                                  },
                                  onChanged: (value) {
                                    this.filrUrl = value;
                                  },
                                    onFieldSubmitted: (value) {
                                    f9.unfocus();
                                    FocusScope.of(context).requestFocus();
                                  },
                                  decoration: InputDecoration(
                                      contentPadding:
                                          EdgeInsets.all(size.height * 0.015),
                                      labelText: "رفع ملفات ",
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(8))),
                                ),
                              ),
                              SizedBox(
                                height: size.height * 0.03,
                              ),
                        Container(
                          width: size.width * 0.1,
                          height: size.height * 0.1,
                          margin: EdgeInsets.symmetric(
                              horizontal: size.width * 0.15),
                          // color: Colors.white,
                          // margin: EdgeInsets.only(bottom: 150),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "ارفاق صورتك الشخصية",
                                style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.bold),
                              ),
                              Selector<AppsProvider, File>(
                                builder: (context, value, child) {
                                  return GestureDetector(
                                    onTap: () async {
                                      PickedFile pickedFile =
                                          await ImagePicker().getImage(
                                              source: ImageSource.gallery);
                                      File file; file= pickedFile!=null? File(pickedFile.path) :null;
                                      Provider.of<AppsProvider>(context,
                                              listen: false)
                                          .setFile(file);
                                    },
                                    child: Container(
                                      width: size.width * 0.2,
                                      height: size.height * 0.2,
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Colors.grey[100]),
                                      child: value != null
                                          ? Image.file(
                                              value,
                                              fit: BoxFit.cover,
                                            )
                                          : Icon(Icons.add),
                                    ),
                                  );
                                },
                                selector: (x, y) {
                                  return y.file;
                                },
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          height: size.height * 0.03,
                        ),
                        Container(
                            margin: EdgeInsets.symmetric(
                                horizontal: size.width * 0.15),
                            width: size.width * 0.7,
                            height: size.height * 0.05,
                            child: Row(
                              children: [
                                Row(
                                  children: [
                                    Text("ذكر",
                                        style: TextStyle(
                                            fontSize: 13,
                                            fontWeight: FontWeight.bold)),
                                    Radio(
                                      
                                      value: "Male",
                                      onChanged: (value) {
                                        this.selectedRadio = value;
                                        print(selectedRadio);
                                        setState(() {});
                                        selectedRadio = "ذكر";
                                      },
                                      groupValue: selectedRadio,
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text("أنثى",
                                        style: TextStyle(
                                            fontSize: 13,
                                            fontWeight: FontWeight.bold)),
                                    Radio(
                                     
                                      value: "Female",
                                      onChanged: (value) {
                                        this.selectedRadio = value;
                                        print(selectedRadio);
                                        setState(() {});
                                        selectedRadio = "أنثى";
                                      },
                                      groupValue: selectedRadio,
                                    ),
                                  ],
                                ),
                              ],
                            )),
                        SizedBox(
                          height: size.height * 0.03,
                        ),
                        Container(
                            margin: EdgeInsets.symmetric(
                                horizontal: size.width * 0.04),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10)),
                            child: FlatButton(
                                child: Text('تسجيل',
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black)),
                                onPressed: () {
                           saveForm();
                                }
                                )
                                ),
                      ],
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }
}
