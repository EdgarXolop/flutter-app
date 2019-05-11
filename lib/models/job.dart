import 'package:firebase_database/firebase_database.dart';

class JobProfile {
  String key;
  String avatar;
  String name;
  int rate;
  String experience;
  String diagnostic;
  String phone;
  String type;
  int _available;

  JobProfile(this.name, this.avatar, this.rate, this.experience, this.diagnostic, this.phone, this.type, this._available);
  
  JobProfile.fromSnapshot(DataSnapshot snapshot) :
    key = snapshot.key,
    name = snapshot.value["name"],
    avatar = snapshot.value["avatar"],
    rate = snapshot.value["rate"],
    experience = snapshot.value["experience"],
    diagnostic = snapshot.value["diagnostic"],
    phone = snapshot.value["phone"],
    type = snapshot.value["type"],
    _available = snapshot.value["available"]  ;

  toJson() {
    return {
      "name": name,
      "avatar": avatar,
      "rate": rate,
      "experience": experience,
      "diagnostic": diagnostic,
      "phone": phone,
      "type": type,
      "available": _available,
    };
  }

  set available(int available) => this._available = available;
  get available => this._available;
}