import 'dart:async';

import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:outline_material_icons_tv/outline_material_icons.dart';
import 'package:provider/provider.dart';
import 'package:simple_fontellico_progress_dialog/simple_fontico_loading.dart';
import 'package:tovit/App%20Services/NavigationService/NavigationService.dart';
import 'package:tovit/App%20Services/NavigationService/routeNames.dart';
import 'package:tovit/App%20Services/authenticationService/AuthenticationService.dart';
import 'package:tovit/App%20Services/locator.dart';
import 'package:tovit/App%20Services/mapservice/mapmethods.dart';
import 'package:tovit/App%20Services/snackbarService.dart/snackbarsevice.dart';
import 'package:tovit/Styles/spacer.dart';
import 'package:tovit/Styles/textstyles.dart';
import 'package:tovit/app/searchpage/searchpage.dart';
import 'package:tovit/dataprovider/Appdata.dart';
import 'package:tovit/responsiveUi/ResponsiveWidget.dart';
import 'package:tovit/responsiveUi/sizingInformation.dart';

import '../../main.dart';
import 'NotDrawer.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var scafkey = GlobalKey<ScaffoldState>();
  var auth = locator<AuthenticationService>();
  var nav = locator<NavigationService>();
  Geolocator geolocator = Geolocator();
  bool isFullScreen = false;
  late GoogleMapController mapController;
  late Position? currentPosition;
  late bool serviceEnabled;
  late LocationPermission permission;
  List<LatLng> polylinecordinates = [];
  Set<Polyline> _polylines = {};
  Set<Marker> _markers = {};
  Set<Circle> _circles = {};
  bool isNavigating = true;

  var appdata = locator<AppData>();
  late SimpleFontelicoProgressDialog _dialog;
  var mapPadding = 0.0;
  Completer<GoogleMapController> _controller = Completer();

  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );
  @override
  void initState() {
    _dialog = SimpleFontelicoProgressDialog(
        context: context, barrierDimisable: false);
    super.initState();
  }

  setupCurrentPosition() async {
    var postion = await _determinePosition().catchError((err) {
      showOkAlertDialog(
          context: context,
          title: "Error accesing location",
          message: "$err please Activate Location Service to Conyinue.");
    });
    if (postion is Position) {
      currentPosition = postion;
      LatLng pos =
          LatLng(currentPosition!.latitude, currentPosition!.longitude);
      print(
          "pickup: ${await MapMethods.findCoordinateAddress(currentPosition!, context)}");

      CameraPosition cp = CameraPosition(target: pos, zoom: 14);
      mapController.animateCamera(CameraUpdate.newCameraPosition(cp));
    }
  }

  _determinePosition() async {
    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.bestForNavigation,
    );
  }

  Future<void> getDirection(sizingInfo) async {
    _dialog.show(
      message: "Loading",
    );
    var pickup = Provider.of<AppData>(context, listen: false).pickupAddress;
    var drop = Provider.of<AppData>(context, listen: false).dropLocation;
    print("got pick and drop address");
    var responce = await MapMethods.getDirections(
        LatLng(pickup!.latitude!, pickup.longitude!),
        LatLng(drop!.latitude!, drop.longitude!));
    print("got out of details");
    _dialog.hide();
    print("did hide dailog");
    PolylinePoints polylinepoints = PolylinePoints();
    print("decoding polylines");
    List<PointLatLng> results =
        polylinepoints.decodePolyline(responce!.encodedPoints);
    print("decoded polylines");
    polylinecordinates.clear();
    if (results.isNotEmpty) {
      print("converting polylines");
      results.forEach((ele) {
        polylinecordinates.add(LatLng(ele.latitude, ele.longitude));
      });
      print("converted polylines");
    }
    _polylines.clear();
    print("cleared polulines polylines");
    setState(() {
      print("in setstate");
      Polyline polyline = Polyline(
          polylineId: PolylineId("polyline1"),
          color: Colors.blue,
          // color: Color.fromARGB(255, 95, 109, 237),
          points: polylinecordinates,
          jointType: JointType.round,
          width: 4,
          startCap: Cap.roundCap,
          endCap: Cap.roundCap,
          geodesic: true);
      print("creating  polylines");
      _polylines.add(polyline);
      print("added  polylines");
    });
    LatLngBounds bounds;
    if (pickup.latitude! > drop.latitude! &&
        pickup.longitude! > drop.longitude!) {
      bounds = LatLngBounds(
          southwest: LatLng(drop.latitude!, drop.longitude!),
          northeast: LatLng(pickup.latitude!, pickup.longitude!));
    } else if (pickup.longitude! > drop.longitude!) {
      bounds = LatLngBounds(
          southwest: LatLng(pickup.latitude!, drop.longitude!),
          northeast: LatLng(drop.latitude!, pickup.longitude!));
    } else if (pickup.latitude! > drop.latitude!) {
      bounds = LatLngBounds(
          southwest: LatLng(drop.latitude!, pickup.longitude!),
          northeast: LatLng(pickup.latitude!, drop.longitude!));
    } else {
      bounds = bounds = LatLngBounds(
          southwest: LatLng(pickup.latitude!, pickup.longitude!),
          northeast: LatLng(drop.latitude!, drop.longitude!));
    }
    mapController.animateCamera(CameraUpdate.newLatLngBounds(bounds, 70));
    Marker pickupMarker = Marker(
        markerId: MarkerId("pickupmark"),
        position: LatLng(pickup.latitude!, pickup.longitude!),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueCyan),
        infoWindow:
            InfoWindow(title: pickup.placeName, snippet: "My Location"));
    Marker dropmarker = Marker(
        markerId: MarkerId("dropmark"),
        position: LatLng(drop.latitude!, drop.longitude!),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
        infoWindow:
            InfoWindow(title: drop.placeName, snippet: "Drop Location"));
    Circle pickupcircle = Circle(
        circleId: CircleId("pickup"),
        strokeColor: Colors.yellow,
        strokeWidth: 3,
        radius: 12,
        center: LatLng(pickup.latitude!, pickup.longitude!),
        fillColor: Colors.yellow);
    Circle dropcircle = Circle(
        circleId: CircleId("drop"),
        strokeColor: Colors.red,
        strokeWidth: 3,
        radius: 12,
        center: LatLng(drop.latitude!, drop.longitude!),
        fillColor: Colors.red);
    setState(() {
      isNavigating = true;
      mapPadding = sizingInfo.screenSize!.height * 0.35;
      // _markers.add(pickupMarker);
      _markers.add(dropmarker);
      _circles.add(pickupcircle);
      _circles.add(dropcircle);
    });
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveWidget(
      builder: (context, sizingInfo) => Scaffold(
        key: scafkey,
        drawer: Container(
          child: NotDrawer(),
        ),
        body: Stack(
          children: [
            vGooglemap(sizingInfo),
            Align(
              alignment: Alignment.bottomCenter,
              child: AnimatedContainer(
                duration: Duration(milliseconds: 800),
                curve: Curves.fastOutSlowIn,
                height: isNavigating
                    ? sizingInfo.screenSize!.height * 0.35
                    : sizingInfo.screenSize!.height * 0.55,
                width: sizingInfo.screenSize!.width,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(isNavigating ? 15 : 30),
                    topRight: Radius.circular(isNavigating ? 15 : 30),
                  ),
                ),
                padding: EdgeInsets.all(12),
                child: isNavigating
                    ? Container(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Align(
                              alignment: Alignment.topCenter,
                              child: Container(
                                height: 5,
                                width: 25,
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade300,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 10) +
                                  EdgeInsets.only(top: 5),
                              child: Text(
                                "Your Bus",
                                style: Theme.of(context)
                                    .textTheme
                                    .headline6!
                                    .copyWith(
                                      color: Colors.black87,
                                      fontWeight: FontWeight.bold,
                                    ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(0.0),
                              child: Container(
                                  padding: EdgeInsets.all(8),
                                  height: sizingInfo.screenSize!.height * 0.23,
                                  child: ListView.separated(
                                    itemCount: 20,
                                    separatorBuilder: (context, index) =>
                                        Padding(
                                      padding: EdgeInsets.all(10),
                                    ),
                                    physics: PageScrollPhysics(),
                                    scrollDirection: Axis.horizontal,
                                    itemBuilder: (context, index) => Container(
                                        width:
                                            sizingInfo.screenSize!.width * 0.8,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            color: Colors.amber)),
                                  )),
                            )
                          ],
                        ),
                      )
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Align(
                            alignment: Alignment.topCenter,
                            child: Container(
                              height: 5,
                              width: 25,
                              decoration: BoxDecoration(
                                color: Colors.grey.shade300,
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 30.0),
                            child: Container(
                              height: sizingInfo.screenSize!.height * 0.26,
                              child: Row(
                                children: [
                                  Expanded(
                                    flex: 4,
                                    child: InkWell(
                                      onTap: () async {
                                        var res = await Navigator.of(context)
                                            .push(MaterialPageRoute(
                                                builder: (c) => SearchPage()));
                                        if (res == "1") {
                                          getDirection(sizingInfo);
                                        }
                                      },
                                      child: Container(
                                        height: sizingInfo.screenSize!.height *
                                            0.28,
                                        width: 140,
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 20, vertical: 40),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              height: 56,
                                              width: 56,
                                              child: Center(
                                                  child: Icon(
                                                Icons.search,
                                                color: Colors.white,
                                              )),
                                              decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color: Colors.black12),
                                            ),
                                            Spacer(
                                              flex: 3,
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(3.0),
                                              child: Text(
                                                "Get Me \nto Campus",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .subtitle1!
                                                    .copyWith(
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        color: Colors.white),
                                              ),
                                            ),
                                            // Spacer(
                                            //   flex: ,
                                            // ),
                                          ],
                                        ),
                                        decoration: BoxDecoration(
                                          color: Theme.of(context).accentColor,
                                          borderRadius:
                                              BorderRadius.circular(25),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 8,
                                  ),
                                  Expanded(
                                    flex: 3,
                                    child: Container(
                                      height:
                                          sizingInfo.screenSize!.height * 0.28,
                                      width: 110,
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 20, vertical: 40),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            height: 56,
                                            width: 56,
                                            child: Center(
                                                child: Icon(
                                              Icons.home_rounded,
                                              color: Colors.white,
                                            )),
                                            decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: Color(0xffF0535B)),
                                          ),
                                          Spacer(
                                            flex: 3,
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(3.0),
                                            child: Text(
                                              "Get Me Home",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .subtitle1!
                                                  .copyWith(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color: Colors.white),
                                            ),
                                          ),
                                          // Spacer(
                                          //   flex: ,
                                          // ),
                                        ],
                                      ),
                                      decoration: BoxDecoration(
                                        color: Color(0xffF9B8BB),
                                        borderRadius: BorderRadius.circular(25),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 8,
                                  ),
                                  Expanded(
                                    flex: 2,
                                    child: Column(
                                      children: [
                                        Expanded(
                                          child: Container(
                                            width: 90,
                                            child: Center(
                                              child: Icon(
                                                Icons.star_outline_rounded,
                                                color: Colors.black54,
                                                size: 28,
                                              ),
                                            ),
                                            decoration: BoxDecoration(
                                              color: Color(0xffFfffff),
                                              border: Border.all(
                                                  color: Colors.grey.shade100),
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 8,
                                        ),
                                        Expanded(
                                          child: Container(
                                            child: Center(
                                              child: Icon(
                                                Icons.map_outlined,
                                                color: Colors.black
                                                    .withOpacity(0.8),
                                                size: 28,
                                              ),
                                            ),
                                            width: 90,
                                            decoration: BoxDecoration(
                                              color: Color(0xffFFEE78),
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  "Select your Bus",
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline6!
                                      .copyWith(
                                        fontSize: 18,
                                        color: Colors.black.withOpacity(0.75),
                                        fontWeight: FontWeight.w600,
                                      ),
                                ),
                                Icon(Icons.keyboard_arrow_right_sharp)
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 20.0),
                            child: Container(
                              height: sizingInfo.screenSize!.height * 0.1,
                              width: sizingInfo.screenSize!.width,
                              child: ListView.builder(
                                itemCount: 13,
                                physics: BouncingScrollPhysics(),
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, index) => Padding(
                                  padding: const EdgeInsets.only(left: 8.0),
                                  child: Container(
                                    child: Center(
                                        child: Container(
                                      height: 48,
                                      width: 48,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        // color: Color(0xffF0535B),
                                      ),
                                      child: Center(
                                        child: Text(
                                          "${index + 1}",
                                          style: Theme.of(context)
                                              .textTheme
                                              .subtitle1!
                                              .copyWith(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w600,
                                                  color: Colors.black),
                                        ),
                                      ),
                                    )),
                                    width: 80,
                                    decoration: BoxDecoration(
                                        // color: Color(0xffF9B8BB),
                                        border: Border.all(
                                            color: Colors.grey.shade100),
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
              ),
            ),
            SafeArea(
              child: InkWell(
                onTap: () {
                  scafkey.currentState!.openDrawer();
                },
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                    height: 42,
                    width: 42,
                    child: CircleAvatar(
                      backgroundColor: Colors.white,
                      child: Icon(
                        Icons.menu_rounded,
                        color: Colors.black87,
                      ),
                    ),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black26,
                              blurRadius: 0.5,
                              spreadRadius: 0.5,
                              offset: Offset(0.7, 0.7))
                        ]),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  vGooglemap(SizingInformation sizingInfo) {
    return GoogleMap(
      myLocationEnabled: true,
      padding: EdgeInsets.only(
          bottom: mapPadding,
          left: 10,
          top: MediaQuery.of(context).padding.top),
      initialCameraPosition: _kGooglePlex,
      myLocationButtonEnabled: true,
      markers: _markers,
      circles: _circles,
      polylines: _polylines,
      zoomControlsEnabled: isFullScreen,
      zoomGesturesEnabled: true,
      mapType: MapType.normal,
      onMapCreated: (mcontroller) {
        _controller.complete(mcontroller);
        mapController = mcontroller;
        setState(() {
          setupCurrentPosition();
          mapPadding = sizingInfo.screenSize!.height * 0.55;
        });
      },
    );
  }
}
