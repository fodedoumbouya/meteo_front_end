class StationData {
  int? id;
  String? serialNumber;
  String? deviceNumber;
  String? location;
  String? model;
  double? lat;
  double? log;

  StationData(
      {this.id,
      this.serialNumber,
      this.deviceNumber,
      this.location,
      this.model,
      this.lat,
      this.log});

  StationData.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    serialNumber = json['serialNumber'];
    deviceNumber = json['deviceNumber'];
    location = json['location'];
    model = json['model'];
    lat = json['lat'];
    log = json['log'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Id'] = id;
    data['serialNumber'] = serialNumber;
    data['deviceNumber'] = deviceNumber;
    data['location'] = location;
    data['model'] = model;
    data['lat'] = lat;
    data['log'] = log;
    return data;
  }
}
