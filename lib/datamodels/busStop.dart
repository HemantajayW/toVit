class BusStop {
  String name;
  String time;
  bool reached = false;
  BusStop({
    required this.name,
    required this.time,
    this.reached = false,
  });
  void makeItreached() {
    reached = true;
  }
}
