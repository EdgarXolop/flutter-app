import 'package:flutter/material.dart';
import 'package:Ari/models/job.dart';
import 'package:firebase_database/firebase_database.dart';

class JobProfileDetail extends StatefulWidget{
  final JobProfile jobProfile;
  JobProfileDetail(this.jobProfile);

  @override
  State<StatefulWidget> createState() => _JobProfileDetailState(jobProfile);

}


class _JobProfileDetailState extends State{
  final FirebaseDatabase _database = FirebaseDatabase.instance;
  JobProfile jobProfile;
  _JobProfileDetailState(this.jobProfile);
  final _formDistance = 15.0;

  @override
  Widget build(BuildContext context) {

    List<String> exp = this.jobProfile.experience.split(",");

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColorDark,
        automaticallyImplyLeading: false,
        title: Text(
          "",
          style: TextStyle(
            color: Theme.of(context).primaryColorLight,
          ),
        ),
        leading: IconButton(icon:Icon(Icons.arrow_back),
          onPressed:() => Navigator.pop(context, false),
        ),
      ),
      backgroundColor: Theme.of(context).primaryColorLight,
      body: Padding(
        padding: EdgeInsets.all(_formDistance),
        child:Column(
          children: <Widget>[
            Center(
              child: ClipRRect(
                borderRadius: new BorderRadius.circular(100.0),
                child: Image.network(
                  jobProfile.avatar,
                  height: 200,
                ),
              ),
            ),
            Center(
              child: Padding(
                padding: EdgeInsets.all(_formDistance),
                child: Text(jobProfile.name,style: TextStyle(color: Theme.of(context).primaryColorDark,fontSize: 18),),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(Icons.star,color: getStarColor(1,this.jobProfile.rate)),
                Icon(Icons.star,color: getStarColor(2,this.jobProfile.rate)),
                Icon(Icons.star,color: getStarColor(3,this.jobProfile.rate)),
                Icon(Icons.star,color: getStarColor(4,this.jobProfile.rate)),
                Icon(Icons.star,color: getStarColor(5,this.jobProfile.rate)),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(top:_formDistance),
              child: Text("Diagnostico Q100.",
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top:_formDistance,bottom: _formDistance),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(right: _formDistance),
                    child: RaisedButton(
                      color: Theme.of(context).primaryColorDark,
                      textColor: Theme.of(context).primaryColorLight,
                      onPressed: ()=>this.checkout(context),
                      child: Text(
                      'Solicitar'
                      )
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: _formDistance),
                    child: RaisedButton(
                      color: Theme.of(context).primaryColorDark,
                      textColor: Theme.of(context).primaryColorLight,
                      onPressed: ()=>this.checkout(context),
                      child: Text(
                        'Contactar'
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Text("Experiencia: ",
                style: TextStyle(
                  fontSize: 20,
                  color: Theme.of(context).primaryColorDark
                ),
              ),
            Container(
              height: 150,
              child:ListView.builder(
                itemCount: exp.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.all(5.0),
                    child: Text(exp[index].trim(),textAlign: TextAlign.center,),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color getStarColor(int star,int rate){
    if(star <= rate )
      return Theme.of(context).primaryColorDark;
    else
      return Theme.of(context).accentColor;
  }

  void checkout (BuildContext context) {

    this.jobProfile.available = 0;

    _database.reference().child("JobProfile").child(this.jobProfile.key).set(this.jobProfile.toJson());

    Navigator.pop(context, false);
  }

}