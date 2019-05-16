import 'package:firebase_database/firebase_database.dart';

class SimpleCreditCard {
  String key;
  String cardNumber;
  String expiration;
  String cvv;

  SimpleCreditCard(this.cardNumber, this.expiration, this.cvv);
  
  SimpleCreditCard.fromSnapshot(DataSnapshot snapshot) :
    key = snapshot.key,
    cardNumber = snapshot.value["cardNumber"],
    expiration = snapshot.value["expiration"],
    cvv = snapshot.value["cvv"];

  toJson() {
    return {
      "cardNumber": cardNumber,
      "expiration": expiration,
      "cvv": cvv
    };
  }
}