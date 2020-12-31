import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'common/common_bg_inner_container.dart';
import 'helper/map_utils.dart';

class ContactUsScreen extends StatefulWidget {
  @override
  _ContactUsScreenState createState() => _ContactUsScreenState();
}

class _ContactUsScreenState extends State<ContactUsScreen> {
  Completer<GoogleMapController> _controller = Completer();
  static LatLng _center = LatLng(45.653292, -122.576327);
  final CameraPosition _initialPosition = CameraPosition(
    target: _center,
    zoom: 14.4746,
  );
  Set<Marker> _markers = {};
  BitmapDescriptor pinLocationIcon;

  bool _isDiningClicked = true;
  bool _isGolfShopClicked = false;
  bool _isFitnessCenterClicked = false;

  var _diningArray = [
    "Sunday : 6:00AM - 3:00PM",
    "Monday : Closed",
    "Tuesday : 11:00AM - 3:00PM",
    "Wednesday : 9:00AM - 8:30PM",
    "Thursday : 9:00AM - 8:00PM",
    "Friday : 9:00AM - 8:00PM",
    "Saturday : 6:00AM - 8:00PM"
  ];
  var _golfShopArray = [
    "Sunday : 6:00AM - 5:00PM",
    "Monday : 10:00AM - 5:00PM",
    "Tuesday : 8:00AM - 5:00PM",
    "Wednesday : 8:00AM - 5:00PM",
    "Thursday : 8:00AM - 5:00PM",
    "Friday : 7:00AM - 5:00PM",
    "Saturday : 6:00AM - 5:00PM"
  ];
  var _fitnessCenterArray = [
    "Sunday : 6:00AM - 8:00PM",
    "Monday : 6:00AM - 8:00PM",
    "Tuesday : 6:00AM - 8:00PM",
    "Wednesday : 6:00AM - 8:00PM",
    "Thursday : 6:00AM - 8:00PM",
    "Friday : 6:00AM - 8:00PM",
    "Saturday : 6:00AM - 8:00PM"
  ];

  Map<int, Widget> map = Map();

  int selectedIndex = 0;

  void _createCustomMarker() {
    ImageConfiguration configuration =
        ImageConfiguration(devicePixelRatio: 2.5, size: Size(8, 8));
    BitmapDescriptor.fromAssetImage(configuration, 'assets/img/marker.png')
        .then((value) {
      setState(() {
        pinLocationIcon = value;
      });
    });
  }

  void loadCupertinoTabs() {
    map = Map();
//putIfAbsent takes a key and a function callback that has return a value to that key.
    map.putIfAbsent(
        0,
        () => Text(
              "   Dining   ",
              style: TextStyle(color: Colors.black),
            ));
    map.putIfAbsent(
        1,
        () => Text(
              "   Golf Shop   ",
              style: TextStyle(color: Colors.black),
            ));
    map.putIfAbsent(
        2,
        () => Text(
              "   Fitness Center   ",
              style: TextStyle(color: Colors.black),
            ));
  }

  @override
  void initState() {
    loadCupertinoTabs();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _createCustomMarker();
    return CommonBgInnerContainer(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          centerTitle: true,
          title: Text("Contact Us"),
        ),
        body: Column(
          children: [
            Flexible(
              child: Stack(
                children: [
                  SizedBox(
                    child: GoogleMap(
                      myLocationButtonEnabled: false,
                      trafficEnabled: true,
                      buildingsEnabled: true,
                      indoorViewEnabled: true,
                      markers: _markers,
                      mapType: MapType.terrain,
                      initialCameraPosition: _initialPosition,
                      zoomControlsEnabled: false,
                      onMapCreated: (GoogleMapController controller) {
                        _controller.complete(controller);
                        setState(() {
                          _markers.add(Marker(
                              draggable: false,
                              markerId: MarkerId('1001'),
                              position: _center,
                              icon: pinLocationIcon));
                        });
                      },
                    ),
                    height: 200,
                  ),
                  Positioned(
                    bottom: 10,
                    right: 10,
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.green, shape: BoxShape.circle),
                      child: IconButton(
                        color: Colors.white,
                        iconSize: 30,
                        icon: Icon(Icons.directions),
                        onPressed: () {
                          MapUtils.openMap(_center.latitude, _center.longitude);
                        },
                      ),
                    ),
                  )
                ],
              ),
            ),
            Expanded(
              flex: 2,
              child: Column(
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.all(6.0),
                      child: Text(
                        "Royal Oaks Country Club • 8917 N.E. Fourth Plain Blvd. Vancouver, WA 98662",
                        style: TextStyle(fontSize: 14),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(6.0),
                    child: Container(
                      height: 2,
                      color: Color(0xFFCAE4BA),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      IconButton(
                        icon: Icon(Icons.phone),
                        onPressed: () {
                          _launchCaller("tel:3602561250");
                        },
                      ),
                      InkWell(
                        onTap: () {
                          _launchCaller("tel:3602561250");
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(6.0),
                          child: Text(
                            "Dining\n360.256.1250",
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                      ),
                      Container(
                        width: 2,
                        height: 50,
                        color: Color(0xFFCAE4BA),
                      ),
                      IconButton(
                        icon: Icon(Icons.phone),
                        onPressed: () {
                          _launchCaller("tel:3602561350");
                        },
                      ),
                      InkWell(
                        onTap: () {
                          _launchCaller("tel:3602561350");
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(6.0),
                          child: Text(
                            "Golf Shop\n360.256.1350",
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(6.0),
                    child: Container(
                      height: 2,
                      color: Color(0xFFCAE4BA),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(6.0),
                    child: CupertinoSegmentedControl(
                      borderColor: Colors.lightGreenAccent,
                      onValueChanged: (value) {
                        debugPrint(value.toString());
                        setState(() {
                          selectedIndex = value;
                          if (selectedIndex == 0) {
                            _isDiningClicked = true;
                            _isGolfShopClicked = false;
                            _isFitnessCenterClicked = false;
                          } else if (selectedIndex == 1) {
                            _isDiningClicked = false;
                            _isGolfShopClicked = true;
                            _isFitnessCenterClicked = false;
                          } else {
                            _isDiningClicked = false;
                            _isGolfShopClicked = false;
                            _isFitnessCenterClicked = true;
                          }
                        });
                      },
                      groupValue: selectedIndex,
                      selectedColor: Colors.green,
                      pressedColor: Colors.green,
                      unselectedColor: Colors.white,
                      children: map,
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.white, width: 2)),
                        child: ListView.builder(
                            itemCount: 7,
                            itemBuilder: (ctx, index) {
                              var array = [];
                              if (_isFitnessCenterClicked)
                                array = _fitnessCenterArray;
                              else if (_isGolfShopClicked)
                                array = _golfShopArray;
                              else
                                array = _diningArray;
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      array[index],
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(6.0),
                                    child: Container(
                                      height: 1,
                                      color: Color(0xFFCAE4BA),
                                    ),
                                  ),
                                ],
                              );
                            }),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  _launchCaller(String tel) async {
    if (await canLaunch(tel)) {
      await launch(tel);
    } else {
      throw 'Could not launch $tel';
    }
  }

  @override
  void dispose() {
    super.dispose();
  }
}
