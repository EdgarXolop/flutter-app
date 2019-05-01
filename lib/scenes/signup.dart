import 'package:flutter/material.dart';
import 'package:ari/scenes/main.dart';

class Signup extends StatefulWidget{

  @override
  State<StatefulWidget> createState() => _Signup();

}

class _Signup extends State {

  final _formDistance = 15.0;

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController passwordConfirmController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    
    TextStyle textStyle1 = Theme.of(context).textTheme.body1;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColorDark,
        automaticallyImplyLeading: false,
        leading: IconButton(icon:Icon(Icons.arrow_back),
          onPressed:() => Navigator.pop(context, false),
        ),
        title: Text(
          "Conectarse",
          style: TextStyle(
            color: Theme.of(context).primaryColorLight,
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(_formDistance),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
              Padding(
                padding: EdgeInsets.only(
                  top: _formDistance,
                  bottom: _formDistance
                ),
                child: TextField(
                  controller: nameController,
                  style: textStyle1,
                  decoration: InputDecoration(
                    labelText: "Nombre",
                    labelStyle: textStyle1,
                    border: UnderlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                      borderSide: BorderSide(
                        color: Theme.of(context).primaryColorLight
                      )
                    )
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  top: _formDistance,
                  bottom: _formDistance
                ),
                child: TextField(
                  controller: emailController,
                  style: textStyle1,
                  textCapitalization: TextCapitalization.none,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    labelText: "Correo",
                    labelStyle: textStyle1,
                    border: UnderlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                      borderSide: BorderSide(
                        color: Theme.of(context).primaryColorLight
                      )
                    )
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  top: _formDistance,
                  bottom: _formDistance
                ),
                child: TextField(
                  obscureText: true,
                  controller: passwordController,
                  style: textStyle1,
                  decoration: InputDecoration(
                    labelText: "Contraseña",
                    labelStyle: textStyle1,
                    border: UnderlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                      borderSide: BorderSide(
                        color: Theme.of(context).primaryColorLight
                      ),
                    )
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  top: _formDistance,
                  bottom: _formDistance
                ),
                child: TextField(
                  obscureText: true,
                  controller: passwordConfirmController,
                  style: textStyle1,
                  decoration: InputDecoration(
                    labelText: "Confirmar ontraseña",
                    labelStyle: textStyle1,
                    border: UnderlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                      borderSide: BorderSide(
                        color: Theme.of(context).primaryColorLight
                      ),
                    )
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  top: _formDistance,
                  bottom: _formDistance
                ),
                child: RaisedButton(
                  color: Theme.of(context).primaryColorDark,
                  textColor: Theme.of(context).primaryColorLight,
                  onPressed: ()=>this.navigateToMainPage(context),
                  child: Text(
                    'Registrarse'
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }


  void navigateToMainPage(BuildContext context){

    Navigator.push(context, MaterialPageRoute(builder: (context) => Main()));
  }
}
