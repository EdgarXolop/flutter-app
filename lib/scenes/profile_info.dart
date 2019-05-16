import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProfileInfo extends StatefulWidget {
  FirebaseUser userLogged;
  
  ProfileInfo(this.userLogged) : super();

  @override
  State<StatefulWidget> createState() => ProfileInfoState();
}

class ProfileInfoState extends State<ProfileInfo> {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        elevation: 5,
        backgroundColor: Color(0xFFFFFFFF),
        leading: null,
        title: new Text(
          "Información Personal",
          style: new TextStyle(
            fontSize: 20.0,
            color: Theme.of(context).primaryColor
          ),
        ),        
      ),
      body: new Stack(
        children: <Widget>[
          ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
              ListTile(
                leading: new Icon(Icons.person),
                title: Text(widget.userLogged.displayName, style: Theme.of(context).textTheme.body1,)
              ),
              ListTile(
                leading: new Icon(Icons.email),
                title: Text(widget.userLogged.email, style: Theme.of(context).textTheme.body1,)
              ),
              ListTile(
                leading: new Icon(Icons.phone),
                title: Text("", style: Theme.of(context).textTheme.body1,)
              )
            ]
          )
        ],
      )
    );      
  }
}