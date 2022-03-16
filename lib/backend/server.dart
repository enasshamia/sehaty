
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:graduation/backend/appProvider.dart';
import 'package:graduation/backend/repositary.dart';
import 'package:graduation/models/date.dart';
import 'package:graduation/models/note.dart';
import 'package:graduation/models/rate.dart';
import 'package:graduation/screen/home_doctor_screen.dart';
import 'package:graduation/widget/custome_dialog.dart';
import 'package:provider/provider.dart';
import '../screen/home_patient_screen.dart';
import 'package:graduation/models/user.dart';
import '../screen/welcome_screen.dart';

FirebaseAuth auth = FirebaseAuth.instance;
FirebaseFirestore firestore = FirebaseFirestore.instance;
FirebaseStorage storage = FirebaseStorage.instance;

Future<String> registerUseingEmailAndPassword(
    String email, String password) async {
  try {
    UserCredential userCredential = await auth.createUserWithEmailAndPassword(
        email: email, password: password);
    return userCredential.user.uid;
  } on Exception catch (e) {
    print("ërror");
  }
}

Future<String> loginUsingEmailAndPassword(String email, String password, BuildContext context) async {

   try {
     UserCredential userCredential =
       await auth.signInWithEmailAndPassword(email: email, password: password);
       DocumentSnapshot documentSnapshot =
        await firestore.collection("users").doc(userCredential.user.uid).get();
       Map map = documentSnapshot.data();
       map['userId'] = userCredential.user.uid;
     AppUser appUser = AppUser.newUser(map);
       Repository.repository.appUser = appUser;
       bool isDoctor = appUser.type == userType.docotr;
       bool isPatient = appUser.type == userType.patient;
       if (isDoctor) {
      Get.off(HomePatientScreen());
       } else {
      Get.off(HomeDoctorScreen());
       }
   }on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        CustomDialoug.customDialoug.showCustomDialoug(
            context, 'خطأ', 'البريد الالكتروني غير مسجل بالتطبيق');
      } else if (e.code == 'wrong-password') {
        CustomDialoug.customDialoug.showCustomDialoug(
            context, 'خطأ', 'كلمة المرور خاطئة , يرجى اعادة ادخالها .');
      }
    } catch (e) {
      CustomDialoug.customDialoug
          .showCustomDialoug(context, 'Error', e.toString());
    }
    }


  resetpassword(String email) async {
    await auth.sendPasswordResetEmail(email: email);
  }
///////////////////////////////////////////////////////////////

signOut() {
  File file;
  FirebaseAuth.instance.signOut();
  Get.off(WelcomeScreen());
}
///////////////////////////////////////////////////////////////
fetchData() async {
  AppUser appUser = await getUserFromFirebase();
  Repository.repository.appUser = appUser;
  bool isDoctor = appUser.type == userType.docotr;
  bool isPatient = appUser.type == userType.patient;
  if (isDoctor) {
    Get.off(HomePatientScreen());
  } else {
    Get.off(HomeDoctorScreen());
  }
}

//////////////////////////////////////////////////////////////////////////////////////
saveUserInFirestore(AppUser appUser) async {
  try {
    String userId =
        await registerUseingEmailAndPassword(appUser.email, appUser.password);
    Map map = appUser.toJson();
    map.remove("password");
    print(map);
    bool isDoctor = appUser.type == userType.docotr;
    bool isPatient = appUser.type == userType.patient;
    if (isDoctor || isPatient) {
      map['logo'] = await uploadImage(
          Provider.of<AppsProvider>(Get.context, listen: false).file);
      appUser.logo = map["logo"];
    }

    await firestore.collection("users").doc(userId).set(map);
    Repository.repository.appUser = appUser;

    if (isDoctor) {
      Get.off(HomePatientScreen());
    } else {
      Get.off(HomeDoctorScreen());
    }
  } on Exception catch (e) {
    print(e);
  }
}

///////////////////////////////////////////////////////////////////////////
getUserId() {
  String userId = auth.currentUser != null ? auth.currentUser.uid : null;
  return userId;
}

//////////////////////////////////////////////////////////////////////////////////////////////
Future<AppUser> getUserFromFirebase() async {
  String userId = getUserId();
  DocumentSnapshot documentSnapshot =
      await firestore.collection("users").doc(userId).get();
  Map map = documentSnapshot.data();
  map["userId"] = userId;
  AppUser appUser = AppUser.newUser(map);

  return appUser;
}

////////////////////////////////////////////////////////////////////
Future<String> uploadImage(File file, [bool isPatint = false]) async {
  String fileName = file.path.split('/').last;
  Reference reference = storage.ref("/images/$fileName");
  await reference.putFile(file);
  String imageUrl = await reference.getDownloadURL();
  return imageUrl;
}

///////////////////////////////////////////////////////////////////////////////
getAllDoctors() async {
  QuerySnapshot querySnapshot = await firestore
      .collection("users")
      .where("isDoctor", isEqualTo: true)
      .get();
  List<AppUser> doctor = querySnapshot.docs.map((e) {
    Map map = e.data();
    map['userId'] = e.id;
    return AppUser.doctorUser(map);
  }).toList();
  Provider.of<AppsProvider>(Get.context, listen: false).setAllDoctor(doctor);
}

