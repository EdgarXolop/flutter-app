import 'package:flutter/material.dart';
import 'package:Ari/scenes/signin.dart';
import 'package:Ari/scenes/signup.dart';

class Home extends StatelessWidget {

  final _padding = 40.0;
  final _paddingElement = 20.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Container(
        padding: EdgeInsets.all(_padding),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Container(),
            Center(
              child: Image(
                image: AssetImage('assets/images/logo.png'),
                width: 100,
                height: 130,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(right: _paddingElement),
                  child: RaisedButton(
                    color: Theme.of(context).primaryColorLight,
                    textColor: Theme.of(context).primaryColorDark,
                    onPressed: ()=>this.navigateToSignup(context),
                    child: Text(
                      'Registrarse'
                    )
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: _paddingElement),
                  child: RaisedButton(
                    color: Theme.of(context).primaryColorDark,
                    textColor: Theme.of(context).primaryColorLight,
                    onPressed: ()=>this.navigateToSignin(context),
                    child: Text(
                      'Conectarse'
                    ),
                  ),
                ),
              ],
            )
          ],

        ),
      ),
    );
  }

  
  void navigateToSignin(BuildContext context){
    Navigator.push(context, MaterialPageRoute(builder: (context) => Signin()));
    
  }
  
  void navigateToSignup(BuildContext context){
    Navigator.push(context, MaterialPageRoute(builder: (context) => Signup()));
    
  }

}
