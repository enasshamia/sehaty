
import 'package:custom_navigation_bar/custom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:graduation/backend/appProvider.dart';
import 'package:graduation/models/user.dart';
import 'package:graduation/screen/bookAppointments_screen.dart';
import 'package:graduation/style/colors.dart';
import 'package:graduation/widget/fullImage_widget.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class patientDetailsScreen extends StatefulWidget {
  
AppUser appUser;

  patientDetailsScreen(this.appUser);

  @override
  _patientDetailsScreenState createState() => _patientDetailsScreenState();
}

class _patientDetailsScreenState extends State<patientDetailsScreen> {
  callDoctor(String phone) async {
    if (phone.startsWith("0599") &&
            await canLaunch(
              "tel:$phone",
            ) ||
        phone.startsWith("0599")) {
      await launch("tel:$phone");
    } else {
      Get.defaultDialog(
        title: 'خطأ',
        titleStyle: TextStyle(color: Colors.red[400], fontSize: 18),
        content: Text("الرقم غير صحيح ",
            style: TextStyle(color: Colors.white, fontSize: 15)),
        textCancel: "خروج",
        backgroundColor: Colors.grey[800],
        cancelTextColor: Colors.white,
        buttonColor: Colors.blue[100],
      );
    }
  }

  sendSms(String number) async {
    String url = 'sms:$number';
    if (number.startsWith("0599") && await canLaunch(url)) {
      await launch(url);
    } else {
      Get.defaultDialog(
        title: 'خطأ',
        titleStyle: TextStyle(color: Colors.red[400], fontSize: 18),
        content: Text("الرقم غير صحيح ",
            style: TextStyle(color: Colors.white, fontSize: 15)),
        textCancel: "خروج",
        backgroundColor: Colors.grey[800],
        cancelTextColor: Colors.white,
        buttonColor: Colors.blue[100],
      );
    }
  }

  callWhatsUp(String phone) async {
    var whatsappUrl = "whatsapp://send?phone=/+$phone";
    await canLaunch(whatsappUrl)
        ? launch(whatsappUrl)
        : Get.defaultDialog(
            title: 'خطأ',
            titleStyle: TextStyle(color: Colors.red[400], fontSize: 18),
            content: Text("    يرجى تنزيل تطبيق الواتس لدى جهازك ",
                style: TextStyle(color: Colors.white, fontSize: 15)),
            textCancel: "خروج",
            backgroundColor: Colors.grey[800],
            cancelTextColor: Colors.white,
            buttonColor: Colors.blue[100],
          );
  }
    _launchURL() async {
  final  url =  widget.appUser.fileUrl;
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}

