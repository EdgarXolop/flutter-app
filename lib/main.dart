import 'package:Ari/scenes/home.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Ari',
      theme: ThemeData(
        primaryColor: Color(0xFFFDC53C),
        primaryColorDark: Color(0xFFC69800),
        primaryColorLight: Color(0xFFFFE0B2),
        accentColor: Color(0xFFFFC107),
        dividerColor: Color(0xFFBDBDBD),
        buttonColor: Color(0xFF000000),
        
        fontFamily: 'Montserrat',
        textTheme: TextTheme(
          headline: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold, color: Color(0xFF757575)),
          title: TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic,color: Color(0xFF212121)),
          body1: TextStyle(fontSize: 14.0, fontFamily: 'Hind',color: Color(0xFFC69800)),
          body2: TextStyle(fontSize: 14.0, fontFamily: 'Hind',color: Color(0xFFFFE0B2)),
        ), 
      ),
      home: Home(),
    );
  }
}
