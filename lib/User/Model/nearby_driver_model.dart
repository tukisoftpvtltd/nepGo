class NearByDriverModel {
  bool? status;
  List<NearByDriverPlayerIds>? nearByDriverPlayerIds;

  NearByDriverModel({this.status, this.nearByDriverPlayerIds});

  NearByDriverModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['nearByDriverPlayerIds'] != null) {
      nearByDriverPlayerIds = <NearByDriverPlayerIds>[];
      json['nearByDriverPlayerIds'].forEach((v) {
        nearByDriverPlayerIds!.add(new NearByDriverPlayerIds.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.nearByDriverPlayerIds != null) {
      data['nearByDriverPlayerIds'] =
          this.nearByDriverPlayerIds!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class NearByDriverPlayerIds {
  String? playerId;
  double? distance;
  double? latitude;
  double? longitude;

  NearByDriverPlayerIds(
      {this.playerId, this.distance, this.latitude, this.longitude});

  NearByDriverPlayerIds.fromJson(Map<String, dynamic> json) {
    playerId = json['playerId'];
    distance = json['distance'].toDouble();
    latitude = json['latitude'];
    longitude = json['longitude'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['playerId'] = this.playerId;
    data['distance'] = this.distance ;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    return data;
  }
}
