import 'package:firebase_database/firebase_database.dart';

class SimpleFAQ {
  String key;
  String answer;
  String response;

  SimpleFAQ(this.answer, this.response);
  
  SimpleFAQ.fromSnapshot(DataSnapshot snapshot) :
    key = snapshot.key,
    answer = snapshot.value["answer"],
    response = snapshot.value["response"];

  toJson() {
    return {
      "answer": answer,
      "response": response
    };
  }
}