import 'dart:async';

import 'package:Ari/scenes/job/joblist.dart';
import 'package:flutter/material.dart';
import 'package:Ari/models/service.dart';
import 'package:firebase_database/firebase_database.dart';


class ServiceList extends StatefulWidget {
  final String jobType;
  final String jobDescription;

  ServiceList({ Key key, this.jobType, this.jobDescription })
    : super(key: key);

  @override
  State<StatefulWidget> createState() => _ServiceListState();
}



class _ServiceListState extends State<ServiceList>{
  
  final FirebaseDatabase _database = FirebaseDatabase.instance;
  StreamSubscription<Event> _onAddedServiceProfile;
  StreamSubscription<Event> _onChangedServiceProfile;
  StreamSubscription<Event> _onRemoveServiceProfile;
  List<ServiceProfile> serviceProfiles ;
  int count = 0;
  
  @override
  void initState() {
    super.initState();
    
    serviceProfiles = List<ServiceProfile>();
    Query _serviceProfileQuery =  _database.reference().child("ServiceProfile").orderByChild("type").equalTo(widget.jobType);

    _onAddedServiceProfile = _serviceProfileQuery.onChildAdded.listen(_onServiceProfileAdded);
    _onChangedServiceProfile = _serviceProfileQuery.onChildChanged.listen(_onServiceProfileChanged);
    _onRemoveServiceProfile = _serviceProfileQuery.onChildRemoved.listen(_onServiceProfileRemoved);
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
      body: serviceListItems(),
    );
  }

  
  ListView serviceListItems(){
    return  ListView.builder(
      itemCount: count,
      itemBuilder: (BuildContext context, int position){
        return serviceCard(serviceProfiles[position]);
      }
    );
  }

  void dispose() {
    _onAddedServiceProfile.cancel();
    _onChangedServiceProfile.cancel();
    _onRemoveServiceProfile.cancel();

    super.dispose();
  }

  void _onServiceProfileAdded(Event event) {
    if(event.snapshot.value["type"] == widget.jobType){
      setState(() {
        serviceProfiles.add(new ServiceProfile.fromSnapshot(event.snapshot));
        count = serviceProfiles.length;
      });
    }
  }

  void _onServiceProfileChanged(Event event) {
    var oldEntry = serviceProfiles.singleWhere((entry) {
      return entry.key == event.snapshot.key;
    });

    setState(() {
      serviceProfiles[serviceProfiles.indexOf(oldEntry)] = ServiceProfile.fromSnapshot(event.snapshot);
      count = serviceProfiles.length;
    });
  }

  void _onServiceProfileRemoved(Event event){
    serviceProfiles.removeWhere((entry) {
      return entry.key == event.snapshot.key;
    });

    setState(() {
      count = serviceProfiles.length;
    });
  }

  void navigateToDetail(ServiceProfile serviceProfile) async {
    await Navigator.push(context, MaterialPageRoute(builder: (context) => JobProfileList(jobType: widget.jobType, jobDescription: widget.jobDescription, srvProfile: serviceProfile,))
    );
  }



  Card serviceCard(ServiceProfile srvProfile){
    return new Card(
      elevation: 8.0,
      margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          borderRadius: new BorderRadius.all(const Radius.circular(5.0))
        ),
        child: serviceListTile(srvProfile),
      ),
    );
  }

  ListTile serviceListTile(ServiceProfile srvProfile) {
    return new ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        leading: Container(
          padding: EdgeInsets.only(right: 12.0),
          decoration: new BoxDecoration(
              border: new Border(
                  right: new BorderSide(width: 1.0, color: Colors.white24))),
          child:  CircleAvatar(
            radius: 30.0,
            backgroundColor: Theme.of(context).accentColor,
            backgroundImage: NetworkImage(srvProfile.image),
          ),
        ),
        title: Text(
          srvProfile.name,
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        subtitle: Row(
          children: <Widget>[
            Text((srvProfile.description.length > 15) ? srvProfile.description.substring(0, 15) + "...." : srvProfile.description, style: TextStyle(color: Colors.white))
          ],
        ),
        trailing: Icon(Icons.keyboard_arrow_right, color: Colors.white, size: 30.0),
        onTap: (){
          navigateToDetail(srvProfile);
        },
    );
  }
}




