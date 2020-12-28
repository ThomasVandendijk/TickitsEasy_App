import 'package:event_system/rest/registrate.dart';
import 'package:flutter/material.dart';
import 'package:event_system/components/inputfield.dart';

import 'login_page.dart';

class RegistrationPage extends StatefulWidget {
  RegistrationPage();

  @override
  State<StatefulWidget> createState() => new _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _password2Controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: Colors.deepPurple,
        child: Stack(
          children: <Widget>[
            Align(
              alignment: Alignment.bottomRight,
              widthFactor: 0.6,
              heightFactor: 0.6,
              child: Material(
                borderRadius: BorderRadius.all(Radius.circular(200)),
                color: Color.fromRGBO(255, 255, 255, 0.4),
                child: Container(
                  width: 400,
                  height: 400,
                ),
              ),
            ),
            Center(
              child: Form(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      const Padding(padding: EdgeInsets.fromLTRB(8, 40, 8, 4)),
                      CustomInputField(
                          Icon(Icons.person, color: Colors.white), 'Firstname', false, _firstNameController),
                      const Padding(padding: EdgeInsets.all(4.0)),
                      CustomInputField(
                          Icon(Icons.person, color: Colors.white), 'Lastname', false, _lastNameController),
                      const Padding(padding: EdgeInsets.all(4.0)),
                      CustomInputField(
                          Icon(Icons.mail, color: Colors.white), 'Email', false, _emailController),
                      const Padding(padding: EdgeInsets.all(4.0)),
                      CustomInputField(
                          Icon(Icons.lock, color: Colors.white), 'Password', true, _passwordController),
                      const Padding(padding: EdgeInsets.all(4.0)),
                      CustomInputField(
                          Icon(Icons.lock, color: Colors.white), 'Confirm password', true, _password2Controller),
                      const Padding(padding: EdgeInsets.all(4.0)),
                      Container(
                      width: 150,
                      child: RaisedButton(onPressed: (){register(context, 
                        _firstNameController.text, _lastNameController.text, _emailController.text, _passwordController.text);
                        },color: Colors.deepOrange,textColor: Colors.white,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10.0))),
                        child: Text('Register',style: TextStyle(
                            fontSize: 20.0
                          ),
                        ),
                      ),
                    ),
                    _showLoginButton(),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
  }
  Widget _showLoginButton() {
    return new FlatButton(
      child: Text('Have an account? Sign in',
              style: new TextStyle(fontSize: 18.0, fontWeight: FontWeight.w300, color: Colors.white)),
      onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context) => new LoginSignUpPage()));}
    );
  }

}