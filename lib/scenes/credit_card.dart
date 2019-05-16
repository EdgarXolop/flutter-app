import 'dart:async';

import 'package:Ari/models/credit_card.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CreditCard extends StatefulWidget {
  String userId;
  CreditCard(this.userId) : super();

  @override
  State<StatefulWidget> createState() => CreditCardState();
}

class CreditCardState extends State<CreditCard> {
  
  List<SimpleCreditCard> cards;
  int count = 0;
  
  final FirebaseDatabase _database = FirebaseDatabase.instance;
  StreamSubscription<Event> _onAddedCreditCard;
  StreamSubscription<Event> _onChangeddCreditCard;
  StreamSubscription<Event> _onRemovedCreditCard;

  @override
  void initState() {
    super.initState();
    
    cards = new List<SimpleCreditCard>();

    Query _cdQuery =  _database.reference().child("CreditCard/" + widget.userId).orderByKey();

    _onAddedCreditCard = _cdQuery.onChildAdded.listen(_onCreditCardAdded);
    _onChangeddCreditCard = _cdQuery.onChildChanged.listen(_onCreditCardChanged);
    _onRemovedCreditCard = _cdQuery.onChildRemoved.listen(_onCreditCardRemoved);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        elevation: 5,
        backgroundColor: Color(0xFFFFFFFF),
        leading: null,
        title: new Text(
          "Métodos de Pago",
          style: new TextStyle(
            fontSize: 20.0,
            color: Theme.of(context).primaryColor
          ),
        ),        
      ),
      body: new Stack(
        children: <Widget>[
          // new RaisedButton(
          //   padding: EdgeInsets.only(
          //     top: 17.0,
          //     bottom: 17.0
          //   ),
          //   color: Theme.of(context).buttonColor,
          //   textColor: Theme.of(context).primaryColorLight,
          //   shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(25.0)),
          //   onPressed: () {
          //   //   showDialog(
          //   //     context: context,
          //   //     barrierDismissible: false,
          //   //     child: this._displayDialog(context)
          //   //   );

          //     this._displayDialog(context);
          //   },
          //   child: Text(
          //     'Agregar',
          //     style: TextStyle(
          //       fontSize: 20.0,
          //       fontFamily: "Poppins"
          //     ),
          //   )
          // ),
          serviceListItems()
          
        ],
      ),
      floatingActionButton: FloatingActionButton(
            onPressed: () {
              this._displayDialog(context);
            },
            child: Icon(Icons.add),
            backgroundColor: Theme.of(context).primaryColor
          ),
    );      
  }
  
  ListView serviceListItems(){
    return  ListView.builder(
      itemCount: count,
      itemBuilder: (BuildContext context, int position){
        return serviceCard(cards[position]);
      }
    );
  }


  Card serviceCard(SimpleCreditCard card){
    return new Card(
      elevation: 8.0,
      margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          borderRadius: new BorderRadius.all(const Radius.circular(5.0))
        ),
        child: cardListTile(card),
      ),
    );
  }

  ListTile cardListTile(SimpleCreditCard card) {
    return new ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        leading: Container(
          padding: EdgeInsets.only(right: 12.0),
          decoration: new BoxDecoration(
              border: new Border(
                  right: new BorderSide(width: 1.0, color: Colors.white24))),
          child: new Icon(
            Icons.credit_card
          )
        ),
        title: Text(
          card.cardNumber,
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        )
    );
  }

  
  void dispose() {
    _onAddedCreditCard.cancel();
    _onChangeddCreditCard.cancel();
    _onRemovedCreditCard.cancel();
    super.dispose();
  }

 void _onCreditCardAdded(Event event) {
    setState(() {
      SimpleCreditCard f = new SimpleCreditCard.fromSnapshot(event.snapshot);

      cards.add(f);

      count = cards.length;
    });  
  }

  void _onCreditCardChanged(Event event) {
    var oldEntry = cards.singleWhere((entry) {
      return entry.key == event.snapshot.key;
    });

    setState(() {
      cards[cards.indexOf(oldEntry)] = SimpleCreditCard.fromSnapshot(event.snapshot);
      count = cards.length;
    });
  }

  void _onCreditCardRemoved(Event event){
    cards.removeWhere((entry) {
      return entry.key == event.snapshot.key;
    });
    
    setState(() {
      count = cards.length;
    });
  }

  TextEditingController _cardNumberController = TextEditingController();
  TextEditingController _expirationController = TextEditingController();
  TextEditingController _cvvController = TextEditingController();

  _displayDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Datos de Tarjeta',
              style: TextStyle(
                fontSize: 20.0
              ),
            ),
            content: new Column(
              children: <Widget>[
                TextFormField(
                  controller: _cardNumberController,
                  maxLength: 16,
                  keyboardType: TextInputType.numberWithOptions(),
                  decoration: InputDecoration(
                    labelText: "Número de Tarjeta",
                    fillColor: Colors.white,
                    border: new OutlineInputBorder(
                      borderRadius: new BorderRadius.circular(25.0),
                      borderSide: new BorderSide(
                      ),
                    ),
                  ),
                  validator: (val) {
                    if(val.length == 0) {
                      return "Debe ingresar número de tarjeta";
                    }else{
                      return null;
                    }
                  }
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                ),
                TextFormField(
                  controller: _expirationController,
                  keyboardType: TextInputType.numberWithOptions(),
                  maxLength: 6,
                  decoration: InputDecoration(
                    labelText: "Fecha de Expiración",
                    fillColor: Colors.white,
                    border: new OutlineInputBorder(
                      borderRadius: new BorderRadius.circular(25.0),
                      borderSide: new BorderSide(
                      ),
                    ),
                  ),
                  validator: (val) {
                    if(val.length == 0) {
                      return "Debe ingresar su fecha de expiración";
                    }else{
                      return null;
                    }
                  }
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                ),
                TextFormField(
                  controller: _cvvController,
                  maxLength: 3,
                  keyboardType: TextInputType.numberWithOptions(),
                  decoration: InputDecoration(
                    labelText: "CVV",
                    fillColor: Colors.white,
                    border: new OutlineInputBorder(
                      borderRadius: new BorderRadius.circular(25.0),
                      borderSide: new BorderSide(
                      ),
                    ),
                  ),
                  validator: (val) {
                    if(val.length == 0) {
                      return "Debe ingresar su cvv";
                    }else{
                      return null;
                    }
                  }
                  
                )
              ],
            ),
            actions: <Widget>[
              new FlatButton(
                child: new Text('Agregar'),
                onPressed: () => this.addCard(_cardNumberController.text.toString(), _expirationController.text.toString(), _cvvController.text.toString()),
              ),
              new FlatButton(
                child: new Text('Cancelar'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          );
      }
    );
  }

  void addCard(String creditCardNum, String expiration, String cvv) {
    
    final notesReference = FirebaseDatabase.instance.reference().child('CreditCard/' + widget.userId);

    SimpleCreditCard newCard = new SimpleCreditCard(creditCardNum, expiration, cvv);

    notesReference.push().set(newCard.toJson())
    .then((_) {
      Navigator.of(context).pop();  

      _cardNumberController.text = "";
      _expirationController.text = "";
      _cvvController.text = "";    
    });
  }

}


