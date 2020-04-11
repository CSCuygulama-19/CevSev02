import 'package:cscevsev/services/auth.dart';
import 'package:cscevsev/shared/constants.dart';
import 'package:cscevsev/shared/loading.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/*
Eksikler--

1- 'şifrenizi mi unuttunuz?'
2- Google girişi

*/

class SignIn extends StatefulWidget {
  final Function toggleView;
  SignIn({this.toggleView});

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  String error = '';
  bool loading = false;

  // text field state
  String email = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            backgroundColor: Colors.white,
            body: Container(
              //alignment: Alignment(0,0),
              height: 800.0,
              color: Colors.white70,
              /*
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('images/back2.jpg'),
                fit: BoxFit.fill
            )
        ),
         */
              padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
              child: Form(
                key: _formKey,
                child: SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      SizedBox(height: 50.0),
                      Image.asset("images/original.png",
                          width: 170, height: 170),
                      SizedBox(height: 40.0),
                      TextFormField(
                        decoration: textInputDecoration.copyWith(
                          labelText: "email",
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25.0),
                            borderSide: BorderSide(
                              color: Colors.blue.shade700,
                              width: 2.0,
                            ),
                          ),
                        ),
                        validator: (val) =>
                            val.isEmpty ? 'Enter an email' : null,
                        onChanged: (val) {
                          setState(() => email = val);
                        },
                      ),
                      SizedBox(height: 20.0),
                      TextFormField(
                        obscureText: true,
                        decoration: textInputDecoration.copyWith(
                          labelText: "password",
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25.0),
                            borderSide: BorderSide(
                              color: Colors.blue.shade700,
                              width: 2.0,
                            ),
                          ),
                        ),
                        validator: (val) => val.length < 6
                            ? 'Enter a password 6+ chars long'
                            : null,
                        onChanged: (val) {
                          setState(() => password = val);
                        },
                      ),
                      SizedBox(height: 50.0),
                      RaisedButton(
                          shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(30.0),
                            //side: BorderSide(color: Colors.red)
                          ),
                          color: Colors.green.shade600,
                          padding: EdgeInsets.symmetric(
                              vertical: 10, horizontal: 120),
                          child: Text(
                            'Sign In',
                            style: TextStyle(
                              color: Colors.white,
                              //fontFamily: "DancingScript",
                              fontSize: 20.0,
                            ),
                          ),
                          onPressed: () async {
                            if (_formKey.currentState.validate()) {
                              setState(() => loading = true);
                              dynamic result = await _auth
                                  .signInWithEmailAndPassword(email, password);
                              if (result == null) {
                                setState(() {
                                  loading = false;
                                  error =
                                      'Could not sign in with those credentials';
                                });
                              }
                            }
                          }),
                      SizedBox(height: 8.0),
                      Text(
                        error,
                        style: TextStyle(color: Colors.red, fontSize: 14.0),
                      ),

                      //SizedBox(height: 12.0),
                      SingleChildScrollView(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                                "Don't have an account?",
                              style: TextStyle(
                                color: Colors.black54,
                                fontSize: 18.0,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            FlatButton(
                              child: Text(
                                "Sign up",
                                style: TextStyle(
                                  color: Colors.red,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18.0,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              onPressed: () => widget.toggleView(),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
  }
}
