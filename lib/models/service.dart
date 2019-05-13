import 'package:firebase_database/firebase_database.dart';

class ServiceProfile {
  String key;
  String image;
  String name;
  String description;
  String type;


  ServiceProfile(this.image, this.name, this.description, this.type);
  
  ServiceProfile.fromSnapshot(DataSnapshot snapshot) :
    key = snapshot.key,
    image = snapshot.value["image"],
    name = snapshot.value["name"],
    description = snapshot.value["description"],
    type = snapshot.value["type"];

  toJson() {
    return {
      "name": name,
      "iamge": image,
      "description": description,
      "type": type
    };
  }
}