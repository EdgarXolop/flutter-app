import 'package:flutter/material.dart';

class Main extends StatelessWidget {

  final _padding = 40.0;
  final _paddingElement = 10.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: null,
      body: Container(
        padding: EdgeInsets.all(_padding),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Container(),
            Center(
              child: FlatButton(
                color: Theme.of(context).primaryColorDark,
                onPressed: () => {},
                child: Column( 
                  children: <Widget>[
                    Text("Pinturua"),
                    Image(
                      image: AssetImage('assets/images/menu_1.png'),
                      width: 80,
                      height: 100,
                    ),
                  ],
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(right: _paddingElement),
                  child: FlatButton(
                    color: Theme.of(context).primaryColorDark,
                    onPressed: () => {},
                    child: Column( 
                      children: <Widget>[
                        Text("Pinturua"),
                        Image(
                          image: AssetImage('assets/images/menu_2.png'),
                          width: 80,
                          height: 100,
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: _paddingElement),
                  child: FlatButton(
                    color: Theme.of(context).primaryColorDark,
                    onPressed: () => {},
                    child: Column( 
                      children: <Widget>[
                        Text("Plomeria"),
                        Image(
                          image: AssetImage('assets/images/menu_3.png'),
                          width: 80,
                          height: 100,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Image(
                  image: AssetImage('assets/images/brand.png'),
                  width: 80,
                  height: 100,
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  
  void navigateToSignin(BuildContext context){
    
    
  }
  
  void navigateToSignup(BuildContext context){
    
  }

}
