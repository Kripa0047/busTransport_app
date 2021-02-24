class BusModel {
  String description;
  List<String> days;
  String id;
  List<Stop> stops;
  String busNumber;

  BusModel({
    this.description,
    this.days,
    this.id,
    this.stops,
    this.busNumber,
  });

  BusModel.fromJSON(Map<String, dynamic> json) {
    description = json['description'] ?? "";
    if (json['days'] is List)
      days = [...json['days'].map((day) => day.toString())];
    else
      days = [];

    id = json['id'] ?? "";

    if (json['stops'] is List)
      stops = [...json['stops']?.map((stop) => Stop.fromJSON(stop ?? {}))];
    else
      stops = [];

    busNumber = json["busNumber"] ?? "";
  }
}

class Stop {
  String location;
  String time;

  Stop({
    this.location,
    this.time,
  });

  Stop.fromJSON(Map<String, dynamic> json) {
    location = json['location'];
    time = json['time'];
  }
}
