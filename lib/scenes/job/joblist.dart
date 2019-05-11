import 'dart:async';

import 'package:flutter/material.dart';
import 'package:Ari/models/job.dart';
import 'package:Ari/scenes/job/jobprofile.dart';
import 'package:firebase_database/firebase_database.dart';

class JobProfileList extends StatefulWidget {
  final String jobType;
  final String jobDescription;

  JobProfileList({ Key key, this.jobType, this.jobDescription })
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
      body: todoListItems(),
    );
  }
  
  void dispose() {
    _onAddedJobProfile.cancel();
    _onChangedJobProfile.cancel();
    _onRemoveJobProfile.cancel();
    super.dispose();
  }

  ListView todoListItems(){
    return  ListView.builder(
      itemCount: count,
      itemBuilder: (BuildContext context, int position){
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
                Icon(Icons.star,color: getStarColor(1,this.jobProfiles[position].rate)),
                Icon(Icons.star,color: getStarColor(2,this.jobProfiles[position].rate)),
                Icon(Icons.star,color: getStarColor(3,this.jobProfiles[position].rate)),
                Icon(Icons.star,color: getStarColor(4,this.jobProfiles[position].rate)),
                Icon(Icons.star,color: getStarColor(5,this.jobProfiles[position].rate)),
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
      return Theme.of(context).primaryColorDark;
    else
      return Theme.of(context).accentColor;
  }

  void _onJobProfileAdded(Event event) {
    if(event.snapshot.value["type"] == widget.jobType && event.snapshot.value["available"]==1){
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