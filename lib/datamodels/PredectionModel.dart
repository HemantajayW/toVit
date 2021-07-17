class Predection {
  late String placeId;
  late String mainText;
  late String secondaryText;
  Predection(this.placeId, this.mainText, this.secondaryText);
  Predection.fromJSON(Map<String, dynamic> map) {
    placeId = map["place_id"];
    mainText = map["structured_formatting"]["main_text"];
    secondaryText = map["structured_formatting"]["secondary_text"] ?? "";
  }
}
