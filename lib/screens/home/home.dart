import 'dart:io';
import 'package:cscevsev/screens/home/Profil/TabBarDemo.dart';
import 'package:cscevsev/screens/home/camera.dart';
import 'package:cscevsev/services/auth.dart';
import 'package:flutter/material.dart';
import 'file:///C:/apps/cscevsev/lib/screens/home/Profil/profile.dart';
import 'dart:async';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';

class Home extends StatefulWidget {
  Home() : super();

  @override
  HomeState createState() => HomeState();
}

class HomeState extends State<Home> {

  //File imageFile;
  final AuthService _auth = AuthService();

  final _formKey = GlobalKey<FormState>();
  String error = '';
  bool loading = false;

  Completer<GoogleMapController> _controller = Completer();
  static const LatLng _center = const LatLng(41.015137, 28.979530);
  final Set<Marker> _markers = {};
  LatLng _lastMapPosition = _center;
  MapType _currentMapType = MapType.normal;

  static final CameraPosition _position1 = CameraPosition(
    bearing: 192.833,
    target: LatLng(41.015137, 28.979530),
    tilt: 59.440,
    zoom: 11.0,
  );

  Future<void> _goToPosition1() async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(_position1));
  }

  _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
  }

  _onCameraMove(CameraPosition position) {
    _lastMapPosition = position.target;
  }

  _onMapTypeButtonPressed() {
    setState(() {
      _currentMapType = _currentMapType == MapType.normal
          ? MapType.satellite
          : MapType.normal;
    });
  }

  _onAddMarkerButtonPressed() {
    setState(() {
      _markers.add(Marker(
        markerId: MarkerId(_lastMapPosition.toString()),
        position: _lastMapPosition,
        infoWindow: InfoWindow(
          title: 'This is a Title',
          snippet: 'This is a snippet',
        ),
        icon: BitmapDescriptor.defaultMarker,
      ));
    });
  }

  Widget button(Function function, IconData icon) {
    return FloatingActionButton(
      heroTag: null,
      onPressed: function,
      materialTapTargetSize: MaterialTapTargetSize.padded,
      backgroundColor: Colors.green,
      child: Icon(icon, size: 36.0),
    );
  }

  int currentTab = 0; // to keep track of active tab index
  final List<Widget> screens = [
    Home(),
    Camera(),
    TabBarDemo(),
  ]; // to store nested tabs
  final PageStorageBucket bucket = PageStorageBucket();
  Widget currentScreen = Home();

  File imageFile;
  Future getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.camera);
    setState(() {
      imageFile = image;
    });
    //Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {

    return Container(
      child: Scaffold(
        backgroundColor: Colors.blueGrey[100],

        body: Stack(
          children: <Widget>[
            GoogleMap(
              onMapCreated: _onMapCreated,
              initialCameraPosition: CameraPosition(
                target: _center,
                zoom: 11.0,
              ),
              mapType: _currentMapType,
              markers: _markers,
              onCameraMove: _onCameraMove,
            ),
            Padding(
              padding: EdgeInsets.all(16.0),
              child: Align(
                alignment: Alignment.topRight,
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: 16.0,
                    ),
                    button(_onMapTypeButtonPressed, Icons.map),
                    SizedBox(
                      height: 16.0,
                    ),
                    button(_onAddMarkerButtonPressed, Icons.add_location),
                    SizedBox(
                      height: 16.0,
                    ),
                    button(_goToPosition1, Icons.location_searching),
                  ],
                ),
              ),
            ),
            /////////////////////////////////////////
          ],
        ),

        floatingActionButton: FloatingActionButton(
          onPressed: getImage,
          tooltip: 'Pick Image',
          child: Icon(
            Icons.camera,
            size: 35.0,
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,


        bottomNavigationBar: BottomAppBar(
          shape: CircularNotchedRectangle(),
          notchMargin: 8,
          child: Container(
            height: 60,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    MaterialButton(
                      minWidth: 40,
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => Home()));
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(
                            Icons.home,
                            size: 35.0,
                            color: currentTab == 0 ? Colors.blue : Colors.grey,
                          ),
                          Text(
                            'Home',
                            style: TextStyle(
                              color:
                                  currentTab == 0 ? Colors.blue : Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                // Right Tab bar icons

                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    MaterialButton(
                      minWidth: 40,
                      onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => TabBarDemo()));
                    },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(
                            Icons.person,
                            size: 35.0,
                            color: currentTab == 2 ? Colors.blue : Colors.grey,
                          ),
                          Text(
                            'Profile',
                            style: TextStyle(
                              color:
                                  currentTab == 2 ? Colors.blue : Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
