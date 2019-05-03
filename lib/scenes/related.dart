import 'dart:async';

import 'package:Ari/models/job.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class RelatedJob extends StatefulWidget {
  final String jobType;
  final String jobDescription;

  RelatedJob({Key key, this.jobType, this.jobDescription})
    : super(key: key);
  
  @override
  State<StatefulWidget> createState() => new _RelatedJobState();
}

class _RelatedJobState extends State<RelatedJob> {
  final _padding = 40.0;
  final _paddingElement = 20.0;

  List<JobProfile> _relatedJobList;

  final FirebaseDatabase _database = FirebaseDatabase.instance;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  
  // final _nameEditingController = TextEditingController();
  // final _experienceEditingController = TextEditingController();
  // final _diagnosticEditingController = TextEditingController();
  // final _phoneEditingController = TextEditingController();
  // final _typeEditingController = TextEditingController();
  // final _rateEditingController = TextEditingController();

  StreamSubscription<Event> _onJobAddedSubscription;
  StreamSubscription<Event> _onJobChangedSubscription;

  Query _relatedJobQuery;

  @override
  void initState() {
    super.initState();

    _relatedJobList = new List();
    _relatedJobQuery = _database
        .reference()
        .child("JobProfile")
        .orderByChild("type")
        .equalTo(widget.jobType);
    _onJobAddedSubscription = _relatedJobQuery.onChildAdded.listen(_onEntryAdded);
    _onJobChangedSubscription = _relatedJobQuery.onChildChanged.listen(_onEntryChanged);
  }

  
  @override
  void dispose() {
    _onJobAddedSubscription.cancel();
    _onJobChangedSubscription.cancel();
    super.dispose();
  }

  _onEntryChanged(Event event) {
    var oldEntry = _relatedJobList.singleWhere((entry) {
      return entry.key == event.snapshot.key;
    });

    setState(() {
      _relatedJobList[_relatedJobList.indexOf(oldEntry)] = JobProfile.fromSnapshot(event.snapshot);
    });
  }

  _onEntryAdded(Event event) {
    setState(() {
      _relatedJobList.add(JobProfile.fromSnapshot(event.snapshot));
    });
  }

  // _updateTodo(JobProfile todo){
  //   //Toggle completed
  //   todo.completed = !todo.completed;
  //   if (todo != null) {
  //     _database.reference().child("todo").child(todo.key).set(todo.toJson());
  //   }
  // }

  _deleteTodo(String jobProfileId, int index) {
    _database.reference().child("JobProfile")
      .child(jobProfileId)
      .remove()
      .then((_) {
      print("Delete $jobProfileId successful");
      setState(() {
        _relatedJobList.removeAt(index);
      });
    });
  }

  // _showDialog(BuildContext context) async {
    
  //   _nameEditingController.clear();
  //   _rateEditingController.clear();
  //   _experienceEditingController.clear();
  //   _diagnosticEditingController.clear();
  //   _phoneEditingController.clear();
  //   _typeEditingController.clear();

  //   await showDialog<String>(
  //       context: context,
  //     builder: (BuildContext context) {
  //         return AlertDialog(
  //           content: new Column(
  //             children: <Widget>[
  //               new Expanded(child: new TextField(
  //                 controller: _nameEditingController,
  //                 autofocus: true,
  //                 decoration: new InputDecoration(
  //                   labelText: 'Nombre del Profesional',
  //                 ),
  //               )),
  //               new Expanded(child: new TextField(
  //                 controller: _rateEditingController,
  //                 autofocus: true,
  //                 decoration: new InputDecoration(
  //                   labelText: 'Puntuaje',
  //                 ),
  //               )),
  //               new Expanded(child: new TextField(
  //                 controller: _experienceEditingController,
  //                 autofocus: true,
  //                 decoration: new InputDecoration(
  //                   labelText: 'Experiencia',
  //                 ),
  //               )),
  //               new Expanded(child: new TextField(
  //                 controller: _diagnosticEditingController,
  //                 autofocus: true,
  //                 decoration: new InputDecoration(
  //                   labelText: 'Costo de Diagnostico',
  //                 ),
  //               )),
  //               new Expanded(child: new TextField(
  //                 controller: _phoneEditingController,
  //                 autofocus: true,
  //                 decoration: new InputDecoration(
  //                   labelText: 'Número de teléfono',
  //                 ),
  //               )),
  //               new Expanded(child: new TextField(
  //                 controller: _typeEditingController,
  //                 autofocus: true,
  //                 decoration: new InputDecoration(
  //                   labelText: 'Tipo de Perfil',
  //                 ),
  //               ))
  //             ],
  //           ),
  //           actions: <Widget>[
  //             new FlatButton(
  //                 child: const Text('Cancelar'),
  //                 onPressed: () {
  //                   Navigator.pop(context);
  //                 }),
  //             new FlatButton(
  //                 child: const Text('Guardar'),
  //                 onPressed: () {
  //                   _addNewTodo(_nameEditingController.text.toString(), _rateEditingController.text.toString(),_experienceEditingController.text.toString()
  //                   ,_diagnosticEditingController.text.toString(),_phoneEditingController.text.toString(),_typeEditingController.text.toString());
  //                   Navigator.pop(context);
  //                 })
  //           ],
  //         );
  //     }
  //   );
  // }

