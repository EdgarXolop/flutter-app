import 'package:firebase_database/firebase_database.dart';

class JobProfile {
  String key;
  String name;
  String rate;
  String experience;
  String diagnostic;
  String phone;
  String type;
  
  JobProfile(this.name, this.rate, this.experience, this.diagnostic, this.phone, this.type);
  
  JobProfile.fromSnapshot(DataSnapshot snapshot) :
    key = snapshot.key,
    name = snapshot.value["name"],
    rate = snapshot.value["rate"],
    experience = snapshot.value["experience"],
    diagnostic = snapshot.value["diagnostic"],
    phone = snapshot.value["phone"],
    type = snapshot.value["type"];

  toJson() {
    return {
      "name": name,
      "rate": rate,
      "experience": experience,
      "diagnostic": diagnostic,
      "phone": phone,
      "type": type
    };
  }
}