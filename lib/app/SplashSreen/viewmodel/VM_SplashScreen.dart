import 'package:tovit/App%20Services/NavigationService/NavigationService.dart';
import 'package:tovit/App%20Services/NavigationService/routeNames.dart';
import 'package:tovit/App%20Services/authenticationService/AuthenticationService.dart';
import 'package:tovit/App%20Services/databaseService/DatabaseServices.dart';
import 'package:tovit/App%20Services/locator.dart';
import 'package:tovit/responsiveUi/baseViewModel.dart';

class StartupLogicModel extends BaseViewModel {
  final AuthenticationService _authenticationService =
      locator<AuthenticationService>();
  final NavigationService _navigationService = locator<NavigationService>();

  handleStartUpLogic() async {
    var hasLoggedInUser = await _authenticationService.isUserLoggedIn();
    await Future.delayed(Duration(milliseconds: 2200));

    if (hasLoggedInUser) {
      DatabaseServices.getCurrentUserInfo();
      _navigationService.pushandRemove(HOMESCREENROUTE);
    } else {
      _navigationService.pushandRemove(LOGINVIEWROUTE);
    }
  }
}
