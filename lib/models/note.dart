
class Notes {
  String note; 
  String id ;
  String docName;
  String patientName;
  String patientId ;
  String dateTime ;
  String time ;
  String medical ;
  String location ;
  Notes(this.note , this.docName, this.patientName ,this.patientId,this.dateTime , this.time ,this.medical ,this.location);
  
Notes.fromMap(Map map) {

this.note = map["note"];
this.id = map["Id"];
this.docName = map["docName"];
this.patientName=map["patienName"];
this.patientId = map['patientId'];
this.dateTime=map["dateTime"];
this.time=map["time"];
this.medical = map["medical"];
this.location = map['location'];

}
}