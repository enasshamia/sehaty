import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:graduation/models/date.dart';
import 'package:graduation/models/note.dart';
import 'package:graduation/models/rate.dart';
import 'package:graduation/models/user.dart';
class AppsProvider extends ChangeNotifier  {
  AppUser appUser ; 

  setUsers(AppUser appUser) {
    this.appUser = appUser ;
    notifyListeners();
  }
  File file;
  setFile(File file) {
    this.file = file;
    notifyListeners();
  }
  List <AppUser> doctor =[] ;
  setAllDoctor(List <AppUser> doctor) {
this.doctor = doctor ;
notifyListeners();
  }
  List <AppUser> patients =[] ;
  setAllPatient(List <AppUser> patients) {
this.patients = patients ;
notifyListeners();
  }
   int navIndex = 0;
  changeIndex(int value) {
    this.navIndex = value;
    notifyListeners();
  }

  // DateTime selectDate = DateTime.now()  ;
  // changeDate(DateTime dateTime) {
  //   this.selectDate = dateTime ;
  //    notifyListeners();
  // }
  
  List <DateApp> dateApp = [] ; 
  setDate (List<DateApp> dateApp) {
    this.dateApp =dateApp ;
    notifyListeners();
  }
  List <Notes> notes = [] ;
  setNote(List <Notes> notes) {
this.notes = notes ;
notifyListeners();
  }
  List <Notes> notespatient = [] ;
setNotepatient(List <Notes> notespatient) {
  this.notespatient = notespatient;
  notifyListeners();
}
  List <DateApp> datelist = [] ; 
  setDateList (List<DateApp> datelist) {
    this.datelist =datelist ;
    notifyListeners();
  }

  List <Rate>rate  = [];
  setRating (List <Rate> rate) {
this.rate = rate ;
  }

  
  List <Rate> rates = [] ;
  SetRate(List <Rate> rates) {
    this.rates = rates ;
  }
}