import 'package:cscevsev/models/user.dart';
import 'package:cscevsev/screens/authenticate/authenticate.dart';
import 'package:cscevsev/screens/home/home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final user = Provider.of<User>(context);
    print(user);

    // Ana Sayfa veya Kimlik Doğrulama widget'ını döndürme
    if (user == null){
      return Authenticate();
    } else {
      return Home();
    }

  }
}