import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:graduation/backend/appProvider.dart';

import 'package:graduation/backend/server.dart';
import 'package:graduation/models/user.dart';

import 'package:graduation/screen/patientDetails.dart';

import 'package:graduation/widget/custome_drawerDoctor.dart';

import 'package:provider/provider.dart';

class HomePatientScreen extends StatefulWidget {
  @override
  _HomePatientScreenState createState() => _HomePatientScreenState();
}
notify() async {
  String timezom = await AwesomeNotifications()
      .getLocalTimeZoneIdentifier(); //get time zone you are in

  await AwesomeNotifications().createNotification(
    content: NotificationContent(
      id: 1,
      channelKey: 'key1',
      title: ' اشعار جديد ',
      body: "راجع قائمة المواعيد    ",
    ),
    schedule:
        NotificationInterval(interval: 1, timeZone: timezom, repeats: false),
  );
}

class _HomePatientScreenState extends State<HomePatientScreen> {
  @override
  void initState() {
    super.initState();
    getAllPatients();
    notify();

  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            "الصفحة الرئيسية ",
            style:  GoogleFonts.cairo() ,
          ),
        ),
        endDrawer: CustomeDrawerDocotor(),
        body: Directionality(
          textDirection: TextDirection.rtl,
          child: Container(
            margin: EdgeInsets.symmetric(
              horizontal: size.width * 0.03,
            ),
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(
                    top: size.height * 0.015,
                  ),
                  child: Text(
                    "صفحة المرضى المسجلين بالتطبيق",
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
                  ),
                ),
                Container(
                    margin: EdgeInsets.only(
                      bottom: size.height * 0.015,
                    ),
                    child: Text(
                      " لزيارة صفحة المريض : اضغط على الصورة الخاصة به",
                      style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 13,
                          color: Colors.grey),
                    )),
                Expanded(
                  child: Container(
                  
                    child: Selector<AppsProvider, List<AppUser>>(
                      builder: (context, value, child) {
                        return value.isEmpty
                            ? Center(child: CircularProgressIndicator())
                            : GridView.builder(
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2,
                                        mainAxisSpacing: 20,
                                        childAspectRatio: 0.9),
                                itemCount: value.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(
                                          size.width * 0.03),
                                      color: Colors.blue[50],
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.5),
                                          spreadRadius: 2,
                                          blurRadius: 5,
                                          offset: Offset(0,
                                              3), // changes position of shadow
                                        ),
                                      ],
                                    ),
                                    margin: EdgeInsets.symmetric(
                                        horizontal: size.width * 0.025),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            Get.to(patientDetailsScreen(
                                                value[index]));
                                          },
                                          child: Container(
                                            width: size.width * 0.33,
                                            height: size.height * 0.2,
                                            child: value[index].logo == null ?
                                          Container(
                                  width: size.width * 0.3,
                                  height: size.height * 0.15,
                                  child: CircleAvatar(
                                    child: FittedBox(
                                        child: Text(value[index].userName[0])),
                                  )): CircleAvatar(
                                              backgroundImage: NetworkImage(
                                                  value[index].logo),
                                            ),
                                          ),
                                        ),
                                        Text(value[index].userName,
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 15,
                                                fontWeight: FontWeight.w600))
                                      ],
                                    ),
                                  );
                                });
                      },
                      selector: (x, y) {
                        return y.patients;
                      },
                    ),
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
