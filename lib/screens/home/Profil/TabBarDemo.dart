import 'package:flutter/material.dart';
import './profile.dart' as profile;
import './most_environmentalists.dart' as most;
import './events.dart' as events;

void main() {
  runApp(TabBarDemo());
}

class TabBarDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(75.0),
            child: AppBar(
              //backgroundColor: Colors.lightBlue,
              bottom: TabBar(
                tabs: <Widget>[
                  new Tab(
                    icon: const Icon(Icons.person),
                    text: 'Profil',
                  ),
                  new Tab(
                    icon: const Icon(Icons.event),
                    text: 'Etkinliklerim',
                  ),
                  new Tab(
                    icon: const Icon(Icons.supervised_user_circle),
                    text: 'En Çevreciler',
                  ),
                ],
              ),
            ),
          ),

          body: TabBarView(
            children: <Widget>[
              new profile.Profil(),
              new most.Most(),
              new events.Events(),
            ],
          ),
        ),
      ),
    );
  }
}