  sendEmail(String myEmail) async {
    Uri uri = Uri(
      scheme: 'mailto',
      path: myEmail,
    );
    if (await canLaunch(
      uri.toString(),
    )) {
      await launch(uri.toString());
    } else {
      print("can not open url");
    }
  }
  @override
  Widget build(BuildContext context) {
     Size size = MediaQuery.of(context).size;
    return  Scaffold(
      bottomNavigationBar: Selector<AppsProvider, int>(
        selector: (x, y) {
          return y.navIndex;
        },
        builder: (context, value, child) {
          return CustomNavigationBar(
            backgroundColor: Colors.grey[800],
            selectedColor: Colors.white,
            strokeColor: Colors.white,
            iconSize: 20,
            unSelectedColor: Colors.blue[200],
            borderRadius: Radius.circular(size.width * 0.02),
            isFloating: true,
            onTap: (value) {
              Provider.of<AppsProvider>(context, listen: false)
                  .changeIndex(value);
              switch (value) {
                case 0:
                  callDoctor(widget.appUser.mobileNumber);
                  break;
                case 1:
                  sendSms(widget.appUser.mobileNumber);
                  break;
                case 2:
                  callWhatsUp(widget.appUser.mobileNumber);
                  break;
                case 3:
                  sendEmail(widget.appUser.email);
                  break;
              }
            },
            currentIndex: value,
            items: [
              CustomNavigationBarItem(
                icon: Icon(Icons.call_outlined),
                title: Text(
                  "اتصال",
                  style: TextStyle(color: Colors.blue[200], fontSize: 12),
                ),
              ),
              CustomNavigationBarItem(
                icon: Icon(Icons.sms_outlined),
                title: Text("رسالة",
                    style: TextStyle(color: Colors.blue[200], fontSize: 12)),
              ),
              CustomNavigationBarItem(
                icon: Icon(Icons.call_end_rounded),
                title: Text("واتس اب",
                    style: TextStyle(color: Colors.blue[200], fontSize: 12)),
              ),
              CustomNavigationBarItem(
                icon: Icon(Icons.email_outlined),
                title: Text(" ايميل",
                    style: TextStyle(color: Colors.blue[200], fontSize: 12)),
              ),
            ],
          );
        },
      ),
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
        elevation: 0.0,
        brightness: Brightness.dark,
      ),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: SingleChildScrollView(
                  child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Stack(
                children: <Widget>[
                  GestureDetector(
                    onTap: () {
                      Get.to(FullImage(
                          widget.appUser.logo, widget.appUser.userName));
                    },
                    child: Container(
                        width: size.width,
                        height: size.height * 0.35,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: NetworkImage(widget.appUser.logo),
                            fit: BoxFit.cover,
                          ),
                        ),
                        child: null),
                  ),
                ],
              ),
              Container(
                padding: EdgeInsets.symmetric(
                    horizontal: size.width * 0.05, vertical: size.height * 0.015),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Card(
                      child: ListTile(
                        title: Text(
                          widget.appUser.userName,
                          style: profileStyle,
                        ),
                        trailing: Icon(Icons.person),
                      ),
                      color: Colors.grey[200],
                      margin: EdgeInsets.symmetric(vertical: size.height * 0.01),
                    ),
                    Card(
                        child: ListTile(
                          title: Text(
                            widget.appUser.email,
                            style: profileStyle,
                          ),
                          trailing: Icon(Icons.email),
                        ),
                        color: Colors.grey[200],
                        margin:
                            EdgeInsets.symmetric(vertical: size.height * 0.01)),
                    Card(
                        child: ListTile(
                          title: Text(
                            widget.appUser.mobileNumber,
                            style: profileStyle,
                          ),
                          trailing: Icon(Icons.phone_android),
                        ),
                        color: Colors.grey[200],
                        margin:
                            EdgeInsets.symmetric(vertical: size.height * 0.01)),
                    Card(
                        child: ListTile(
                          title: Text(
                            widget.appUser.state,
                            style: profileStyle,
                          ),
                          trailing: Icon(Icons.place),
                        ),
                        color: Colors.grey[200],
                        margin:
                            EdgeInsets.symmetric(vertical: size.height * 0.01)),
                    Card(
                        child: ListTile(
                          title: Text(
                            widget.appUser.age,
                            style: profileStyle,
                          ),
                          trailing: Icon(Icons.cast_for_education),
                        ),
                        color: Colors.grey[200],
                        margin:
                            EdgeInsets.symmetric(vertical: size.height * 0.01)),
                            
                        Card(
                        child: ListTile(
                          title: Text(
                            widget.appUser.address,
                            style: profileStyle,
                          ),
                          trailing: Icon(Icons.cast_for_education),
                        ),
                        color: Colors.grey[200],
                        margin:
                            EdgeInsets.symmetric(vertical: size.height * 0.01)),
                                Card(
                        child: GestureDetector(
                          onTap: _launchURL,
                          child: ListTile(
                            title: Text(
                              widget.appUser.fileUrl,
                              style: profileStyle,
                            ),
                            trailing: Icon(Icons.cast_for_education),
                          ),
                        ),
                        color: Colors.grey[200],
                        margin:
                            EdgeInsets.symmetric(vertical: size.height * 0.01)),
                            
                            
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}