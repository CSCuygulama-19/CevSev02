import 'package:cscevsev/services/auth.dart';
import 'package:cscevsev/shared/SplashScreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cscevsev/models/user.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>.value(
      value: AuthService().user,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: SplashScreen(),
      ),
    );
  }
}
