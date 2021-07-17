import 'package:flutter/widgets.dart';
import 'package:tovit/datamodels/addressmodel.dart';

import 'package:tovit/enums/viewState.dart';
import 'package:tovit/responsiveUi/baseViewModel.dart';

class AppData extends ChangeNotifier {
  Address? pickupAddress;
  Address? dropLocation;
  updatePickUpAddress(Address? pickup) {
    pickupAddress = pickup;
    notifyListeners();
  }

  updateDropAddress(Address drop) {
    dropLocation = drop;
    print("updateDropAddress: ${dropLocation!.formattedAddress}");
    notifyListeners();
  }
}
