import 'dart:async';

import 'package:Ari/models/service.dart';
import 'package:flutter/material.dart';
import 'package:Ari/models/job.dart';
import 'package:Ari/scenes/job/jobprofile.dart';
import 'package:firebase_database/firebase_database.dart';

class JobProfileList extends StatefulWidget {
  final String jobType;
  final String jobDescription;
  final ServiceProfile srvProfile;

  JobProfileList({ Key key, this.jobType, this.jobDescription, this.srvProfile })
    : super(key: key);

  @override
  State<StatefulWidget> createState() => _JobProfileListState();

}

class _JobProfileListState extends State<JobProfileList>{

  final FirebaseDatabase _database = FirebaseDatabase.instance;
  StreamSubscription<Event> _onAddedJobProfile;
  StreamSubscription<Event> _onChangedJobProfile;
  StreamSubscription<Event> _onRemoveJobProfile;
  List<JobProfile> jobProfiles ;
  int count = 0;

  @override
  void initState() {
    super.initState();
    
    jobProfiles = List<JobProfile>();
    Query _jobProfileQuery =  _database.reference().child("JobProfile").orderByChild("available").equalTo(1);
    _onAddedJobProfile = _jobProfileQuery.onChildAdded.listen(_onJobProfileAdded);
    _onChangedJobProfile = _jobProfileQuery.onChildChanged.listen(_onJobProfileChanged);
    _onRemoveJobProfile = _jobProfileQuery.onChildRemoved.listen(_onJobProfileRemoved);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColorDark,
        automaticallyImplyLeading: false,
        title: Text(
          widget.jobDescription,
          style: TextStyle(
            color: Theme.of(context).primaryColorLight,
          ),
        ),
        leading: IconButton(icon:Icon(Icons.arrow_back),
          onPressed:() => Navigator.pop(context, false),
        ),
      ),
      backgroundColor: Colors.white,
      body: todoListItems()
    );
  }
  
  void dispose() {
    _onAddedJobProfile.cancel();
    _onChangedJobProfile.cancel();
    _onRemoveJobProfile.cancel();
    super.dispose();
  }

  Card serviceInfo() {
    return new Card(
      child: new Column(
        children: <Widget>[
          Text(
            widget.srvProfile.name
          )
        ],
      ),
    );
  }

  ListView todoListItems(){
    return  ListView.builder(
      itemCount: jobProfiles == null ? 1 : jobProfiles.length + 1,
      itemBuilder: (BuildContext context, int position){
        if(position == 0){
          return Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Image.network(
                    widget.srvProfile.image,
                    height: 200,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      widget.srvProfile.name,
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center
                    ),
                  ),
                  Text(widget.srvProfile.description,
                      style: TextStyle(
                        fontSize: 14.0,
                        color: Colors.black45,
                      )),
                ],
              ),
              padding: EdgeInsets.all(10.0),
          );
        }

        position -= 1;

        return Card(
          color: Theme.of(context).primaryColorLight,
          elevation: 2.0,
          child: ListTile(
            leading: CircleAvatar(
              radius: 30.0,
              backgroundColor: Theme.of(context).accentColor,
              backgroundImage: NetworkImage(this.jobProfiles[position].avatar),
            ),
            title:Padding(
              padding: EdgeInsets.only(left: 5.0),
              child: Text(
                this.jobProfiles[position].name,
                style: TextStyle(
                  color: Theme.of(context).primaryColorDark,
                ),
              ),
            ),
            subtitle:Row(
              children: <Widget>[
                Icon(Icons.star, color: getStarColor(1,this.jobProfiles[position].rate)),
                Icon(Icons.star, color: getStarColor(2,this.jobProfiles[position].rate)),
                Icon(Icons.star, color: getStarColor(3,this.jobProfiles[position].rate)),
                Icon(Icons.star, color: getStarColor(4,this.jobProfiles[position].rate)),
                Icon(Icons.star, color: getStarColor(5,this.jobProfiles[position].rate)),
              ],
            ),
            onTap: (){
              navigateToDetail(this.jobProfiles[position]);
            },
          ),
        );
      }
    );
  }

  Color getStarColor(int star,int rate){
    if(star <= rate )
      return Theme.of(context).accentColor;
    else
      return Theme.of(context).primaryColorDark;
  }

  void _onJobProfileAdded(Event event) {
    
    if(event.snapshot.value["type"] == widget.jobType && event.snapshot.value["available"] == 1){
      setState(() {
        jobProfiles.add(new JobProfile.fromSnapshot(event.snapshot));
        count = jobProfiles.length;
      });
    }
  }

  void _onJobProfileChanged(Event event) {
    var oldEntry = jobProfiles.singleWhere((entry) {
      return entry.key == event.snapshot.key;
    });

    setState(() {
      jobProfiles[jobProfiles.indexOf(oldEntry)] = JobProfile.fromSnapshot(event.snapshot);
      count = jobProfiles.length;
    });
  }

  void _onJobProfileRemoved(Event event){
    jobProfiles.removeWhere((entry) {
      return entry.key == event.snapshot.key;
    });

    setState(() {
      count = jobProfiles.length;
    });
  }

  void navigateToDetail(JobProfile jobProfile) async {
    await Navigator.push(context, 
      MaterialPageRoute(builder: (context) => JobProfileDetail(jobProfile))
    );
  }
  
}