  Widget _showTodoList() {
    if (_relatedJobList.length > 0) {
      return ListView.builder(
          shrinkWrap: true,
          itemCount: _relatedJobList.length,
          itemBuilder: (BuildContext context, int index) {
            String jobProfileId = _relatedJobList[index].key;
            String name = _relatedJobList[index].name;
            String rate = _relatedJobList[index].rate;
            
            return Dismissible(
              key: Key(jobProfileId),
              background: Container(color: Colors.red),
              onDismissed: (direction) async {
                _deleteTodo(jobProfileId, index);
              },
              child: ListTile(
                title: Text(
                  name,
                  style: TextStyle(fontSize: 20.0),
                ),
                trailing: Text(
                  rate,
                  style: TextStyle(fontSize: 20.0),
                )
              ),
            );
          });
    } else {
      return Center(child: Text("No existe perfile para esta especialidad",
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 12.0),));
    }
  }
  
  FullScreenDialog _newDialog = new FullScreenDialog();

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          title: new Text(widget.jobDescription),
        ),
        body: _showTodoList(),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(context, new MaterialPageRoute(
              builder: (BuildContext context) => _newDialog,
              fullscreenDialog: true,
            ));
          },
          tooltip: 'Increment',
          child: Icon(Icons.add),
        )
    );
  }

  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     backgroundColor: Theme.of(context).primaryColor,
  //     body: Container(
  //       padding: EdgeInsets.all(_padding),
  //       child: Column(
  //         mainAxisAlignment: MainAxisAlignment.spaceAround,
  //         children: <Widget>[
  //           Container(),
  //           Center(
  //             child: Image(
  //               image: AssetImage('assets/images/logo.png'),
  //               width: 100,
  //               height: 130,
  //             ),
  //           ),
  //           Row(
  //             mainAxisAlignment: MainAxisAlignment.center,
  //             children: <Widget>[
  //               Padding(
  //                 padding: EdgeInsets.only(right: _paddingElement),
  //                 child:  Text(
  //                   "JOB",
  //                   style: TextStyle(
  //                     color: Color(0xFF000000),
  //                   )
  //                 )
  //               )
  //             ],
  //           )
  //         ],

  //       ),
  //     ),
  //   );
  // }
}



class FullScreenDialog extends StatefulWidget {
  @override
  FullScreenDialogState createState() => new FullScreenDialogState();
}

class FullScreenDialogState extends State<FullScreenDialog> {
  final _nameEditingController = TextEditingController();
  final _experienceEditingController = TextEditingController();
  final _diagnosticEditingController = TextEditingController();
  final _phoneEditingController = TextEditingController();
  final _typeEditingController = TextEditingController();
  final _rateEditingController = TextEditingController();

  
  final FirebaseDatabase _database = FirebaseDatabase.instance;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          title: new Text("Nuevo Perfil"),
        ),
        body: new Padding(
          child: new ListView(
            children: <Widget>[
              new TextField(
                controller: _nameEditingController,
                autofocus: true,
                decoration: new InputDecoration(
                  labelText: 'Nombre del Profesional',
                ),
              ),
              new TextField(
                controller: _rateEditingController,
                autofocus: true,
                decoration: new InputDecoration(
                  labelText: 'Puntuaje',
                ),
              ),
              new TextField(
                controller: _experienceEditingController,
                autofocus: true,
                decoration: new InputDecoration(
                  labelText: 'Experiencia',
                ),
              ),
              new TextField(
                controller: _diagnosticEditingController,
                autofocus: true,
                decoration: new InputDecoration(
                  labelText: 'Costo de Diagnostico',
                ),
              ),
              new TextField(
                controller: _phoneEditingController,
                autofocus: true,
                decoration: new InputDecoration(
                  labelText: 'Número de teléfono',
                ),
              ),
              new TextField(
                controller: _typeEditingController,
                autofocus: true,
                decoration: new InputDecoration(
                  labelText: 'Tipo de Perfil',
                ),
              ),
              new Row(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: new FlatButton(
                      color: Theme.of(context).primaryColorLight,
                      child: const Text(
                        "Cancelar",
                        style:  TextStyle(
                          color: Color(0xFFF57C00)
                        )
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      }
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: new FlatButton(
                      color: Theme.of(context).primaryColorDark,
                      child: const Text(
                        "Guardar",
                        style:  TextStyle(
                          color: Color(0xFFFFFFFF)
                        )
                      ),
                      onPressed: () {
                        _addNewTodo(_nameEditingController.text.toString(), _rateEditingController.text.toString(),_experienceEditingController.text.toString()
                        ,_diagnosticEditingController.text.toString(),_phoneEditingController.text.toString(),_typeEditingController.text.toString());
                        Navigator.pop(context);
                      }
                    ),
                  )
                ],
              )
          ],
          ),
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
      ), 
      
    );
  }

  
  
  void _addNewTodo(String name, String rate, String experience, String diagnostic, String phone, String type) {
    if (name.length > 0 && rate.length > 0 && experience.length > 0 && diagnostic.length > 0 && phone.length > 0 && type.length > 0) {

      JobProfile newProfile = new JobProfile(name, rate, experience, diagnostic, phone, type);

      _database.reference().child("JobProfile").push().set(newProfile.toJson());
    }
  }
}