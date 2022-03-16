import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:graduation/backend/repositary.dart';
import 'package:graduation/models/user.dart';

import 'package:graduation/style/colors.dart';
import 'package:graduation/widget/editDocotr.dart';
import 'package:graduation/widget/editPatient.dart';
import 'package:url_launcher/url_launcher.dart';

class ProfileScreen extends StatefulWidget {
  
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  _launchURL() async {
  final  url = Repository.repository.appUser.fileUrl;
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        body: SingleChildScrollView(
          child: SafeArea(
            child: Directionality(
                textDirection: TextDirection.rtl,
                child: Column(
                  children: [
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: size.width * 0.03),
                      color: Colors.blue[100],
                      child: Row(
                        children: [
                          Repository.repository.appUser.logo != null
                              ? Container(
                                  width: size.width * 0.2,
                                  height: size.height * 0.2,
                                  child: CircleAvatar(
                                    backgroundImage: NetworkImage(
                                        Repository.repository.appUser.logo),
                                  ))
                              : Container(
                                  width: size.width * 0.2,
                                  height: size.height * 0.2,
                                  child: CircleAvatar(
                                    child: FittedBox(
                                        child: Text(Repository
                                            .repository.appUser.userName[0])),
                                  )),
                          SizedBox(
                            width: size.width * 0.03,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                Repository.repository.appUser.userName,
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.w600),
                              ),
                              Repository.repository.appUser.type ==
                                      userType.docotr
                                  ? Text(Repository.repository.appUser.isMale ==
                                          "ذكر"
                                      ? "طبيب"
                                      : "طبيبة")
                                  : Text(Repository.repository.appUser.isMale ==
                                          "أنثى"
                                      ? "مريضة"
                                      : "مريض")
                            ],
                          ),
                          SizedBox(width: size.width*0.2,),
                          IconButton(icon: Icon(Icons.close, size: 30,), onPressed: (){
                            Get.back();
                          })
                        ],
                      ),
                    ),
                    SingleChildScrollView(
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: size.width * 0.04,
                            vertical: size.height * 0.03),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "الحساب",
                              style: TextStyle(
                                  color: Colors.blue,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w800),
                            ),
                            SizedBox(
                              height: size.height * 0.01,
                            ),
                            Text(
                              Repository.repository.appUser.userName,
                              style: profileStyle,
                            ),
                            Text("اسم المستخدم", style: profileText),
                            Divider(),
                            Text(
                              Repository.repository.appUser.email,
                              style: profileStyle,
                            ),
                            Text("ايميل المستخدم", style: profileText),
                            Divider(),
                            Text(Repository.repository.appUser.mobileNumber,
                                style: profileStyle),
                            Text("رقم الهاتف ", style: profileText),
                            Divider(),
                            Text(
                              Repository.repository.appUser.address,
                              style: profileStyle,
                            ),
                            Text(
                              " عنوان المستخدم",
                              style: profileText,
                            ),
                            Divider(),
                            Text(
                              Repository.repository.appUser.age,
                              style: profileStyle,
                            ),
                            Text("العمر ", style: profileText),
                            Divider(),
                            Text(
                              Repository.repository.appUser.isMale,
                              style: profileStyle,
                            ),
                            Text("الجنس ", style: profileText),
                            Divider(),
                            Repository.repository.appUser.type ==
                                    userType.patient
                                ? Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        Repository.repository.appUser.state,
                                        style: profileStyle,
                                      ),
                                      Text(" الحالة الاجتماعية",
                                          style: profileText),
                                    ],
                                  )
                                : Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        Repository
                                            .repository.appUser.description,
                                        style: profileStyle,
                                      ),
                                      Text("  الخبرة العلمية",
                                          style: profileText),
                                    ],
                                  ),
                            Divider(),
                            Repository.repository.appUser.type ==
                                    userType.patient
                                ? Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      GestureDetector(
                                        onTap:_launchURL ,
                                        child: Text(
                                          Repository.repository.appUser.fileUrl,
                                          style: profileStyle,
                                        ),
                                      ),
                                      Text("  الملفات الطبية",
                                          style: profileText),
                                    ],
                                  )
                                : Container()
                          ],
                        ),
                      ),
                    )
                  ],
                )),
          ),
        ),
        floatingActionButton: Align(
          alignment: FractionalOffset(0.13, 0.98),
          child: FloatingActionButton(
            child: Icon(Icons.edit),
            onPressed: () {
                Repository.repository.appUser.type ==
                                    userType.patient
                                ? 
              Get.to(EditPatientProfile()) :
              Get.to(EditDoctorProfile());
            },
          ),
        ));
  }
}
