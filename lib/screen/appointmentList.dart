import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:graduation/backend/appProvider.dart';
import 'package:graduation/backend/server.dart';
import 'package:graduation/models/date.dart';
// ignore: unused_import
import 'package:graduation/style/colors.dart';
import 'package:provider/provider.dart';

class AppointemtsList extends StatefulWidget {
  String docName;

  AppointemtsList(this.docName);
  @override
  _AppointemtsListState createState() => _AppointemtsListState();
}

class _AppointemtsListState extends State<AppointemtsList> {
  String note ;
  String medication ;
  String location ;
  void initState() {
    super.initState();
    getALLappintmentList();
  }

  showAlertDialog(BuildContext context, String id) {
    // set up the buttons
    Widget cancelButton = TextButton(
      child: Text("لا"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
    Widget continueButton = TextButton(
      child: Text("نعم"),
      onPressed: () async {
        deletepending(id);
        Navigator.of(context).pop();
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(" تأكيد الحذف",
          textDirection: TextDirection.rtl, style: GoogleFonts.cairo()),
      content: Text(
        "هل أنت متاكد من حذف الموعد ؟ ",
        textDirection: TextDirection.rtl,
        style: GoogleFonts.cairo(),
      ),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  
  addNotes(String patiantName ,String dateTime , String time,String id ) {
    addNote(this.note, widget.docName, patiantName,dateTime ,time , id ,this.medication ,this.location);
    Get.defaultDialog(
      title: 'تم ارسال الملاحظة',
      titleStyle: TextStyle(color: Colors.red[400], fontSize: 18),
      content: Text(""),
      textCancel: "خروج",
      backgroundColor: Colors.grey[800],
      cancelTextColor: Colors.white,
      buttonColor: Colors.blue[100],
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "قائمة المواعيد ",
          style: GoogleFonts.cairo(),
        ),
        centerTitle: true,
      ),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: Container(
          margin: EdgeInsets.symmetric(
              vertical: size.height * 0.03, horizontal: size.width * 0.02),
          child: Selector<AppsProvider, List<DateApp>>(
            builder: (context, value, child) {
              return value.isEmpty
                  ? Center(child: CircularProgressIndicator())
                  : ListView.builder(
                      scrollDirection: Axis.vertical,
                      physics: ClampingScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: value.length,
                      itemBuilder: (context, index) {
                        return Card(
                          elevation: 5,
                          child: InkWell(
                            onTap: () {},
                            child: ExpansionTile(
                              title: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 5),
                                    child: Text(
                                      "د.  " + value[index].doctorName,
                                      style: GoogleFonts.cairo(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    value[index].time.toString(),
                                    style: GoogleFonts.cairo(
                                        color: Colors.green,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(
                                    width: 0,
                                  ),
                                ],
                              ),
                              subtitle: Padding(
                                padding: const EdgeInsets.only(left: 5),
                                child: Text(
                                  value[index].dateTime,
                                  style: GoogleFonts.cairo(),
                                ),
                              ),
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      bottom: 20, right: 10, left: 16),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "اسم المريض: " +
                                                value[index].patientName,
                                            style: GoogleFonts.cairo(
                                              fontSize: 16,
                                            ),
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Text(
                                            "الساعة:  " + value[index].time,
                                            style: GoogleFonts.cairo(
                                              fontSize: 16,
                                            ),
                                          ),
                                        ],
                                      ),
                                      IconButton(
                                        tooltip: 'Delete Appointment',
                                        icon: Icon(
                                          Icons.delete,
                                          color: Colors.black87,
                                        ),
                                        onPressed: () {
                                          showAlertDialog(
                                              context, value[index].id);
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: size.height * 0.001,
                                ),
                                Container(
                                  margin: EdgeInsets.symmetric(
                                      horizontal: size.width * 0.03),
                                  child: Form(
                                    key: _formKey,
                                    child: Column(children: [
                                      TextFormField(
                                      onSaved: (String value) {
                                        this.note = value ;
                                      },
                                        decoration: new InputDecoration(
                                          contentPadding: EdgeInsets.symmetric(
                                              horizontal: 10),
                                          labelText: "ملاحظات",
                                          fillColor: Colors.white,
                                          border: new OutlineInputBorder(
                                            borderRadius:
                                                new BorderRadius.circular(10),
                                            borderSide: new BorderSide(),
                                          ),
                                        )),
                                          SizedBox(
                                  height: size.height * 0.01,
                                ),
                                        TextFormField(
                                      onSaved: (String value) {
                                        this.medication = value ;
                                      },
                                        decoration: new InputDecoration(
                                          contentPadding: EdgeInsets.symmetric(
                                              horizontal: 10),
                                          labelText: "اضافة الدواء",
                                          fillColor: Colors.white,
                                          border: new OutlineInputBorder(
                                            borderRadius:
                                                new BorderRadius.circular(10),
                                            borderSide: new BorderSide(),
                                          ),
                                        )),
                                           SizedBox(
                                  height: size.height * 0.01,
                                ),
                                           TextFormField(
                                      onSaved: (String value) {
                                        this.location = value ;
                                      },
                                        decoration: new InputDecoration(
                                          contentPadding: EdgeInsets.symmetric(
                                              horizontal: 10),
                                          labelText: "اضافة اماكن لشراء الدواء",
                                          fillColor: Colors.white,
                                          border: new OutlineInputBorder(
                                            borderRadius:
                                                new BorderRadius.circular(10),
                                            borderSide: new BorderSide(),
                                          ),
                                        )),
                                    ],), 
                                        
                                  ),
                                ),
                                SizedBox(
                                  height: size.height * 0.02,
                                ),
                                Container(
                                  width: size.width * 0.8,
                                  child: TextButton(
                                    onPressed: () {
                                     if(_formKey.currentState.validate()) {
                                        _formKey.currentState.save();
                                         addNotes(value[index].patientName,
                                         value[index].dateTime ,
                                          value[index].time,
                                          value[index].id);
                                         print(value[index].id);
                                      }
                                    }
                                     
                                    ,
                                    child: Text(" ارسال ",
                                        style: GoogleFonts.cairo(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w700,
                                            fontSize: 15)),
                                    style: TextButton.styleFrom(
                                        backgroundColor:
                                            Color.fromRGBO(123, 173, 203, 1)),
                                  ),
                                ),
                                SizedBox(
                                  height: size.height * 0.02,
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
            },
            selector: (x, y) {
              return y.datelist;
            },
          ),
        ),
      ),
    );
  }
}
