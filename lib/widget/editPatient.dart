

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:graduation/backend/appProvider.dart';
import 'package:graduation/backend/repositary.dart';
import 'package:graduation/backend/server.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:cached_network_image/cached_network_image.dart';

class EditPatientProfile extends StatefulWidget {
  @override
  _EditPatientProfileState createState() => _EditPatientProfileState();
}

class _EditPatientProfileState extends State<EditPatientProfile> {
   @override
  void initState() {
    // TODO: implement initState
    super.initState();
   fetch();
  }
  showLoaderDialog(BuildContext context) {
    AlertDialog alert = AlertDialog(
      content: new Row(
        children: [
          CircularProgressIndicator(),
          Container(
              margin: EdgeInsets.only(left: 15), child: Text("جاري التعديل...")),
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
  String userName;

  String email;

  String age;

  String mobile;

  String state;

  String address;

  File file;

  editProfiles()async {
    Map map = {
      "email": this.email ?? Repository.repository.appUser.email,
      
      "userName": this.userName ?? Repository.repository.appUser.userName,
      "mobileNumber": this.mobile ?? Repository.repository.appUser.mobileNumber,
      "age": this.age ?? Repository.repository.appUser.age,
      "address": this.address ?? Repository.repository.appUser.address,
      "isMale": Repository.repository.appUser.isMale,
      "state": this.state ?? Repository.repository.appUser.state,
     "fileUrl": Repository.repository.appUser.fileUrl,
      "logo" :this.file ?? Repository.repository.appUser.logo,
      
    };
  showLoaderDialog(context);
    await editProfileinFirebase(map);
    Get.back();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("تعديل البيانات", style: GoogleFonts.cairo()),
        
      ),body :   Directionality(
        textDirection: TextDirection.rtl,
        child: SingleChildScrollView(
          child: Container(
            decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(size.width * 0.1)),
            margin: EdgeInsets.symmetric(
                horizontal: size.width * 0.03, vertical: size.height * 0.03),
            padding: EdgeInsets.symmetric(
                horizontal: size.width * 0.03, vertical: size.height * 0.03),
            child: Column(
              children: [
                Selector<AppsProvider, File>(
                  builder: (context, value, child) {
                    return GestureDetector(
                      onTap: () async {
                        PickedFile pickedFile = await ImagePicker()
                            .getImage(source: ImageSource.gallery);
                      File file = File(pickedFile.path);
                        Provider.of<AppsProvider>(context, listen: false)
                            .setFile(file);
                      },
                      child: Container(
                          width: size.width * 0.3,
                          height: size.height * 0.15,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle, color: Colors.white),
                          child: ClipRRect(
                            borderRadius:
                                BorderRadius.circular(size.width * 0.2),
                            child: value == null ? Repository.repository.appUser.logo != null  ?CachedNetworkImage(
                              imageUrl: Repository.repository.appUser.logo ,
                              fit: BoxFit.cover,
                            ): Container(
                                  width: size.width * 0.3,
                                  height: size.height * 0.15,
                                  child: CircleAvatar(
                                    child: FittedBox(
                                        child: Text(Repository
                                            .repository.appUser.userName[0])),
                                  ))
                                : Image.file(
                                    value,
                                    fit: BoxFit.cover,
                                  )
                                 ,
                          )),
                    );
                  },
                  selector: (x, y) {
                    return y.file;
                  },
                ),
                SizedBox(
                  height: size.height * 0.03,
                ),
                TextFormField(
                  style: TextStyle(color: Colors.grey, fontSize: 13),
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(size.height * 0.015),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8))),
                  initialValue: Repository.repository.appUser.userName,
                  onChanged: (value) {
                    this.userName = value;
                  },
                ),
                SizedBox(
                  height: size.height * 0.03,
                ),
                TextFormField(
                  style: TextStyle(color: Colors.grey, fontSize: 13),
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(size.height * 0.015),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8))),
                  initialValue: Repository.repository.appUser.email,
                  onChanged: (value) {
                    this.email = value;
                  },
                ),
                SizedBox(
                  height: size.height * 0.03,
                ),
                TextFormField(
                  style: TextStyle(color: Colors.grey, fontSize: 13),
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(size.height * 0.015),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8))),
                  initialValue: Repository.repository.appUser.mobileNumber,
                  onChanged: (value) {
                    this.mobile = value;
                  },
                ),
                SizedBox(
                  height: size.height * 0.03,
                ),
                TextFormField(
                  style: TextStyle(color: Colors.grey, fontSize: 13),
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(size.height * 0.015),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8))),
                  initialValue: Repository.repository.appUser.address,
                  onChanged: (value) {
                    this.address = value;
                  },
                ),
                SizedBox(
                  height: size.height * 0.03,
                ),
                TextFormField(
                  style: TextStyle(color: Colors.grey, fontSize: 13),
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(size.height * 0.015),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8))),
                  initialValue: Repository.repository.appUser.state,
                  onChanged: (value) {
                    this.state = value;
                  },
                ),
                SizedBox(
                  height: size.height * 0.03,
                ),
                TextFormField(
                  style: TextStyle(color: Colors.grey, fontSize: 13),
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(size.height * 0.015),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8))),
                  initialValue: Repository.repository.appUser.age,
                  onChanged: (value) {
                    this.age = value;
                  },
                ),
                SizedBox(
                  height: size.height * 0.03,
                ),
                Container(
                  margin: EdgeInsets.only(top: size.height * 0.02),
                  width: size.width * 0.8,
                  child: TextButton(
                    onPressed: () {
                      editProfiles();
                    }
                  ,
                    child: Text(
                      " تعديل البيانات",
                      style: TextStyle(color: Colors.black),
                    ),
                    style:
                        TextButton.styleFrom(backgroundColor: Colors.blue[200]),
                  ),
                ),
              ],
            ),
          ),
        ),
      )
    );
  }
}