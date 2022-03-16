


class DateApp {
  String dateTime ;
  String time ;
  String id ;
  String patientName;
  String doctorName;  
  String docId ;
DateApp(this.dateTime, this.time,  this.patientName ,this.doctorName , this.docId , this.id);

DateApp.fromMap(Map map) {
this.dateTime = map["dateTime"];
this.time = map["time"];
this.patientName = map["patientName"];
this.doctorName = map["doctorName"];
this.docId = map['docId'];
this.id = map["Id"];
}


}