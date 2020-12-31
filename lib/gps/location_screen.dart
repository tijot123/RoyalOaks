import 'dart:async';
import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter_app/api/api_provider.dart';
import 'package:flutter_app/common/common_bg_inner_container.dart';
import 'package:flutter_app/common/loading_dialog.dart';
import 'package:flutter_app/helper/map_utils.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class LocationScreen extends StatefulWidget {
  final LocationData locationData;

  const LocationScreen({Key key, @required this.locationData})
      : super(key: key);

  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  Completer<GoogleMapController> _controller = Completer();
  static LatLng _center = LatLng(45.649268385921395, -122.5771276652813);
  CameraPosition _initialPosition = CameraPosition(
    target: _center,
    zoom: 15.4746,
  );
  Set<Polygon> _polygons = HashSet();
  var _polygonIdCounter = 1;
  List<LatLng> fairwayStarLatLngs = [];
  List<LatLng> greenLatLngs = [];
  MapType _mapType;

  @override
  void initState() {
    if (mounted)
      setState(() {
        _mapType = MapType.satellite;
      });
    _setPolygon(Colors.blueAccent, MapUtils.mainCoordinates);
    ApiProvider().coordinatesRequest().then((value) {
      var coordinates = value.data.coordinates;
      for (int i = 0; i < coordinates.length; i++) {
        _setPolygon(Colors.redAccent, [
          LatLng(double.parse(coordinates[i].teeFrontLeftLatitude),
              double.parse(coordinates[i].teeFrontLeftLongitude)),
          LatLng(double.parse(coordinates[i].teeFrontRightLatitude),
              double.parse(coordinates[i].teeFrontRightLongitude)),
          LatLng(double.parse(coordinates[i].teeBackRightLatitude),
              double.parse(coordinates[i].teeBackRightLongitude)),
          LatLng(double.parse(coordinates[i].teeBackLeftLatitude),
              double.parse(coordinates[i].teeBackLeftLongitude))
        ]);
      }
    }).catchError((error) {
      debugPrint(error.toString());
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CommonBgInnerContainer(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: Text("Location"),
          centerTitle: true,
          actions: [
            Column(
              children: [
                Flexible(
                  child: IconButton(
                      icon: Icon(
                        _mapType == MapType.satellite
                            ? Icons.map
                            : Icons.satellite,
                      ),
                      onPressed: () {
                        if (mounted)
                          setState(() {
                            if (_mapType == MapType.satellite)
                              _mapType = MapType.normal;
                            else
                              _mapType = MapType.satellite;
                          });
                      }),
                ),
                Flexible(
                    child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Text(
                      _mapType == MapType.satellite ? "Normal" : "Satellite"),
                ))
              ],
            )
          ],
        ),
        body: GoogleMap(
            initialCameraPosition: _initialPosition,
            onMapCreated: _onMapCreated,
            myLocationButtonEnabled: false,
            polygons: _polygons,
            onCameraMove: (CameraPosition position) async {
              var targetLatLng = position.target;
              var validArea = MapUtils.checkIfValidArea(
                  targetLatLng, MapUtils.mainCoordinates);
              if (validArea) {
                await Future.delayed(Duration(milliseconds: 2000), () {});
                var mapController = await _controller.future;
                mapController.animateCamera(
                  CameraUpdate.newCameraPosition(
                    CameraPosition(
                      target: _center,
                      zoom: 15.4746,
                    ),
                  ),
                );
              }
            },
            mapType: _mapType,
            zoomControlsEnabled: false),
      ),
    );
  }

  void _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
  }

  void _setPolygon(Color color, List<LatLng> points) {
    if (mounted)
      setState(() {
        _polygonIdCounter++;
        String polygonIdVal = 'polygon_id_$_polygonIdCounter';
        debugPrint(polygonIdVal);
        _polygons.add(Polygon(
          polygonId: PolygonId(polygonIdVal),
          points: points,
          geodesic: true,
          strokeWidth: 2,
          fillColor: Colors.transparent,
          strokeColor: color,
        ));
      });
  }

  @override
  void dispose() {
    super.dispose();
  }
}
