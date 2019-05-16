import 'package:flutter/material.dart';

class PromCode extends StatefulWidget {
  String userId;

  PromCode(this.userId) : super();

  @override
  State<StatefulWidget> createState() => PromCodeState();
}

class PromCodeState extends State<PromCode> {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        elevation: 5,
        backgroundColor: Color(0xFFFFFFFF),
        leading: null,
        title: new Text(
          "Códigos de Promoción",
          style: new TextStyle(
            fontSize: 20.0,
            color: Theme.of(context).primaryColor
          ),
        ),        
      ),
      body: new Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          new Padding(
            padding: EdgeInsets.all(10.0),
            child: new Text(
              "Regala a tus conocidos y amigos un diagnostico gratis para probar Arí, Introduciendo el siguiente código",
            ),
          ),
          new Padding(
            padding: EdgeInsets.all(10.0),
            child: new Text(
              widget.userId.substring(0, 5),
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).buttonColor
              ),
            ),
          ),
          Image(
            image: AssetImage('assets/images/coupon.png'),
            width: 80,
            height: 100,
          )
        ],
      )
    );      
  }
}