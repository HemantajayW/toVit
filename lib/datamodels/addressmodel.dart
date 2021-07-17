class Address {
  String? placeName;
  double? latitude;
  double? longitude;
  String? placeId;
  String? formattedAddress;

  Address(
      {this.formattedAddress,
      this.placeName,
      this.latitude,
      this.longitude,
      this.placeId});
  Address.getDetails(Map<String, dynamic> map, String placeid) {
    placeId = placeid;
    placeName = map['result']["name"];
    latitude = map["result"]["geometry"]["location"]["lat"];
    longitude = map["result"]["geometry"]["location"]["lng"];

    formattedAddress = map['result']["formatted_address"];
  }
  static Address returnnull() {
    return Address(
      formattedAddress: " ",
      latitude: 0.0,
      longitude: 0.0,
      placeId: "0",
    );
  }
}
