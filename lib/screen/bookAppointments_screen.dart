import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:graduation/backend/repositary.dart';

import 'package:graduation/backend/server.dart';


import 'package:intl/intl.dart' as i;

class BookAppintmentScreen extends StatefulWidget {
  String nameDo;
  String idNo;
String id;
  BookAppintmentScreen(this.nameDo, this.idNo ,this.id);
  @override
  _BookAppintmentScreenState createState() => _BookAppintmentScreenState();
}

class _BookAppintmentScreenState extends State<BookAppintmentScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  DateTime _selectedDate = DateTime.now();
  String doctorName;
  TextEditingController _textEditingController = TextEditingController();
  TextEditingController _textEditingController2 = TextEditingController();



  // DateTime currentDate = DateTime.now();
  TimeOfDay _selectedTime = TimeOfDay.now();

  showLoaderDialog(BuildContext context) {
    AlertDialog alert = AlertDialog(
      content: new Row(
        children: [
          CircularProgressIndicator(),
          Container(
              margin: EdgeInsets.only(left: 15), child: Text("جاري ججز موعد...")),
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

  _pickedData(context  ) async{
   
    showLoaderDialog(context);
   await  addAppontments(_textEditingController.text, _textEditingController2.text,
       Repository.repository.appUser.userName, widget.nameDo, widget.idNo , widget.id);
    Get.back();
    Notify(widget.nameDo);

  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
          title: Text(
        " حجز مواعيد " ,
        style: GoogleFonts.cairo(color: Colors.white),
      )
      ),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: Container(
          margin: EdgeInsets.symmetric(
              horizontal: size.width * 0.08, vertical: size.height * 0.03),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "اسم الدكتور :",
                      style: GoogleFonts.cairo(
                          fontWeight: FontWeight.w700, fontSize: 15),
                    ),
                    SizedBox(
                      width: size.width * 0.02,
                    ),
                    Text(widget.nameDo,
                        style: GoogleFonts.cairo(
                            fontWeight: FontWeight.w700, fontSize: 15))
                  ],
                ),
                SizedBox(
                  height: size.height * 0.03,
                ),
               Container(
                 margin: EdgeInsets.symmetric(horizontal: 11),
                 
                 child: Row(children: [
                   Icon(Icons.person),
                   SizedBox(
                  width: size.width * 0.03,
                ),
                    Text(Repository.repository.appUser.userName)
                 ]),
               ),
                SizedBox(
                  height: size.height * 0.03,
                ),
                TextFormField(
                  decoration: InputDecoration(
                      prefixIcon: Icon(Icons.calendar_today),
                      hintText: i.DateFormat.yMd().format(_selectedDate)),
                  focusNode: AlwaysDisabledFocusNode(),
                  validator: (value) {
                    if (value.isEmpty) return 'يرجى ادخال تاريخ الحجز';
                    return null;
                  },
                  controller: _textEditingController,
                  onTap: () {
                    _selectDate(context);
                  },
                ),
                SizedBox(
                  height: size.height * 0.008,
                ),
                TextFormField(
                  decoration: InputDecoration(
                      prefixIcon: Icon(Icons.timer),
                      hintText:
                          "${_selectedTime.hour} : ${_selectedTime.minute}"),
                  focusNode: AlwaysDisabledFocusNode(),
                  controller: _textEditingController2,
                  validator: (value) {
                    if (value.isEmpty) return 'يرجى ادخال وقت الحجز';
                    return null;
                  },
                  onTap: () {
                    _selectTime(context);
                  },
                ),
                Container(
                  margin: EdgeInsets.only(top: size.height * 0.02),
                  width: size.width * 0.8,
                  child: TextButton(
                    onPressed: () {
                      if (_formKey.currentState.validate()) {
                        _formKey.currentState.save();
                        _pickedData(context);
                      }
                    },
                    child: Text(
                      " اضغط هنا لتأكيد الحجز",
                      style: GoogleFonts.cairo(color: Colors.white),
                    ),
                    style:
                        TextButton.styleFrom(backgroundColor:  Color.fromRGBO(123, 173, 203, 1),)
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _selectDate(BuildContext context) async {
    DateTime newSelectedDate = await showDatePicker(
        context: context,
        initialDate: _selectedDate,
        firstDate: DateTime(2000),
        lastDate: DateTime(2040),
        builder: (BuildContext context, Widget child) {
          return Theme(
            data: ThemeData.dark().copyWith(
              colorScheme: ColorScheme.dark(
                primary: Colors.deepPurple,
                onPrimary: Colors.white,
                surface: Colors.blue[100],
                onSurface: Colors.white,
              ),
              dialogBackgroundColor: Colors.blue[500],
            ),
            child: child,
          );
        });

    if (newSelectedDate != null) {
      _selectedDate = newSelectedDate;
      _textEditingController
        ..text = i.DateFormat.yMd().format(_selectedDate)
        ..selection = TextSelection.fromPosition(TextPosition(
            offset: _textEditingController.text.length,
            affinity: TextAffinity.upstream));
    }
  }

  _selectTime(BuildContext context) async {
    TimeOfDay picked = await showTimePicker(
        context: context,
        initialTime: _selectedTime,
      
        builder: (BuildContext context, Widget child) {
          return Theme(
            data: ThemeData.dark().copyWith(
              colorScheme: ColorScheme.dark(
                primary: Colors.deepPurple,
                onPrimary: Colors.white,
                surface: Colors.blue[100],
                onSurface: Colors.white,
              ),
              dialogBackgroundColor: Colors.blue[500],
            ),
            child: child,
          );
        });
    if (_selectedTime != null) {
      _selectedTime = picked;
      _textEditingController2
        ..text = "${_selectedTime.hour} : ${_selectedTime.minute}"
        ..selection = TextSelection.fromPosition(TextPosition(
            offset: _textEditingController2.text.length,
            affinity: TextAffinity.upstream));
    }
  }
}

Notify(String name) async {
  String timezom = await AwesomeNotifications()
      .getLocalTimeZoneIdentifier(); //get time zone you are in

  await AwesomeNotifications().createNotification(
    content: NotificationContent(
      id: 1,
      channelKey: 'key1',
      title: 'تم حجز الموعد',
      body: "تم حجز موعد مع الطبيب $name",
    ),
    schedule:
        NotificationInterval(interval: 1, timeZone: timezom, repeats: false),
  );
}

class AlwaysDisabledFocusNode extends FocusNode {
  @override
  bool get hasFocus => false;
}
