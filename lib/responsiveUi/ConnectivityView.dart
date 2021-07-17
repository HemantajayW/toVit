import 'dart:async';

import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tovit/App%20Services/snackbarService.dart/snackbarsevice.dart';

class ConnectivityStatusView extends StatefulWidget {
  GlobalKey<ScaffoldMessengerState> scaffoldKey;
  Function(bool enable) builder;
  ConnectivityStatusView(
      {Key? key, required this.builder, required this.scaffoldKey})
      : super(key: key);

  @override
  _ConnectivityStatusViewState createState() => _ConnectivityStatusViewState();
}

class _ConnectivityStatusViewState extends State<ConnectivityStatusView> {
  String _connectionStatus = 'Unknown';
  bool enable = true;
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;

  @override
  void initState() {
    super.initState();
    initConnectivity();
    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
  }

  @override
  void dispose() {
    _connectivitySubscription.cancel();
    super.dispose();
  }

  Future<void> initConnectivity() async {
    ConnectivityResult result = ConnectivityResult.none;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      result = await _connectivity.checkConnectivity();
    } on PlatformException catch (e) {
      print(e.toString());
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) {
      return Future.value(null);
    }

    return _updateConnectionStatus(result);
  }

  Future<void> _updateConnectionStatus(ConnectivityResult result) async {
    switch (result) {
      case ConnectivityResult.wifi:
      case ConnectivityResult.mobile:
        setState(() {
          _connectionStatus = "";

          enable = true;
        });
        break;
      case ConnectivityResult.none:
        setState(() {
          _connectionStatus = result.toString();
          callInfoSnackbaar(widget.scaffoldKey,
              message: "Please check youe Internet Connection");
          enable = false;
        });
        break;
      default:
        setState(() {
          enable = false;
          callInfoSnackbaar(widget.scaffoldKey,
              message: "No Internect Connection");
          _connectionStatus = 'Failed to get connectivity.';
        });
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) => widget.builder(enable),
    );
  }
}
