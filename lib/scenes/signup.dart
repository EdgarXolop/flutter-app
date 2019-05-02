import 'package:flutter/material.dart';
import 'package:ari/scenes/main.dart';
import 'package:ari/util/auth.dart';

class Signup extends StatefulWidget{

  @override
  State<StatefulWidget> createState() => _Signup();

}

class _Signup extends State {

  
  static final formKey = new GlobalKey<FormState>();

  final _formDistance = 15.0;

  String _errorMessage = "";

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
        child: Form(
          key: formKey,
          child: ListView(
            children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(
                    top: _formDistance,
                    bottom: _formDistance
                  ),
                  child: TextFormField(
                    autovalidate: true,
                    controller: nameController,
                    style: textStyle1,
                    validator: (value) => value.isEmpty ? 'Debe ingresar su nombre':null,
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
                  child: TextFormField(
                    autovalidate: true,
                    controller: emailController,
                    style: textStyle1,
                    textCapitalization: TextCapitalization.none,
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) => value.isEmpty ? 'Debe ingresar el correo':null,
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
                  child: TextFormField(
                    autovalidate: true,
                    obscureText: true,
                    controller: passwordController,
                    style: textStyle1,
                    validator: (value) => value.isEmpty ? 'Debe ingresar la contraseña':null,
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
                  child: TextFormField(
                    autovalidate: true,
                    obscureText: true,
                    controller: passwordConfirmController,
                    style: textStyle1,
                    validator: _validatePassword,
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
                _showErrorMessage(),
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
      ),
    );
  }

  String _validatePassword(String value){
    String message = "";

    if(passwordController.text != value ) message = "Las contraseñas no coinciden";
    else if(value.length == 0) message = "Debe de confirmar la contraseña";
    else message = null;

    return message;

  }
  
  Widget _showErrorMessage() {
    if ( _errorMessage.length > 0 ) {
      return new Text(
        _errorMessage,
        style: TextStyle(
            fontSize: 13.0,
            color: Colors.red,
            height: 1.0,
            fontWeight: FontWeight.w300),
      );
    } else {
      return new Container(
        height: 0.0,
      );
    }
  }

  bool validateAndSave() {
      final form = formKey.currentState;
      if (form.validate()) {
        form.save();
        return true;
      }
      return false;
  }

  void navigateToMainPage(BuildContext context) async{

    if(this.validateAndSave()){
      try {
        await Auth().createUserWithName(nameController.text, emailController.text, passwordController.text);

        Navigator.push(context, MaterialPageRoute(builder: (context) => Main()));
      } catch (e) {
        setState(() {
         _errorMessage="Datos inválidos"; 
        });
      }

    }
  }
}
