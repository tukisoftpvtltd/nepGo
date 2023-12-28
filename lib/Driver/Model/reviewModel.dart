class DriverReviewModel {
  String? status;
  List<DriverReview>? driverReview;

  DriverReviewModel({this.status, this.driverReview});

  DriverReviewModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['driverReview'] != null) {
      driverReview = <DriverReview>[];
      json['driverReview'].forEach((v) {
        driverReview!.add(new DriverReview.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.driverReview != null) {
      data['driverReview'] = this.driverReview!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class DriverReview {
  int? id;
  String? dId;
  String? reviews;
  String? userId;
  int? star;
  int? accept;
  String? title;
  String? createdAt;
  String? updatedAt;

  DriverReview(
      {this.id,
      this.dId,
      this.reviews,
      this.userId,
      this.star,
      this.accept,
      this.title,
      this.createdAt,
      this.updatedAt});

  DriverReview.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    dId = json['d_id'];
    reviews = json['reviews'];
    userId = json['user_id'];
    star = json['star'];
    accept = json['accept'];
    title = json['title'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['d_id'] = this.dId;
    data['reviews'] = this.reviews;
    data['user_id'] = this.userId;
    data['star'] = this.star;
    data['accept'] = this.accept;
    data['title'] = this.title;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
