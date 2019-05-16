
import 'dart:async';

import 'package:Ari/models/simple_faq.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class FAQ extends StatefulWidget {
  FAQ() : super();

  @override
  State<StatefulWidget> createState() => FAQState();
}

class FAQState extends State<FAQ> {
  int current_step = 0;
  List<Step> steps;
  List<SimpleFAQ> faqs;
  
  final FirebaseDatabase _database = FirebaseDatabase.instance;
  StreamSubscription<Event> _onAddedFAQ;
  StreamSubscription<Event> _onChangeddFAQ;
  StreamSubscription<Event> _onRemovedFAQ;

  @override
  void initState() {
    super.initState();
    
    // Query _faqsQuery =  _database.reference().child("FAQ").orderByKey();

    // _onAddedFAQ = _faqsQuery.onChildAdded.listen(_onFAQAdded);
    // _onChangeddFAQ = _faqsQuery.onChildChanged.listen(_onFAQChanged);
    // _onRemovedFAQ = _faqsQuery.onChildRemoved.listen(_onFAQRemoved);
  }


  @override
  Widget build(BuildContext context) {
    steps = List<Step>();
    faqs = List<SimpleFAQ>();

    steps.add(new Step(
      title: new Text(
        "¿Cómo inicia Arí?",
        style: TextStyle(
          color: Theme.of(context).primaryColor,
          fontWeight: FontWeight.bold
        ),
      ),
      content: new Text("A partir de la necesidad de encontrar personas capacitadas para servicios del hogar")
      )
    );

    
    steps.add(new Step(
      title: new Text(
        "¿Qué categorias ofrece?",
        style: TextStyle(
          color: Theme.of(context).primaryColor,
          fontWeight: FontWeight.bold
        ),
      ),
      content: new Text("Pintura, Electricidad, Plomería")
      )
    );
    
    steps.add(new Step(
      title: new Text(
        "¿Cuál es el slogan?",
        style: TextStyle(
          color: Theme.of(context).primaryColor,
          fontWeight: FontWeight.bold
        ),
      ),
      content: new Text("Te echamos la mano!")
      )
    );
    
    steps.add(new Step(
      title: new Text(
        "¿En el futuro ofrecerá más categorias?",
        style: TextStyle(
          color: Theme.of(context).primaryColor,
          fontWeight: FontWeight.bold
        ),
      ),
      content: new Text("Se espera hacer una amplicación el próximo año")
      )
    );
    
    steps.add(new Step(
      title: new Text(
        "¿Cuál es el costo de diagnostico?",
        style: TextStyle(
          color: Theme.of(context).primaryColor,
          fontWeight: FontWeight.bold
        ),
      ),
      content: new Text("Tenemos una política de Q100 por diagnostico")
      )
    );
    
    steps.add(new Step(
      title: new Text(
        "¿Qué representa el logotipo?",
        style: TextStyle(
          color: Theme.of(context).primaryColor,
          fontWeight: FontWeight.bold
        ),
      ),
      content: new Text("Es una hormiga que hace referencia a la fuerza de trabajo que ofrecen los técnicos y profesionales")
      )
    );

    return Scaffold(
      appBar: new AppBar(
        elevation: 5,
        backgroundColor: Color(0xFFFFFFFF),
        leading: null,
        title: new Text(
          "Preguntas Frecuentes",
          style: new TextStyle(
            fontSize: 20.0,
            color: Theme.of(context).primaryColor
          ),
        ),
        
      ),
      body: new Stack(
        children: <Widget>[   
          Container(
            height: 600.0,
            child: Stepper(
              currentStep: this.current_step,
              steps: steps,
              type: StepperType.vertical,
              onStepTapped: (step) {
                setState(() {
                  if(steps.length > step)
                    current_step = step;
                });
              },
              onStepContinue: () {
                setState(() {
                  if(current_step < steps.length - 1) {
                    current_step = current_step + 1;
                  }else{
                    current_step = 0;
                  }
                });
              },
              onStepCancel: () {
                setState(() {
                  if(current_step < steps.length - 1){
                    current_step = current_step + 1;
                  }else{
                    current_step = 0;
                  }
                });
              },
            ),
          ),
        ],
      )
    );
  }

  
  void dispose() {
    _onAddedFAQ.cancel();
    _onChangeddFAQ.cancel();
    _onRemovedFAQ.cancel();
    super.dispose();
  }

 void _onFAQAdded(Event event) {
    setState(() {
      SimpleFAQ f = new SimpleFAQ.fromSnapshot(event.snapshot);

      faqs.add(f);

      steps.add(new Step(
        title: new Text(f.answer),
        content: new Text(f.response),
      ));
    });  
  }

  void _onFAQChanged(Event event) {
    var oldEntry = steps.singleWhere((entry) {
      return entry.title.toString() == event.snapshot.value["answer"].toString();
    });

    setState(() {
      steps[steps.indexOf(oldEntry)] = new Step(title: event.snapshot.value["answer"], content: event.snapshot.value["response"]);
      //count = steps.length;
    });
  }

  void _onFAQRemoved(Event event){
    steps.removeWhere((entry) {
      return entry.title.toString() == event.snapshot.value["answer"].toString();
    });

    // setState(() {
    //   count = steps.length;
    // });
  }
}