import 'dart:async';

import "package:flutter/material.dart";
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:letskhareedo/WebServices/WebServiceHttp.dart';
import 'package:letskhareedo/constants/constant.dart';
import 'package:letskhareedo/custom_widgets/CustomAppBar.dart';
import 'package:letskhareedo/permission.dart';
import 'package:location/location.dart';

class Maps extends StatefulWidget {
  const Maps({Key key}) : super(key: key);

  @override
  _MapsState createState() => _MapsState();
}

class _MapsState extends State<Maps> with AutomaticKeepAliveClientMixin {
  static const String markerId = 'id-1';
  Completer<GoogleMapController> _controller = Completer();
  double lat = 31.578;
  double lng = 71.191;
  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(69.3451, 30.375),
    zoom: 14.4746,
  );

  Set<Marker> _marker = {};

  double getMeScreenHeightSize() {
    return MediaQuery.of(context).size.height *
        MediaQuery.of(context).devicePixelRatio;
  }

  double getMeScreenWidthSize() {
    return MediaQuery.of(context).size.width *
        MediaQuery.of(context).devicePixelRatio;
  }

  @override
  Widget build(BuildContext context) {
    PermissionsControl.requestLocationPermission();
    return new Scaffold(
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(PREFERRED_SIZE),
          child: CustomAppBar(
            s: "Map",
            drawerButtonClicked: () {
              Navigator.pop(context);
            },
          )),
      body: Container(
        height: getMeScreenHeightSize(),
        width: getMeScreenWidthSize(),
        child: GoogleMap(
          mapType: MapType.normal,
          initialCameraPosition: _kGooglePlex,
          markers: _marker,
          onMapCreated: (GoogleMapController controller) {
            setState(() {
              _marker.add(Marker(
                  markerId: MarkerId(markerId), position: LatLng(lat, lng)));
            });
            _controller.complete(controller);
          },
          // markers: ,
        ),
      ),
      floatingActionButton: Align(
        alignment: Alignment.bottomLeft,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: FloatingActionButton.extended(
            onPressed: _goToTheLake,
            label: Text('My Location'),
            icon: Icon(Icons.my_location),
          ),
        ),
      ),
    );
  }

  Future<void> _goToTheLake() async {
    var location = Location();
    LocationData currentLocation = await location.getLocation();
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
        target: LatLng(currentLocation.latitude, currentLocation.longitude),
        zoom: 15.151926040649414,
        bearing: 192.8334901395799)));
    setState((){
      var pinPosition =
          LatLng(currentLocation.latitude, currentLocation.longitude);
      // _marker.removeWhere((element) => element.markerId.value == markerId);
      _marker.clear();
      addMarker(_marker, pinPosition);
    });
  }

  void addMarker(_marker, pinPosition){
    setState(() {
      _marker.add(Marker(
        markerId: MarkerId(markerId),
        position: pinPosition,
      ));
    });
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
