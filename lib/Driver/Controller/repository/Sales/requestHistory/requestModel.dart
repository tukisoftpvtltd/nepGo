import 'package:flutter/rendering.dart';

class RequestModel {
  int? currentPage;
  List<Data>? data;
  String? firstPageUrl;
  int? from;
  int? lastPage;
  String? lastPageUrl;
  List<Links>? links;
  String? nextPageUrl;
  String? path;
  int? perPage;
  String? prevPageUrl;
  int? to;
  int? total;

  RequestModel(
      {this.currentPage,
      this.data,
      this.firstPageUrl,
      this.from,
      this.lastPage,
      this.lastPageUrl,
      this.links,
      this.nextPageUrl,
      this.path,
      this.perPage,
      this.prevPageUrl,
      this.to,
      this.total});

  RequestModel.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
    firstPageUrl = json['first_page_url'];
    from = json['from'];
    lastPage = json['last_page'];
    lastPageUrl = json['last_page_url'];
    if (json['links'] != null) {
      links = <Links>[];
      json['links'].forEach((v) {
        links!.add(new Links.fromJson(v));
      });
    }
    nextPageUrl = json['next_page_url'];
    path = json['path'];
    perPage = json['per_page'];
    prevPageUrl = json['prev_page_url'];
    to = json['to'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['current_page'] = this.currentPage;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['first_page_url'] = this.firstPageUrl;
    data['from'] = this.from;
    data['last_page'] = this.lastPage;
    data['last_page_url'] = this.lastPageUrl;
    if (this.links != null) {
      data['links'] = this.links!.map((v) => v.toJson()).toList();
    }
    data['next_page_url'] = this.nextPageUrl;
    data['path'] = this.path;
    data['per_page'] = this.perPage;
    data['prev_page_url'] = this.prevPageUrl;
    data['to'] = this.to;
    data['total'] = this.total;
    return data;
  }
}

class Data {
  int? id;
  int? userId;
  String? tCode;
  int? cancel;
  int? dId;
  int? amount;
  String? remarks;
  String? pickupLocation;
  String? detinationLocation;
  int? isRideCompleted;
  double? distance;
  String? cancelationReason;
  String? driverIssueReport;
  String? userIssueReport;
  String? createdAt;
  String? updatedAt;

  Data(
      {this.id,
      this.userId,
      this.tCode,
      this.cancel,
      this.dId,
      this.amount,
      this.remarks,
      this.pickupLocation,
      this.detinationLocation,
      this.isRideCompleted,
      this.distance,
      this.cancelationReason,
      this.driverIssueReport,
      this.userIssueReport,
      this.createdAt,
      this.updatedAt});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    tCode = json['t_code'];
    cancel = json['cancel'];
    dId = json['d_id'];
    amount = json['amount'];
    remarks = json['remarks'];
    pickupLocation = json['pickup_location'];
    detinationLocation = json['detination_location'];
    isRideCompleted = json['isRideCompleted'];
    distance = double.parse(json['distance'].toString());
    cancelationReason = json['cancelation_reason'];
    driverIssueReport = json['driverIssueReport'];
    userIssueReport = json['userIssueReport'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['t_code'] = this.tCode;
    data['cancel'] = this.cancel;
    data['d_id'] = this.dId;
    data['amount'] = this.amount;
    data['remarks'] = this.remarks;
    data['pickup_location'] = this.pickupLocation;
    data['detination_location'] = this.detinationLocation;
    data['isRideCompleted'] = this.isRideCompleted;
    data['distance'] = this.distance;
    data['cancelation_reason'] = this.cancelationReason;
    data['driverIssueReport'] = this.driverIssueReport;
    data['userIssueReport'] = this.userIssueReport;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class Links {
  String? url;
  String? label;
  bool? active;

  Links({this.url, this.label, this.active});

  Links.fromJson(Map<String, dynamic> json) {
    url = json['url'];
    label = json['label'];
    active = json['active'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['url'] = this.url;
    data['label'] = this.label;
    data['active'] = this.active;
    return data;
  }
}


class DataValue {
  int? id;
  int? userId;
  String? tCode;
  int? cancel;
  int? dId;
  int? amount;
  String? remarks;
  String? pickupLocation;
  String? detinationLocation;
  int? isRideCompleted;
  double? distance;
  String? cancelationReason;
  String? driverIssueReport;
  String? userIssueReport;
  String? createdAt;
  String? updatedAt;

  DataValue(
      {this.id,
      this.userId,
      this.tCode,
      this.cancel,
      this.dId,
      this.amount,
      this.remarks,
      this.pickupLocation,
      this.detinationLocation,
      this.isRideCompleted,
      this.distance,
      this.cancelationReason,
      this.driverIssueReport,
      this.userIssueReport,
      this.createdAt,
      this.updatedAt});

  DataValue.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    tCode = json['t_code'];
    cancel = json['cancel'];
    dId = json['d_id'];
    amount = json['amount'];
    remarks = json['remarks'];
    pickupLocation = json['pickup_location'];
    detinationLocation = json['detination_location'];
    isRideCompleted = json['isRideCompleted'];
    distance = double.parse(json['distance'].toString());
    cancelationReason = json['cancelation_reason'];
    driverIssueReport = json['driverIssueReport'];
    userIssueReport = json['userIssueReport'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['t_code'] = this.tCode;
    data['cancel'] = this.cancel;
    data['d_id'] = this.dId;
    data['amount'] = this.amount;
    data['remarks'] = this.remarks;
    data['pickup_location'] = this.pickupLocation;
    data['detination_location'] = this.detinationLocation;
    data['isRideCompleted'] = this.isRideCompleted;
    data['distance'] = this.distance;
    data['cancelation_reason'] = this.cancelationReason;
    data['driverIssueReport'] = this.driverIssueReport;
    data['userIssueReport'] = this.userIssueReport;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}