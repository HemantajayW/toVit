import 'busStop.dart';

class Bus {
  int busNO;
  String driverName;
  List<BusStop> routes;
  Bus({required this.routes, required this.driverName, required this.busNO});
}
