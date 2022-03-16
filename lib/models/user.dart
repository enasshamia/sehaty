import 'dart:io';

enum userType { docotr, patient }

class AppUser {
  String userId;
  String address;
  String userName;
  String email;
  String password;
  String mobileNumber;
  String logo;
  String fileUrl;
  String age;
  String description;
  String isMale;
  String state;
  userType type;
  AppUser(
      {this.email,
      this.userName,
      this.mobileNumber,
      this.password,
      this.userId,
      this.age,
      this.description,
      this.isMale,
      this.state,
      this.type});

  factory AppUser.newUser(Map map) {
    bool isDoctor = map['isDoctor'] ?? false;
    if (isDoctor) {
      return AppUser.doctorUser(map);
    } else {
      return AppUser.patientUser(map);
    }
  }
  AppUser.doctorUser(Map map) {
    this.userId = map['userId'];
    this.email = map['email'];
    this.userName = map['userName'];
    this.password = map['password'] ?? '';
    this.mobileNumber = map['mobileNumber'];
    this.address = map['address']; 
    this.logo = map["logo"]  ;
    this.age = map['age'];
    this.description = map["description"];
    this.type = userType.docotr;
    this.isMale = map['isMale'];
  }
  AppUser.patientUser(Map map) {
    this.email = map['email'];
     this.userId = map['userId'];
    this.userName = map['userName'];
    this.password = map['password'] ?? '';
    this.mobileNumber = map['mobileNumber'];
    this.logo = map["logo"];
    this.age = map['age'];
    this.address = map['address'];
    this.type = userType.patient;
    this.isMale = map['isMale'];
    this.fileUrl = map['fileUrl'];
    this.state = map["state"];
  }
  toJson() {
    return type == userType.docotr
        ? {
            'email': this.email,
            'userName': this.userName,
            'password': this.password,
            'mobileNumber': this.mobileNumber,
            "logo": this.logo,
            "address": this.address,
            "age": this.age,
            "description": this.description,
            'isDoctor': true,
            "isMale": this.isMale,
          }
        : {
            'email': this.email,
            'userName': this.userName,
            'password': this.password,
            'mobileNumber': this.mobileNumber,
            'logo': this.logo,
            "age": this.age,
            'address': this.address,
            "isMale": this.isMale,
            'fileUrl': this.fileUrl,
            'isPatient': true,
            "state": this.state,
          };
  }
}
