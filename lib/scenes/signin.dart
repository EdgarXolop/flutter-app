import 'package:flutter/material.dart';
import 'package:ari/scenes/main.dart';
import 'package:ari/util/auth.dart';
class Signin extends StatefulWidget{

  @override
  State<StatefulWidget> createState() => _Signin();

}

class _Signin extends State {
  
  static final formKey = new GlobalKey<FormState>();

  final _formDistance = 15.0;

  String _errorMessage = "";
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    
    TextStyle textStyle1 = Theme.of(context).textTheme.body1;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColorDark,
        automaticallyImplyLeading: false,
        title: Text(
          "Conectarse",
          style: TextStyle(
            color: Theme.of(context).primaryColorLight,
          ),
        ),
        leading: IconButton(icon:Icon(Icons.arrow_back),
          onPressed:() => Navigator.pop(context, false),
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
                    controller: emailController,
                    style: textStyle1,
                    textCapitalization: TextCapitalization.none,
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) => value.isEmpty ? 'Debe ingresar su correo':null,
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
                    obscureText: true,
                    autovalidate: true,
                    controller: passwordController,
                    style: textStyle1,
                    validator: (value) => value.isEmpty ? 'Debe ingresar su contraseña':null,
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
                _showErrorMessage(),
                Padding(
                  padding: EdgeInsets.only(
                    top: _formDistance,
                    bottom: _formDistance
                  ),
                  child: RaisedButton(
                    color: Theme.of(context).primaryColorDark,
                    textColor: Theme.of(context).primaryColorLight,
                    onPressed: ()=>this.signIn(context),
                    child: Text(
                      'Conectarse'
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
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


  void signIn(BuildContext context) async {

    if(this.validateAndSave()){
      try {
        await Auth().signIn(emailController.text, passwordController.text);

        Navigator.push(context, MaterialPageRoute(builder: (context) => Main()));
      } catch (e) {
        setState(() {
         _errorMessage="Usuario inválido"; 
        });
      }

    }
  }
}
