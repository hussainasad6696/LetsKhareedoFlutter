import 'dart:async';

import 'package:expandable_bottom_bar/expandable_bottom_bar.dart';
import "package:flutter/material.dart";
import 'package:geocoder/geocoder.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:letskhareedo/constants/constant.dart';
import 'package:letskhareedo/constants/size_config.dart';
import 'package:letskhareedo/custom_widgets/CustomAppBar.dart';
import 'package:letskhareedo/device_db/hive/HiveMethods.dart';
import 'package:letskhareedo/device_db/userAddresses/mapDetailModel.dart';
import 'package:letskhareedo/permission.dart';
import 'package:location/location.dart';
import 'package:material_dialogs/material_dialogs.dart';
import 'package:material_dialogs/widgets/buttons/icon_button.dart';
import 'package:material_dialogs/widgets/buttons/icon_outline_button.dart';

class Maps extends StatefulWidget {
  const Maps({Key key}) : super(key: key);

  @override
  _MapsState createState() => _MapsState();
}

class _MapsState extends State<Maps>
    with AutomaticKeepAliveClientMixin, TickerProviderStateMixin {
  static const String _markerId = 'id-1';
  Completer<GoogleMapController> _controller = Completer();
  double _lat = 31.578;
  double _lng = 71.191;
  double _bottomSheetSizeDivider = 2.5;
  bool _openCloseCheck = false;
  String _addressLineDisplay = "";
  String _localityDisplay = "";
  String _floorNumberDisplay = "#";
  String _labelSelected = "";
  List<String> _labelName = ["Home","Work","Partner","Other"];
  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(69.3451, 30.375),
    zoom: 14.4746,
  );

  Set<Marker> _marker = {};

  // double getMeScreenHeightSize() {
  //   return MediaQuery.of(context).size.height;
  // }
  //
  // double getMeScreenWidthSize() {
  //   return MediaQuery.of(context).size.width *
  //       MediaQuery.of(context).devicePixelRatio;
  // }

  @override
  Widget build(BuildContext context) {
    BottomBarController _bbc = BottomBarController(vsync: this);
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
        height: SizeConfig.getMeScreenHeightSize(context),
        width: SizeConfig.getMeScreenWidthSize(context),
        child: GoogleMap(
          mapType: MapType.normal,
          initialCameraPosition: _kGooglePlex,
          markers: _marker,
          onMapCreated: (GoogleMapController controller) {
            setState(() {
              _marker.add(Marker(
                  markerId: MarkerId(_markerId), position: LatLng(_lat, _lng)));
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
            onPressed: () => _goToCurrentLocation(_bbc),
            label: Text('My Location'),
            icon: Icon(Icons.my_location),
          ),
        ),
      ),
      bottomNavigationBar: BottomExpandableAppBar(
        // Provide the bar controller in build method or default controller as ancestor in a tree
        controller: _bbc,
        expandedHeight: SizeConfig.getMeScreenHeightSize(context) / _bottomSheetSizeDivider,
        horizontalMargin: 0,
        expandedBackColor: kPrimaryColor,
        bottomAppBarColor: kPrimaryColor,
        appBarDecoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.zero, bottomRight: Radius.zero)),
        // Your bottom sheet code here
        expandedBody: SingleChildScrollView(
          child: Column(
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
                          Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 8.0,left: 8.0, right: 8.0),
                                child: Icon(
                                  Icons.location_on_outlined,
                                  color: kPrimaryColor,
                                ),
                              ),
                              GestureDetector(
                                onTap: (){
                                  addressEditDialog(_addressLineDisplay, _floorNumberDisplay, _bbc);
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Icon(
                                    Icons.edit,
                                    color: kPrimaryColor,
                                  ),
                                ),
                              ),
                            ],
                          ),

                          Expanded(
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(top: 8.0, bottom: 8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "$_addressLineDisplay",
                                    maxLines: 3,
                                    style: TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text("$_localityDisplay"),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                      "Floor Number",
                                      style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold),
                                    ),
                                  Text("$_floorNumberDisplay")
                                ],
                              ),
                            ),
                          ),
                        ],
                        crossAxisAlignment: CrossAxisAlignment.start,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      // Padding(
                      //   padding: const EdgeInsets.only(left: 15.0),
                      //   child: Text(
                      //     "Street address",
                      //     style: TextStyle(
                      //         fontWeight: FontWeight.bold, fontSize: 16),
                      //   ),
                      // ),
                      // Padding(
                      //   padding: EdgeInsets.only(
                      //       top: 8.0, bottom: 8.0, left: 15, right: 15),
                      //   child: Container(
                      //     height: 45,
                      //     child: TextField(
                      //       decoration: new InputDecoration(
                      //         contentPadding: EdgeInsets.all(5),
                      //         hintText: "Street",
                      //         hintTextDirection: TextDirection.ltr,
                      //         enabledBorder: const OutlineInputBorder(
                      //           borderSide: const BorderSide(
                      //               color: Colors.grey, width: 0.0),
                      //         ),
                      //       ),
                      //     ),
                      //   ),
                      // ),
                    ],
                  ),
                ),
              ),
              // Padding(
              //   padding:
              //       const EdgeInsets.only(bottom: 8.0, left: 10.0, right: 10.0),
              //   child: Container(
              //     height: 60,
              //     child: Card(
              //       child: Padding(
              //         padding: const EdgeInsets.all(8.0),
              //         child: TextField(
              //           decoration: new InputDecoration(
              //             contentPadding: EdgeInsets.all(5),
              //             hintText: "Floor",
              //             hintTextDirection: TextDirection.ltr,
              //             enabledBorder: const OutlineInputBorder(
              //               borderSide: const BorderSide(
              //                   color: Colors.grey, width: 0.0),
              //             ),
              //           ),
              //         ),
              //       ),
              //     ),
              //   ),
              // ),
              ListTile(
                title: Text(
                  "Address label",
                  style: TextStyle(color: Colors.white),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.only(bottom: 8.0, left: 10, right: 10),
                child: Card(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Column(
                              children: [
                                GestureDetector(
                                  onTap: (){
                                    setState(() {
                                      _labelSelected = _labelName[0];
                                    });
                                  },
                                  child: CircleAvatar(
                                    child: Icon(
                                      Icons.home_outlined,
                                      color: _labelSelected != _labelName[0] ?  kPrimaryColor : Colors.white,
                                    ),
                                    backgroundColor: _labelSelected != _labelName[0] ? Colors.grey[100] : kPrimaryColor,
                                    radius: 25,
                                  ),
                                ),
                                Text(
                                  _labelName[0],
                                  style: TextStyle(fontSize: 12),
                                )
                              ],
                              crossAxisAlignment: CrossAxisAlignment.center,
                            ),
                            Column(
                              children: [
                                GestureDetector(
                                  onTap: (){
                                    setState(() {
                                      _labelSelected = _labelName[1];
                                    });
                                  },
                                  child: CircleAvatar(
                                    child: Icon(
                                      Icons.work_outline_outlined,
                                      color: _labelSelected != _labelName[1] ?  kPrimaryColor : Colors.white,
                                    ),
                                    backgroundColor: _labelSelected != _labelName[1] ? Colors.grey[100] : kPrimaryColor,
                                    radius: 25,
                                  ),
                                ),
                                Text(
                                  _labelName[1],
                                  style: TextStyle(fontSize: 12),
                                )
                              ],
                              crossAxisAlignment: CrossAxisAlignment.center,
                            ),
                            Column(
                              children: [
                                GestureDetector(
                                  onTap: (){
                                    setState(() {
                                      _labelSelected = _labelName[2];
                                    });
                                  },
                                  child: CircleAvatar(
                                    child: Icon(
                                      Icons.favorite_border,
                                      color: _labelSelected != _labelName[2] ?  kPrimaryColor : Colors.white,
                                    ),
                                    backgroundColor: _labelSelected != _labelName[2] ? Colors.grey[100] : kPrimaryColor,
                                    radius: 25,
                                  ),
                                ),
                                Text(
                                  _labelName[2],
                                  style: TextStyle(fontSize: 12),
                                )
                              ],
                              crossAxisAlignment: CrossAxisAlignment.center,
                            ),
                            Column(
                              children: [
                                GestureDetector(
                                  onTap: (){
                                    setState(() {
                                      _labelSelected = _labelName[3];
                                    });
                                  },
                                  child: CircleAvatar(
                                    child: Icon(
                                      Icons.add,
                                      color: _labelSelected != _labelName[3] ?  kPrimaryColor : Colors.white,
                                    ),
                                    backgroundColor: _labelSelected != _labelName[3] ? Colors.grey[100] : kPrimaryColor,
                                    radius: 25,
                                  ),
                                ),
                                Text(
                                  _labelName[3],
                                  style: TextStyle(fontSize: 12),
                                )
                              ],
                              crossAxisAlignment: CrossAxisAlignment.center,
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 5,
              )
            ],
          ),
        ),
        // Your bottom app bar code here
        bottomAppBarBody: Container(
          height: 50,
          child: Visibility(
            visible: _openCloseCheck,
            child: TextButton(
              style: ButtonStyle(
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(RADIUS))),
                  backgroundColor: MaterialStateProperty.all(kPrimaryColor)),
              onPressed: () {
                HiveMethods().addDataMap(MapDetail(
                  longitude: _lng,
                  latitude: _lat,
                  addressLine: _addressLineDisplay,
                  floorNumber: _floorNumberDisplay,
                  label: _labelSelected,
                  city: _localityDisplay
                ));
                Navigator.pop(context);
              },
              child: Text(
                "Save Current Location",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ),
      ),
    );
  }


  Future<void> _goToCurrentLocation(BottomBarController bbc) async {
    bbc.dragLength = SizeConfig.getMeScreenHeightSize(context) / _bottomSheetSizeDivider;
    if (_openCloseCheck) {
      bbc.close(velocity: 10.0);
      _openCloseCheck = false;
    } else  {
      bbc.open(velocity: 10.0);
      _openCloseCheck = true;
      var location = Location();
      LocationData currentLocation = await location.getLocation();
      final GoogleMapController controller = await _controller.future;
      controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
          target: LatLng(currentLocation.latitude, currentLocation.longitude),
          zoom: 15.151926040649414,
          bearing: 192.8334901395799)));
        final coordinates = new Coordinates(currentLocation.latitude, currentLocation.longitude);
        var addresses = await Geocoder.local.findAddressesFromCoordinates(coordinates);
        var first = addresses.first;
        // print("featureName ${first.featureName} : adminArea ${first.adminArea} : countryName ${first.countryName} "
        //     ": featureName ${first.featureName}"
        //     ": locality ${first.locality} : postalCode ${first.postalCode} : "
        //     " subAdminArea ${first.subAdminArea} : subLocality ${first.subLocality} "
        //     " : subThoroughfare ${first.subThoroughfare} : : thoroughfare ${first.thoroughfare} "
        //     " : addressLine ${first.addressLine}   : countryCode ${first.countryCode} "
        //     " 0000000000000000000000000000000");
      setState(() {
        _lat = currentLocation.latitude;
        _lng = currentLocation.longitude;
        _addressLineDisplay = first.addressLine;
        _localityDisplay = first.locality;
        var pinPosition =
            LatLng(currentLocation.latitude, currentLocation.longitude);
        // _marker.removeWhere((element) => element.markerId.value == markerId);
        _marker.clear();
        addMarker(_marker, pinPosition);
      });
    }
  }

  void addMarker(_marker, pinPosition) {
    setState(() {
      _marker.add(Marker(
        markerId: MarkerId(_markerId),
        position: pinPosition,
      ));
    });
  }
  void addressEditDialog(String addressLine, String floorNumber, BottomBarController bbc){
    TextEditingController _address = TextEditingController();
    TextEditingController _floorNumber = TextEditingController();
    _address.text = addressLine;
    _floorNumber.text = floorNumber;
    Dialogs.materialDialog(
        color: Colors.white,
        context: context,
        customView: Column(
          children: [
            Center(
              child: Text(
                "Edit address",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: _address,
                decoration: new InputDecoration(
                  labelText: "Address",
                  fillColor: Colors.white,
                  border: new OutlineInputBorder(
                    borderRadius: new BorderRadius.circular(25.0),
                    borderSide: new BorderSide(
                    ),
                  ),
                  //fillColor: Colors.green
                ),
                validator: (val) {
                  if(val.length==0) {
                    return "Address cannot be empty";
                  }else{
                    return null;
                  }
                },
                keyboardType: TextInputType.emailAddress,
                style: new TextStyle(
                  fontFamily: "Poppins",
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 4.0, left: 8.0,right: 8.0),
              child: TextFormField(
                controller: _floorNumber,
                decoration: new InputDecoration(
                  labelText: "Floor:",
                  fillColor: Colors.white,
                  border: new OutlineInputBorder(
                    borderRadius: new BorderRadius.circular(25.0),
                    borderSide: new BorderSide(
                    ),
                  ),
                  //fillColor: Colors.green
                ),
                validator: (val) {
                  if(val.length==0) {
                    return "floor cannot be empty";
                  }else{
                    return null;
                  }
                },
                keyboardType: TextInputType.emailAddress,
                style: new TextStyle(
                  fontFamily: "Poppins",
                ),
              ),
            ),
          ],
        ),
        actions: [
          IconsOutlineButton(
            onPressed: () {
              Navigator.pop(context);
            },
            text: 'Cancel',
            iconData: Icons.cancel_outlined,
            textStyle: TextStyle(color: Colors.grey),
            iconColor: Colors.grey,
          ),
          IconsButton(
            onPressed: () {
              setState(() {
                _addressLineDisplay = _address.text;
                _floorNumberDisplay = _floorNumber.text;
                Navigator.pop(context);
                bbc.open(velocity: 10.0);
              });
            },
            text: 'Edit',
            iconData: Icons.edit,
            color: Colors.green,
            textStyle: TextStyle(color: Colors.white),
            iconColor: Colors.white,
          ),
        ]);
  }
  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
