import 'package:event_system/rest/registrate.dart';
import 'package:flutter/material.dart';
import 'package:event_system/components/inputfield.dart';
import 'package:event_system/components/formfield.dart';
import 'package:event_system/constants/error_messages.dart';
import 'package:event_system/constants/normal_messages.dart';
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

  final _formKey = GlobalKey<FormState>();

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
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      const Padding(padding: EdgeInsets.fromLTRB(8, 40, 8, 4)),
                      CustomFormField(
                          Icon(Icons.person, color: Colors.white), _isEmptyValidationFormField(false, 'Firstname', _firstNameController)),
                      const Padding(padding: EdgeInsets.all(4.0)),
                      CustomFormField(
                          Icon(Icons.person, color: Colors.white), _isEmptyValidationFormField(false, 'Lastname', _lastNameController)),
                      const Padding(padding: EdgeInsets.all(4.0)),
                      CustomFormField(
                          Icon(Icons.mail, color: Colors.white), _isEmptyValidationFormField(false, 'Email', _emailController)),
                      const Padding(padding: EdgeInsets.all(4.0)),
                      CustomFormField(
                          Icon(Icons.lock, color: Colors.white), _passwordFormField('Password', _passwordController)),
                      const Padding(padding: EdgeInsets.all(4.0)),
                      CustomFormField(
                          Icon(Icons.lock, color: Colors.white), _confirmPasswordFormField('Confirm Password', _password2Controller)),
                      const Padding(padding: EdgeInsets.all(4.0)),
                      Container(
                      width: 150,
                      child: RaisedButton(onPressed: (){registerForm(context);
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

  void registerForm(BuildContext context){
    if (_formKey.currentState.validate()) {
        // If the form is valid, display a Snackbar.
        Scaffold.of(context)
            .showSnackBar(SnackBar(content: Text(PROCESSING)));
        register(context, _firstNameController.text, _lastNameController.text, _emailController.text, _passwordController.text);
    }
  }

  
  TextFormField _isEmptyValidationFormField(bool obscureText, String hintText, TextEditingController editingController) {
    return TextFormField(
        validator: (value) {
            if (value.isEmpty) {
              return NOT_FILLED_IN;
            }
            return null;
          },
        controller: editingController,
        obscureText: obscureText,
        decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(vertical: 3, horizontal: 5),
            // border: InputBorder.none,
            hintText: hintText,
            fillColor: Colors.white,
            filled: true,
        ),
        style: TextStyle(
            fontSize: 20.0,
            color: Colors.black
        ),
      );
  }

  TextFormField _passwordFormField(String hintText, TextEditingController editingController) {
    return TextFormField(
        validator: (value) {
            return passwordCheck(value);
        },
        controller: editingController,
        obscureText: true,
        decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(vertical: 3, horizontal: 5),
            // border: InputBorder.none,
            hintText: hintText,
            fillColor: Colors.white,
            filled: true,
        ),
        style: TextStyle(
            fontSize: 20.0,
            color: Colors.black
        ),
      );
  }

  TextFormField _confirmPasswordFormField(String hintText, TextEditingController editingController) {
    return TextFormField(
        validator: (value) {
            return password2Check(_passwordController.text, value);
        },
        controller: editingController,
        obscureText: true,
        decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(vertical: 3, horizontal: 5),
            // border: InputBorder.none,
            hintText: hintText,
            fillColor: Colors.white,
            filled: true,
        ),
        style: TextStyle(
            fontSize: 20.0,
            color: Colors.black
        ),
      );
  }

  String passwordCheck(String password){
    int minLength = 8;

    if (password == null || password.isEmpty) {
    return NOT_FILLED_IN;
    }

    bool hasMinLength = password.length > minLength;
    bool hasDigits = password.contains(new RegExp(r'[0-9]'));
    bool hasUppercase = password.contains(new RegExp(r'[A-Z]'));
    bool hasLowercase = password.contains(new RegExp(r'[a-z]'));
    //bool hasSpecialCharacters = password.contains(new RegExp(r'[!@#$%^&*(),.?":{}|<>]'));

    if (!hasMinLength) {
      return INPUT_TOO_SHORT;
    }

    if (!hasDigits){
      return NO_DIGITS;
    }

    if (!hasUppercase){
      return NO_UPPERCASE;
    }

    if (!hasLowercase){
      return NO_LOWERCASE;
    }

    // if (!hasSpecialCharacters){
    //   return NO_SPECIAL_CHARACTERS;
    // }

    return null;
  }

  String password2Check(String password, String password2){
    if (password2 == null || password2.isEmpty) {
    return NOT_FILLED_IN;
    }

    if (password != password2){
      return PASSWORDS_DONT_MATCH;
    }

    return null;


  }
}