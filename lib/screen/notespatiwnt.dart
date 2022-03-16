import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:graduation/backend/appProvider.dart';
import 'package:graduation/models/note.dart';

import 'package:provider/provider.dart';
import 'package:graduation/backend/server.dart';

class NoteScreenPatient extends StatefulWidget {
  @override
  _NoteScreenPatientState createState() => _NoteScreenPatientState();
}

class _NoteScreenPatientState extends State<NoteScreenPatient> {

  void initState() {
    super.initState();
getallNotepatient();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "قائمة الملاحظات",
            style: GoogleFonts.cairo(),
          ),
          centerTitle: true,
        ),
        body: Directionality(
          textDirection: TextDirection.rtl,
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 20 , vertical: 20),
            child: Selector<AppsProvider, List<Notes>>(
                builder: (context, value, child) {
              return value.isEmpty
                  ? Center(child: Text("لا يوجد ملاحظات ...."))
                  : ListView.builder(
                      itemCount: value.length,
                      itemBuilder: (context, index) {
                        return Card(
                          color: Color.fromRGBO(123, 173, 203, 1),
                      elevation: 5,
                          child:Container(
                            margin: EdgeInsets.symmetric(horizontal: 20 , vertical: 10),
                            child: Column (
                             crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("اسم المريض:  " + value[index].patientName , style: GoogleFonts.cairo(fontSize: 17,fontWeight: FontWeight.w700),), 
                                 Text("الملاحظة :  " + value[index].note,style: GoogleFonts.cairo(fontSize: 15,fontWeight: FontWeight.w600)),
                                  Text("اسم الدواء : "+ value[index].medical , style: GoogleFonts.cairo(fontSize: 15,fontWeight: FontWeight.w600)),
                                   Text("مكان لشراء الادوية : "+ value[index].location , style: GoogleFonts.cairo(fontSize: 15,fontWeight: FontWeight.w600)),
                            Row(children: [
                              Text("التاريخ : "+ value[index].dateTime , style: GoogleFonts.cairo(fontSize: 15,fontWeight: FontWeight.w600)),
                              SizedBox(width: 20,),
                               Text("الساعة : "+ value[index].time , style: GoogleFonts.cairo(fontSize: 15,fontWeight: FontWeight.w600))
                            ],)
                            
                              ],
                            ),
                          ),
                        );
                      });
            }, selector: (x, y) {
              return y.notespatient;
            }),
          ),
        ));
  }
}
