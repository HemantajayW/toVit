import 'package:flutter/widgets.dart';
import 'package:tovit/datamodels/addressmodel.dart';

import 'package:tovit/enums/viewState.dart';
import 'package:tovit/responsiveUi/baseViewModel.dart';

class AppData extends ChangeNotifier {
  Address? pickupAddress;
  Address? dropLocation;
  Address? campusLocation = Address(
      placeId: "ChIJVRzyQH3yNToRUJiFVM3qkBQ",
      latitude: 16.4962777,
      longitude: 80.5006676,
      formattedAddress:
          "VIT-AP University, G-30, Inavolu, Beside AP Secretariat Amaravati, Amaravati, Andhra Pradesh 522237, India",
      placeName: "VIT AP CAMPUS");
  updatePickUpAddress(Address? pickup) {
    pickupAddress = pickup;
    notifyListeners();
  }

  updateDropAddress(Address drop) {
    dropLocation = drop;
    print("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@");
    print(drop.formattedAddress);
    print(drop.placeId);
    print(drop.latitude);
    print(drop.longitude);
    print(drop.placeName);

    print("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@");
    notifyListeners();
  }
}
