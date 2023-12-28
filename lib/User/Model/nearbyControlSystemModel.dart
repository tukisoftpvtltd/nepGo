class NearByControlSytemModel {
  bool? status;
  NearestControlSystem? nearestControlSystem;

  NearByControlSytemModel({this.status, this.nearestControlSystem});

  NearByControlSytemModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    nearestControlSystem = json['nearestControlSystem'] != null
        ? new NearestControlSystem.fromJson(json['nearestControlSystem'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.nearestControlSystem != null) {
      data['nearestControlSystem'] = this.nearestControlSystem!.toJson();
    }
    return data;
  }
}

class NearestControlSystem {
  String? playerId;
  double? distance;
  double? latitude;
  double? longitude;

  NearestControlSystem(
      {this.playerId, this.distance, this.latitude, this.longitude});

  NearestControlSystem.fromJson(Map<String, dynamic> json) {
    playerId = json['PlayerId'];
    distance = json['distance'];
    latitude = json['latitude'];
    longitude = json['longitude'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['PlayerId'] = this.playerId;
    data['distance'] = this.distance;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    return data;
  }
}
