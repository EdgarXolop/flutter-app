import 'package:Ari/scenes/faq.dart';
import 'package:Ari/scenes/job/serviceList.dart';
import 'package:Ari/util/auth.dart';
import 'package:Ari/scenes/home.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Main extends StatefulWidget{

  @override
  State<StatefulWidget> createState() => _Main();

}
class _Main extends State {

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final _padding = 40.0;
  final _paddingElement = 10.0;

  String name = "";

  @override
  void initState() {
    super.initState();

    Auth().gentUser()
    .then((FirebaseUser user){
      setState(() {
       name = user.displayName; 
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Theme.of(context).primaryColor,
      appBar: new AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).primaryColor,
        leading: new IconButton(
                icon: new Icon(Icons.settings),
                onPressed: () => _scaffoldKey.currentState.openDrawer()
        )
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Center(
                child:  Image(
                  image: AssetImage('assets/images/logo.png'),
                  width: 80,
                  height: 100,
                ),
              ),
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor
              ),
            ),
            ListTile(
              leading: new Icon(Icons.person),
              title: Text(name,style: Theme.of(context).textTheme.body1,),
            ),
            Divider(),
            ListTile(
              leading: new Icon(Icons.question_answer),
              title: Text('FAQ',style: Theme.of(context).textTheme.body1),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => FAQ()));
              },
            ),
            Divider(),
            ListTile(
              leading: new Icon(Icons.input),
              title: Text('Cerrar Sesión', style: Theme.of(context).textTheme.body1,),
              onTap: ()async {
                await Auth().signOut();
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Home()));
              },
              
            ),
          ],
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(_padding),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Center(
              child: RaisedButton(
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
                shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(100.0))
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(right: _paddingElement),
                  child: RaisedButton(
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
                    shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(100.0))
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: _paddingElement),
                  child: RaisedButton(
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
                    shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(100.0))
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
    Navigator.push(context, MaterialPageRoute(builder: (context) => ServiceList(jobType: jobType, jobDescription: jobDescriprion,)));
  }

}


