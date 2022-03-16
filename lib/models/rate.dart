

class Rate {
  String commnet ;
  String rateing ;
String id ;
String doctorname ;
  Rate(this.rateing , this.commnet , this.doctorname , );
Rate.fromMap(Map map) {
    this.commnet = map['comment'];
    this.rateing = map['rate'];
    this.id = map['id'];
    this.doctorname = map ["doctorname"];
    
  }
  toMap() {
    return {
      'comment': this.commnet,
      'rate': this.rateing,
      'id': id ,
      "doctorname" :doctorname ,
    };
  }
}