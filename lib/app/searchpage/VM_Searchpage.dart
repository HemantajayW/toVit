import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tovit/App%20Services/mapservice/requesthelper.dart';
import 'package:tovit/datamodels/addressmodel.dart';
import 'package:tovit/datamodels/PredectionModel.dart';
import 'package:tovit/dataprovider/Appdata.dart';
import 'package:tovit/enums/viewState.dart';
import 'package:tovit/globalvariables.dart';
import 'package:tovit/responsiveUi/baseViewModel.dart';

class VM_SearchPage extends BaseViewModel {
  List<Predection> predictionList = [];
  void SearchPlace(String place) async {
    //https://maps.googleapis.com/maps/api/place/autocomplete/json?input=1600+Amphitheatre&key=<API_KEY>&sessiontoken=1234567890

    if (place.length >= 1) {
      Uri uri = Uri.https(
          "maps.googleapis.com", "/maps/api/place/autocomplete/json", {
        "input": "$place",
        "key": "$mapkey",
        "sessiontoken": "1234567890",
      });
      var result = await RequestHelper.getRequest(uri);
      if (result == "failed") {
        return;
      }
      if (result["status"] == "OK") {
        var predictionJSON = result["predictions"];
        var templist = (predictionJSON as List)
            .map((e) => Predection.fromJSON(e))
            .toList();
        setViewState(ViewState.BUSY);
        predictionList = templist;
        setViewState(ViewState.IDLE);
      }
    } else if (place.length == 0) {
      setViewState(ViewState.BUSY);
      predictionList = [];
      setViewState(ViewState.IDLE);
    }
  }

  Future<int> getPlaceDetails(String placeid, context) async {
    Uri uri = Uri.https("maps.googleapis.com", "/maps/api/place/details/json", {
      "place_id": "$placeid",
      "fields": "name,formatted_address,geometry",
      "key": "$mapkey",
      "sessiontoken": "1234567890",
    });
    var response = await RequestHelper.getRequest(uri);
    if (response == "failed") {
      return 0;
    }
    if (response["status"] == "OK") {
      Address droploc = Address.getDetails(response, placeid);
      Provider.of<AppData>(context, listen: false).updateDropAddress(droploc);
      print("updated inside and returning 1");
      return 1;
    }
    return 0;
  }
}
