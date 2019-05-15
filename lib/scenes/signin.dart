import 'package:flutter/material.dart';
import 'package:Ari/scenes/main.dart';
import 'package:Ari/util/auth.dart';
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

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColorDark,
        automaticallyImplyLeading: false,
        title: Text(
          "CONECTARSE",
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
                new Padding(
                  padding: EdgeInsets.only(top: 10.0)),
                  new TextFormField(
                    controller: emailController,
                    decoration: new InputDecoration(
                      labelText: "Correo",
                      fillColor: Colors.white,
                      border: new OutlineInputBorder(
                        borderRadius: new BorderRadius.circular(25.0),
                        borderSide: new BorderSide(
                        ),
                      ),
                    ),
                    validator: (val) {
                      if(val.length == 0) {
                        return "Debe ingresar su correo";
                      }else{
                        return null;
                      }
                    },
                    keyboardType: TextInputType.emailAddress,
                    style: new TextStyle(
                      fontFamily: "Poppins",
                    ),
                  ),
                Padding(
                  padding: EdgeInsets.only(top: 10.0)),
                  new TextFormField(
                    obscureText: true,
                    controller: passwordController,
                    decoration: new InputDecoration(
                      labelText: "Contraseña",
                      fillColor: Colors.white,
                      border: new OutlineInputBorder(
                        borderRadius: new BorderRadius.circular(25.0),
                        borderSide: new BorderSide(
                        ),
                      ),
                    ),
                    validator: (val) {
                      if(val.length == 0) {
                        return "Debe ingresar su contraseña";
                      }else{
                        return null;
                      }
                    },
                    keyboardType: TextInputType.emailAddress,
                    style: new TextStyle(
                      fontFamily: "Poppins",
                    ),
                  ),
                _showErrorMessage(),
                Padding(
                  padding: EdgeInsets.only(
                    top: _formDistance,
                    bottom: _formDistance
                  ),
                  child: RaisedButton(
                    padding: EdgeInsets.only(
                      top: 17.0,
                      bottom: 17.0
                    ),
                    color: Theme.of(context).buttonColor,
                    textColor: Theme.of(context).primaryColorLight,
                    shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(25.0)),
                    onPressed: ()=>this.signIn(context),
                    child: Text(
                      'Conectarse',
                      style: TextStyle(
                        fontSize: 20.0,
                        fontFamily: "Poppins"
                      ),
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
      
      showDialog(
        context: context,
        barrierDismissible: false,
        child: getSpinner()
      );

      try {
        await Auth().signIn(emailController.text, passwordController.text);

        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Main()));
      } catch (e) {
        setState(() {
         _errorMessage="Usuario inválido";
          Navigator.pop(context);
        });
      }

    }
  }

  
  Widget getSpinner(){
    return new Stack(
      children: [
        new Opacity(
          opacity: 0.3,
          child: const ModalBarrier(dismissible: false, color: Colors.grey),
        ),
        new Center(
          child: new CircularProgressIndicator(),
        ),
        new Center(
          child: new CircularProgressIndicator(),
        ),
      ],
    );
  }
}
