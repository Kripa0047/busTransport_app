class LocationModel {
  String id;
  String name;

  LocationModel({
    this.id,
    this.name,
  });

  LocationModel.fromJSON(Map<String, dynamic> json) {
    id = json['id'] ?? "";
    name = json['location'] ?? "";
  }
}
