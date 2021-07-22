import 'dart:async';

import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:outline_material_icons_tv/outline_material_icons.dart';
import 'package:provider/provider.dart';
import 'package:scroll_snap_list/scroll_snap_list.dart';
import 'package:simple_fontellico_progress_dialog/simple_fontico_loading.dart';
import 'package:tovit/App%20Services/NavigationService/NavigationService.dart';
import 'package:tovit/App%20Services/NavigationService/routeNames.dart';
import 'package:tovit/App%20Services/authenticationService/AuthenticationService.dart';
import 'package:tovit/App%20Services/locator.dart';
import 'package:tovit/App%20Services/mapservice/mapmethods.dart';
import 'package:tovit/App%20Services/snackbarService.dart/snackbarsevice.dart';
import 'package:tovit/Styles/spacer.dart';
import 'package:tovit/Styles/textstyles.dart';
import 'package:tovit/app/homeScreen.dart/NavigatingWidger.dart';
import 'package:tovit/app/homeScreen.dart/WhileNavigating.dart';
import 'package:tovit/app/searchpage/searchpage.dart';
import 'package:tovit/dataprovider/Appdata.dart';
import 'package:tovit/responsiveUi/ResponsiveWidget.dart';
import 'package:tovit/responsiveUi/sizingInformation.dart';

import '../../main.dart';
import 'MainHomeWidget.dart';
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
  bool isNavigating = false;
  bool startNavigation = false;
  var appdata = locator<AppData>();
  late SimpleFontelicoProgressDialog _dialog;
  late PageController pageController;
  var mapPadding = 400.0;
  String address = "";
  Completer<GoogleMapController> _controller = Completer();
  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(16.493165, 80.498346),
    zoom: 16.4,
  );

  @override
  void initState() {
    pageController = PageController(initialPage: 1, viewportFraction: 0.8);
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
      address = Provider.of<AppData>(context, listen: false)
          .pickupAddress!
          .placeName!;
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

  Future<void> getDirection(sizingInfo, pickup, drop) async {
    _dialog.show(
      message: "Loading",
    );
    // var pickup = Provider.of<AppData>(context, listen: false).pickupAddress;
    // var drop = Provider.of<AppData>(context, listen: false).dropLocation;
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

  _getMeCampus(sizingInfo) {
    address =
        Provider.of<AppData>(context, listen: false).pickupAddress!.placeName!;
    getDirection(
        sizingInfo,
        Provider.of<AppData>(context, listen: false).pickupAddress,
        Provider.of<AppData>(context, listen: false).campusLocation);
    setState(() {
      startNavigation = true;
    });
  }

  _getMeHome(sizingInfo) {
    address =
        Provider.of<AppData>(context, listen: false).campusLocation!.placeName!;
    getDirection(
        sizingInfo,
        Provider.of<AppData>(context, listen: false).campusLocation,
        Provider.of<AppData>(context, listen: false).pickupAddress);
    setState(() {
      startNavigation = true;
    });
  }

  resetApp() {
    setState(() {
      _circles.clear();
      _markers.clear();
      polylinecordinates.clear();
      _polylines.clear();
      isNavigating = false;
      startNavigation = false;
      setupCurrentPosition();
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
            startNavigation
                ? NavigatingWidget(
                    address: address,
                  )
                : Align(
                    alignment: Alignment.bottomCenter,
                    child: AnimatedContainer(
                      duration: Duration(milliseconds: 800),
                      curve: Curves.fastOutSlowIn,
                      height: isNavigating
                          ? sizingInfo.screenSize!.height * 0.4
                          : sizingInfo.screenSize!.height * 0.55,
                      width: sizingInfo.screenSize!.width,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(isNavigating ? 15 : 30),
                          topRight: Radius.circular(isNavigating ? 15 : 30),
                        ),
                      ),
                      padding: EdgeInsets.all(isNavigating ? 0 : 12),
                      child: isNavigating
                          ? WhileNavigating(
                              pageController: pageController,
                              resetAll: resetApp,
                            )
                          : MainHome(
                              getMeCampus: _getMeCampus,
                              getMeHome: _getMeHome,
                              getdirection: getDirection,
                            ),
                    ),
                  ),
            SafeArea(
              child: InkWell(
                onTap: () {
                  if (startNavigation) {
                    resetApp();
                  } else {
                    scafkey.currentState!.openDrawer();
                  }
                },
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                    height: 42,
                    width: 42,
                    child: CircleAvatar(
                      backgroundColor: Colors.white,
                      child: Icon(
                        startNavigation ? Icons.arrow_back : Icons.menu_rounded,
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
