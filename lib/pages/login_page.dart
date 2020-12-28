import 'package:event_system/rest/login.dart';
import 'package:flutter/material.dart';
import 'package:event_system/components/inputfield.dart';
import 'package:event_system/pages/registration_page.dart';


class LoginSignUpPage extends StatefulWidget {
  LoginSignUpPage();

  @override
  State<StatefulWidget> createState() => new _LoginSignUpPageState();
 
}

enum FormMode { LOGIN, SIGNUP }

class _LoginSignUpPageState extends State<LoginSignUpPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Container(
        width: width,
        height: height,
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
                  children: <Widget>[
                    Padding(padding: EdgeInsets.fromLTRB(8, width/6, 8, 4)),
                    CircleAvatar(child: Image.asset("assets/ticket_logo.png"),backgroundColor: Colors.white, radius: 50,),
                    Padding(padding: EdgeInsets.fromLTRB(8, width/80, 8, 4)),
                    CustomInputField(
                        Icon(Icons.mail, color: Colors.white), 'Email', false, _emailController),
                    Padding(padding: EdgeInsets.fromLTRB(8, width/23, 8, 4)),
                    CustomInputField(
                        Icon(Icons.lock, color: Colors.white), 'Password', true, _passwordController),
                    Padding(padding: EdgeInsets.fromLTRB(8, width/23, 8, 4)),
                    Container(
                      width: 150,
                      child: RaisedButton(onPressed: (){login(context, _emailController.text, _passwordController.text);},color: Colors.deepOrange,textColor: Colors.white,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10.0))),
                        child: Text('Login',style: TextStyle(
                            fontSize: 20.0
                        ),),),
                    ),
                    _showCreateAccountButton(),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
  }

  Widget _showCreateAccountButton() {
    return new FlatButton(
      child: Text('Create an account',
              style: new TextStyle(fontSize: 18.0, fontWeight: FontWeight.w300, color: Colors.white)),
      onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context) => new RegistrationPage()));}
    );
  }

}