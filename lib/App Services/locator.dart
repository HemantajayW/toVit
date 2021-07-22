import 'package:get_it/get_it.dart';

import 'package:stacked_firebase_auth/stacked_firebase_auth.dart';
import 'package:tovit/App%20Services/NavigationService/NavigationService.dart';
import 'package:tovit/App%20Services/authenticationService/AuthenticationService.dart';
import 'package:tovit/App%20Services/sharedPreferences/sharedpreferences.dart';
import 'package:tovit/app/LoginScreen/ViewModel/VM_SignupScreen.dart';
import 'package:tovit/app/LoginScreen/ViewModel/VM_loginScreen.dart';
import 'package:tovit/app/SplashSreen/viewmodel/VM_SplashScreen.dart';
import 'package:tovit/app/homeScreen.dart/VM-homeView.dart';
import 'package:tovit/app/searchpage/VM_Searchpage.dart';
import 'package:tovit/dataprovider/Appdata.dart';
import 'package:tovit/responsiveUi/baseViewModel.dart';

GetIt locator = GetIt.instance;

void setUpLocator() {
  locator.registerLazySingleton<BaseViewModel>(() => BaseViewModel());
  locator.registerLazySingleton<AppData>(() => AppData());
  locator.registerLazySingleton<VMLoginScreen>(() => VMLoginScreen());
  locator.registerLazySingleton<StartupLogicModel>(() => StartupLogicModel());
  locator.registerLazySingleton<VM_SignUpScreen>(() => VM_SignUpScreen());
  locator.registerLazySingleton<VM_HomeScreen>(() => VM_HomeScreen());
  locator.registerLazySingleton<VM_SearchPage>(() => VM_SearchPage());
  locator.registerLazySingleton<AuthenticationService>(
      () => AuthenticationService());

  locator.registerLazySingleton<NavigationService>(() => NavigationService());
  locator.registerFactory<AppSharedPreferences>(() => AppSharedPreferences());
}
