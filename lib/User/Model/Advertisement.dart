class Advertisement {
  String? status;
  List<AdSlider>? adSlider;

  Advertisement({this.status, this.adSlider});

  Advertisement.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['adSlider'] != null) {
      adSlider = <AdSlider>[];
      json['adSlider'].forEach((v) {
        adSlider!.add(new AdSlider.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.adSlider != null) {
      data['adSlider'] = this.adSlider!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class AdSlider {
  String? adBanner;
  double? distance;
  double? latitude;
  double? longitude;

  AdSlider({this.adBanner, this.distance, this.latitude, this.longitude});

  AdSlider.fromJson(Map<String, dynamic> json) {
    adBanner = json['adBanner'];
    distance = json['distance'];
    latitude = json['latitude'];
    longitude = json['longitude'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['adBanner'] = this.adBanner;
    data['distance'] = this.distance;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    return data;
  }
}