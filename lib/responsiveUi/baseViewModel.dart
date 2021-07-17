import 'package:flutter/cupertino.dart';
import 'package:tovit/App%20Services/NavigationService/NavigationService.dart';
import 'package:tovit/App%20Services/locator.dart';
import 'package:tovit/enums/viewState.dart';

class BaseViewModel extends ChangeNotifier {
  NavigationService? navigationService = locator<NavigationService>();

  ViewState _state = ViewState.IDLE;

  ViewState get state => _state;
  navigateTo(route) {
    if (route == "back") {
      return navigationService!.goBack();
    } else {
      return navigationService!.navigateTo(route);
    }
  }

  void setViewState(ViewState viewState) {
    _state = viewState;
    notifyListeners();
  }
}
