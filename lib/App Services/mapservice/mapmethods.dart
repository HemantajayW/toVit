import 'package:connectivity/connectivity.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:tovit/datamodels/DirectionModel.dart';
import 'package:tovit/datamodels/addressmodel.dart';
import 'package:tovit/dataprovider/Appdata.dart';
import 'package:tovit/globalvariables.dart';

import '../locator.dart';
import 'requesthelper.dart';

class MapMethods {
  static Future<String> findCoordinateAddress(
      Position position, context) async {
    String placeAddress = "";
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult != ConnectivityResult.mobile &&
        connectivityResult != ConnectivityResult.wifi) {
      return placeAddress;
    }

    String url =
        "https://maps.googleapis.com/maps/api/geocode/json?latlng=${position.latitude},${position.longitude}&key=$mapkey";
    Uri uri = Uri.https("maps.googleapis.com", "maps/api/geocode/json", {
      "latlng": "${position.latitude},${position.longitude}",
      "key": "$mapkey",
    });
    var responce = await RequestHelper.getRequest(uri);
    if (responce != "failed") {
      placeAddress = responce['results'][0]['formatted_address'];
      Address? pickupaddress = Address(
          formattedAddress: placeAddress,
          latitude: position.latitude,
          longitude: position.longitude,
          placeName: responce['results'][0]["address_components"][1]
              ["short_name"],
          placeId: responce['results'][0]['place_id']);
      Provider.of<AppData>(context, listen: false)
          .updatePickUpAddress(pickupaddress);
    }
    // var appdata = locator<AppData>();

    return placeAddress;
  }

  static Future<DirectionDetails?> getDirections(
      LatLng start, LatLng end) async {
    // https://maps.googleapis.com/maps/api/directions/json?origin=Disneyland&destination=Universal+Studios+Hollywood&key=AIzaSyBRckFclcOk8h7QzCCluesxVpjQ1jXzNvk
    Uri uri = Uri.https("maps.googleapis.com", "maps/api/directions/json", {
      "origin": "${start.latitude},${start.longitude}",
      "destination": "${end.latitude},${end.longitude}",
      "key": "$mapkey",
    });
    print("uri: ${uri.toString()}");

    var response = await RequestHelper.getRequest(uri);
    print("response: $response");

    if (response == "failed") {
      print("responce is falided");

      return null;
    }
    print("getting direction Details");
    //  routes[0].overview_polyline.overview_polyline
    var direction = DirectionDetails(
        distanceText: response['routes'][0]["legs"][0]["distance"]["text"],
        distanceValue: response['routes'][0]["legs"][0]["distance"]["value"],
        durationText: response['routes'][0]["legs"][0]["duration"]["text"],
        dutaionValue: response['routes'][0]["legs"][0]["duration"]["value"],
        encodedPoints: response['routes'][0]["overview_polyline"]["points"]);
    print("got direction Details");
    return direction;
  }
}
