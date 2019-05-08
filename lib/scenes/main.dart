import 'package:Ari/scenes/job/joblist.dart';
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
                onPressed: () { showRelated(context, "electricity", "Electricidad"); },
                child: Column( 
                  children: <Widget>[
                    Text(
                      "Electricidad",
                      style: TextStyle(
                        color: Color(0xFFFFFFFF),
                      )
                    ),
                    Image(
                      image: AssetImage('assets/images/menu_1.png'),
                      width: 80,
                      height: 100
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
                    onPressed: ()  { showRelated(context, "painting", "Pintura"); },
                    child: Column( 
                      children: <Widget>[
                        Text(
                          "Pintura",
                          style: TextStyle(
                            color: Color(0xFFFFFFFF),
                          )
                        ),
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
                    onPressed: ()  { showRelated(context, "plumbing", "Plomería"); },
                    child: Column( 
                      children: <Widget>[
                        Text(
                          "Plomeria",
                          style: TextStyle(
                            color: Color(0xFFFFFFFF),
                          )
                        ),
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
                  image: AssetImage('assets/images/logo.png'),
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

  void showRelated(BuildContext context, String jobType, String jobDescriprion ) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => JobProfileList(jobType: jobType, jobDescription: jobDescriprion,)));
  }

}


