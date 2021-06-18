import 'dart:async';

import 'package:expandable_bottom_bar/expandable_bottom_bar.dart';
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

class _MapsState extends State<Maps>
    with AutomaticKeepAliveClientMixin, TickerProviderStateMixin {
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
    BottomBarController bbc = BottomBarController(vsync: this);
    PermissionsControl.requestLocationPermission();
    return new Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(PREFERRED_SIZE),
          child: CustomAppBar(
            s: "Map",
            drawerButtonClicked: (check) {
              if (!check) Navigator.pop(context);
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
            backgroundColor: kPrimaryColor,
            onPressed: () => _goToTheLake(bbc),
            label: Text('My Location'),
            icon: Icon(Icons.my_location),
          ),
        ),
      ),
      bottomNavigationBar: BottomExpandableAppBar(
        // Provide the bar controller in build method or default controller as ancestor in a tree
        controller: bbc,
        expandedHeight: 400,
        horizontalMargin: 0,
        expandedBackColor: kPrimaryColor,
        bottomAppBarColor: kPrimaryColor,
        appBarDecoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.zero, bottomRight: Radius.zero)),
        // Your bottom sheet code here
        expandedBody: Column(
          children: [
            ListTile(
              title: Text(
                "Add new address",
                style: TextStyle(color: Colors.white),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.only(bottom: 8.0, left: 8.0, right: 8.0),
              child: Card(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Icon(
                            Icons.location_on_outlined,
                            color: kPrimaryColor,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "85",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Text("Rawalpindi")
                            ],
                          ),
                        ),
                        Align(
                            alignment: Alignment.centerRight,
                            child: Container(
                                padding: EdgeInsets.only(
                                    left: getMeScreenWidthSize() / 3.2),
                                child: IconButton(
                                    onPressed: () {},
                                    icon: Icon(
                                      Icons.edit,
                                      color: kPrimaryColor,
                                    ))))
                      ],
                      crossAxisAlignment: CrossAxisAlignment.start,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 15.0),
                      child: Text(
                        "Street address",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          top: 8.0, bottom: 8.0, left: 15, right: 15),
                      child: Container(
                        height: 45,
                        child: TextField(
                          decoration: new InputDecoration(
                            contentPadding: EdgeInsets.all(5),
                            hintText: "Street",
                            hintTextDirection: TextDirection.ltr,
                            enabledBorder: const OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Colors.grey, width: 0.0),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(padding: const EdgeInsets.only(bottom: 8.0, left: 10.0, right: 10.0),
            child: Container(
              height: 60,
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    decoration: new InputDecoration(
                      contentPadding: EdgeInsets.all(5),
                      hintText: "Floor",
                      hintTextDirection: TextDirection.ltr,
                      enabledBorder: const OutlineInputBorder(
                        borderSide: const BorderSide(
                            color: Colors.grey, width: 0.0),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            )
          ],
        ),
        // Your bottom app bar code here
        bottomAppBarBody: ElevatedButton(
          style: ButtonStyle(
              shape: MaterialStateProperty.all(RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(RADIUS))),
              backgroundColor: MaterialStateProperty.all(Colors.deepPurple)),
          onPressed: () {},
          child: Text(
            "Save Current Location",
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }

  bool openCloseCheck = false;

  Future<void> _goToTheLake(BottomBarController bbc) async {
    bbc.dragLength = 400;
    if (openCloseCheck) {
      bbc.close(velocity: 10.0);
      openCloseCheck = false;
    } else {
      bbc.open(velocity: 10.0);
      openCloseCheck = true;
    }
    var location = Location();
    LocationData currentLocation = await location.getLocation();
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
        target: LatLng(currentLocation.latitude, currentLocation.longitude),
        zoom: 15.151926040649414,
        bearing: 192.8334901395799)));
    setState(() {
      var pinPosition =
          LatLng(currentLocation.latitude, currentLocation.longitude);
      // _marker.removeWhere((element) => element.markerId.value == markerId);
      _marker.clear();
      addMarker(_marker, pinPosition);
    });
  }

  void addMarker(_marker, pinPosition) {
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
