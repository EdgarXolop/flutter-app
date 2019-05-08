import 'package:firebase_database/firebase_database.dart';

class JobProfile {
  String key;
  String avatar;
  String name;
  double rate;
  String experience;
  String diagnostic;
  String phone;
  String type;
  
  JobProfile(this.name, this.avatar, this.rate, this.experience, this.diagnostic, this.phone, this.type);
  
  JobProfile.fromSnapshot(DataSnapshot snapshot) :
    key = snapshot.key,
    name = snapshot.value["name"],
    avatar = snapshot.value["avatar"],
    rate = double.parse(snapshot.value["rate"]),
    experience = snapshot.value["experience"],
    diagnostic = snapshot.value["diagnostic"],
    phone = snapshot.value["phone"],
    type = snapshot.value["type"];

  toJson() {
    return {
      "name": name,
      "avatar": avatar,
      "rate": rate,
      "experience": experience,
      "diagnostic": diagnostic,
      "phone": phone,
      "type": type
    };
  }
}