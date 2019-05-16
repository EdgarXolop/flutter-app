import 'package:flutter/material.dart';
import 'package:Ari/scenes/main.dart';
import 'package:Ari/util/auth.dart';

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
    

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColorDark,
        automaticallyImplyLeading: false,
        leading: IconButton(icon:Icon(Icons.arrow_back),
          onPressed:() => Navigator.pop(context, false),
        ),
        title: Text(
          "REGISTRARSE",
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
                    top: 10.0,
                  )),
                  new TextFormField(
                    controller: nameController,
                    decoration: new InputDecoration(
                      labelText: "Nombre",
                      fillColor: Colors.white,
                      border: new OutlineInputBorder(
                        borderRadius: new BorderRadius.circular(25.0),
                        borderSide: new BorderSide(
                        ),
                      ),
                    ),
                    validator: (val) {
                      if(val.length == 0) {
                        return "Debe ingresar su nombre";
                      }else{
                        return null;
                      }
                    },
                    keyboardType: TextInputType.emailAddress,
                    style: new TextStyle(
                      fontFamily: "Poppins",
                    ),
                  ),
                  // child: TextFormField(
                  //   autovalidate: true,
                  //   controller: nameController,
                  //   style: textStyle1,
                  //   validator: (value) => value.isEmpty ? 'Debe ingresar su nombre':null,
                  //   decoration: InputDecoration(
                  //     labelText: "Nombre",
                  //     labelStyle: textStyle1,
                  //     border: UnderlineInputBorder(
                  //       borderRadius: BorderRadius.circular(5.0),
                  //       borderSide: BorderSide(
                  //         color: Theme.of(context).primaryColorLight
                  //       )
                  //     )
                  //   ),
                  // ),
                //),
                Padding(
                  padding: EdgeInsets.only(
                    top: 10.0
                  )),
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
                        return "Debe ingresar el correo";
                      }else{
                        return null;
                      }
                    },
                    keyboardType: TextInputType.emailAddress,
                    style: new TextStyle(
                      fontFamily: "Poppins",
                    ),
                  ),
                //   child: TextFormField(
                //     autovalidate: true,
                //     controller: emailController,
                //     style: textStyle1,
                //     textCapitalization: TextCapitalization.none,
                //     keyboardType: TextInputType.emailAddress,
                //     validator: (value) => value.isEmpty ? 'Debe ingresar el correo':null,
                //     decoration: InputDecoration(
                //       labelText: "Correo",
                //       labelStyle: textStyle1,
                //       border: UnderlineInputBorder(
                //         borderRadius: BorderRadius.circular(5.0),
                //         borderSide: BorderSide(
                //           color: Theme.of(context).primaryColorLight
                //         )
                //       )
                //     ),
                //   ),
                // ),
                Padding(
                  padding: EdgeInsets.only(
                    top: 10.0
                  )),
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
                        return "Debe ingresar el contraseña";
                      }else{
                        return null;
                      }
                    },
                    keyboardType: TextInputType.emailAddress,
                    style: new TextStyle(
                      fontFamily: "Poppins",
                    ),
                  ),
                //   child: TextFormField(
                //     autovalidate: true,
                //     obscureText: true,
                //     controller: passwordController,
                //     style: textStyle1,
                //     validator: (value) => value.isEmpty ? 'Debe ingresar la contraseña':null,
                //     decoration: InputDecoration(
                //       labelText: "Contraseña",
                //       labelStyle: textStyle1,
                //       border: UnderlineInputBorder(
                //         borderRadius: BorderRadius.circular(5.0),
                //         borderSide: BorderSide(
                //           color: Theme.of(context).primaryColorLight
                //         ),
                //       )
                //     ),
                //   ),
                // ),
                Padding(
                  padding: EdgeInsets.only(
                    top: 10.0
                  )),
                  new TextFormField(
                    obscureText: true,
                    controller: passwordConfirmController,
                    decoration: new InputDecoration(
                      labelText: "Confirme Contraseña",
                      fillColor: Colors.white,
                      border: new OutlineInputBorder(
                        borderRadius: new BorderRadius.circular(25.0),
                        borderSide: new BorderSide(
                        ),
                      ),
                    ),
                    validator: _validatePassword,
                    keyboardType: TextInputType.emailAddress,
                    style: new TextStyle(
                      fontFamily: "Poppins",
                    ),
                  ),
                //   child: TextFormField(
                //     autovalidate: true,
                //     obscureText: true,
                //     controller: passwordConfirmController,
                //     style: textStyle1,
                //     validator: _validatePassword,
                //     decoration: InputDecoration(
                //       labelText: "Confirmar ontraseña",
                //       labelStyle: textStyle1,
                //       border: UnderlineInputBorder(
                //         borderRadius: BorderRadius.circular(5.0),
                //         borderSide: BorderSide(
                //           color: Theme.of(context).primaryColorLight
                //         ),
                //       )
                //     ),
                //   ),
                // ),
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
                    onPressed: ()=>this.navigateToMainPage(context),
                    child: Text(
                      'Registrarse',
                      style: TextStyle(
                        fontSize: 20.0,
                        fontFamily: "Poppins"
                      ),
                    ),
                    shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(25.0))
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
      showDialog(
        context: context,
        barrierDismissible: false,
        child: getSpinner()
      );

      try {
        await Auth().createUserWithName(nameController.text, emailController.text, passwordController.text);

        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Main()));
      } catch (e) {
        setState(() {
         _errorMessage = "Datos inválidos"; 
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
