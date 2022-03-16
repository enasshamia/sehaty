import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:graduation/backend/repositary.dart';
import 'package:graduation/backend/server.dart';
import 'package:graduation/models/user.dart';
import 'package:graduation/screen/appointment_screen.dart';
import 'package:graduation/screen/note_screen.dart';
import 'package:graduation/screen/notespatiwnt.dart';
import 'package:graduation/screen/patientRatingPage.dart';


import 'package:graduation/screen/profile.dart';
import 'package:graduation/screen/search_about_docotr_screen.dart';

import 'package:graduation/widget/drawercontent_widget.dart';
import 'package:graduation/widget/editPatient.dart';
class CustomeDrawerPatient extends StatefulWidget {
 
  @override
  _CustomeDrawerPatientState createState() => _CustomeDrawerPatientState();
}

class _CustomeDrawerPatientState extends State<CustomeDrawerPatient> {
userType type ;
  @override
  Widget build(BuildContext context) {
  Size size = MediaQuery.of(context).size;
    return Directionality(
      textDirection: TextDirection.rtl,
          child: Drawer(
        child: SingleChildScrollView(
          child: Column(
            children: [
              UserAccountsDrawerHeader(
                decoration: BoxDecoration(
                  color:Colors.blue[100]
                ),
                accountName: Text(Repository.repository.appUser.userName ,style: TextStyle(color: Colors.black,
                fontSize: 15 ,
                ),),
               accountEmail: Text(Repository.repository.appUser.email ,style: TextStyle(color: Colors.black,
                fontSize: 13 ,
                ),),
               currentAccountPicture: Repository.repository.appUser.logo != null ?
               CircleAvatar(backgroundImage: NetworkImage(Repository.repository.appUser.logo),)
               : CircleAvatar(child:FittedBox(child: Text(Repository.repository.appUser.userName[0])) ,)
               ),
            ContentDrawer(title: "الصفحة الرئيسية",icon: Icons.home,fun: () {
                
              
               Get.back();
             },),
              ContentDrawer(title: " الصفحة الشخصية",icon: Icons.home_filled , fun: () =>Get.to(ProfileScreen())
            ,),
               ContentDrawer(title: "تعديل البيانات الخاصة ",icon: Icons.edit,fun:() =>Get.to(EditPatientProfile())
               ),
         
               ContentDrawer(title: " البحث عن طبيب",icon: Icons.search, fun:() =>
                 Get.to(SearchAboutDoctorScreen())
                
               ,) ,

                ContentDrawer(title: "  المواعيد ",icon: Icons.date_range_sharp, fun:()=> Get.to(AppontmentsScreen())),
                  ContentDrawer(title: "  الملاحظات ",icon: Icons.note,fun: ()=>Get.to(NoteScreenPatient()),),
                    ContentDrawer(title: "  تقييماتي ",icon: Icons.star,fun: ()=>Get.to(PatientRating())),
                SizedBox(height: size.height*0.30,),
                 ContentDrawer(title: "  تسجيل الخروج ",icon: Icons.logout, fun: signOut,),
              
            ],
          ),
        ),
      ),
    );
  }
}