//////////////////////////////////////////////////////////////////////////////////
getAllPatients() async {
  QuerySnapshot querySnapshot = await firestore
      .collection("users")
      .where("isPatient", isEqualTo: true)
      .get();
  List<AppUser> patient = querySnapshot.docs.map((e) {
    Map map = e.data();
    map['userId'] = e.id;
    return AppUser.patientUser(map);
  }).toList();
  Provider.of<AppsProvider>(Get.context, listen: false).setAllPatient(patient);
}
////////////////////////////////////////////////////////////////////////
addNote(String note , String docName , String patiantName ,
String dateTime,String time ,String id ,String medical
,String location
)async {

await firestore.collection("Notes").add({
  "note": note,
  "docName" : docName ,
  "patienName" :patiantName ,
  "dateTime":dateTime,
  "time":time,
  "id" :id ,
  "medical" :medical ,
  "location":location
  

});
}
addRating (String comment , String rateing, String doctorname)async {
await firestore.collection("rating").add({
  'comment': comment,
      'rate': rateing,
      'id': auth.currentUser.uid ,
      "doctorname" :doctorname ,
});

getRatingPatient(auth.currentUser.uid);

}
getRating ()async {
   QuerySnapshot querySnapshot = await 
   firestore.collection("rating")
   .get();
  List<Rate> rates = querySnapshot.docs.map((e) {
    Map map = e.data();
    map['id'] = e.id;
    return Rate.fromMap(map);
  }).toList();
  Provider.of<AppsProvider>(Get.context, listen: false).setRating(rates);
}




getRatingPatient (String id)async {
   QuerySnapshot querySnapshot = await 
   firestore.collection("rating").where("id" , isEqualTo:auth.currentUser.uid).get();
  List<Rate> rate = querySnapshot.docs.map((e) {
    Map map = e.data();
    map['id'] = e.id;
    return Rate.fromMap(map);
  }).toList();
  Provider.of<AppsProvider>(Get.context, listen: false).SetRate(rate);
}



///////////////////////////////////////////////////////////////////////////////////////////
addAppontments(
    String dates, String time, String name, String names, String idDoc ,String id ) async {
  DocumentReference d = await firestore
      .collection('users')
      .doc(auth.currentUser.uid)
      .collection("Appointments")
      .add({
    "dateTime": dates,
    "time": time,
    "patientName": name,
    "doctorName": names,
    "docId": idDoc,
    "id":auth.currentUser.uid

 
  });

  DocumentReference dd =
      await firestore.collection('users').doc(idDoc).collection("pending").add({
    "dateTime": dates,
    "time": time,
    "patientName": name,
    "doctorName": names,
    "docId": idDoc,
    "id":auth.currentUser.uid

   
  });
  
  Get.back();
}

getALLappintmentList() async {
  QuerySnapshot querySnapshot = await firestore
      .collection('users')
      .doc(auth.currentUser.uid)
      .collection('pending')
      .orderBy('dateTime', descending: true)
      .get();
  List<DateApp> date = querySnapshot.docs.map((e) {
    Map map = e.data();
    map['Id'] = e.id;
    return DateApp.fromMap(map);
  }).toList();
  Provider.of<AppsProvider>(Get.context, listen: false).setDateList(date);
}
/////////////////////////////////////////////////////////////////////
getallNote() async {
   QuerySnapshot querySnapshot = await firestore
      .collection('Notes')
      .get();
  List<Notes> notes = querySnapshot.docs.map((e) {
    Map map = e.data();
    map['Id'] = e.id;
    return Notes.fromMap(map);
  }).toList();
  Provider.of<AppsProvider>(Get.context, listen: false).setNote(notes);
}

getallNotepatient() async {
  print(Repository.repository.appUser.userName);
 QuerySnapshot  querySnapshot = await firestore.collection('Notes')
      .where("patienName" , isEqualTo:Repository.repository.appUser.userName).get();
  List<Notes> notesPatient = querySnapshot.docs.map((e) {
    Map map = e.data();
    map['Id'] = e.id;
    return Notes.fromMap(map);
  }).toList();
  Provider.of<AppsProvider>(Get.context, listen: false).setNotepatient(notesPatient);
}



//////////////////////////////////////////////////////////////////////////////////////////
getALLappintments() async {
  QuerySnapshot querySnapshot = await firestore
      .collection('users')
      .doc(auth.currentUser.uid)
      .collection('Appointments')
      .orderBy('dateTime', descending: true)
      .get();
  List<DateApp> dates = querySnapshot.docs.map((e) {
    Map map = e.data();
    map['Id'] = e.id;
    return DateApp.fromMap(map);
  }).toList();
  Provider.of<AppsProvider>(Get.context, listen: false).setDate(dates);
}

///////////////////////////////////////////////////////////
deleteAppintments(String id) async {
  await firestore
      .collection('users')
      .doc(auth.currentUser.uid)
      .collection('Appointments')
      .doc(id)
      .delete().then((value) => print("User's Property Deleted"))
    .catchError((error) => print("Failed to delete user's property: $error"));;
      getALLappintments();
  
}
deletepending(String id) async {
  await firestore
      .collection('users')
      .doc(auth.currentUser.uid)
      .collection('pending')
      .doc(id)
      .delete();
      getALLappintmentList();
    
}

////////////////////////////////////////////////////
editProfileinFirebase(Map map) async {

  String imageUrl =  await uploadImage(
      Provider.of<AppsProvider>(Get.context, listen: false).file);

  map['logo'] = imageUrl;
  //String userId =getUserId();
  firestore.collection("users").doc(auth.currentUser.uid).update({...map}); 
print("erererrerer");
 fetch();

}////////////////////////////////////////////////////////////

fetch()async {
AppUser appUser = await getUserFromFirebase();
  Repository.repository.appUser = appUser;
}
/////////////////////////////////////////////////////////////////////////////////////////////////

