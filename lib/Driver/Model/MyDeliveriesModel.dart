class MyDeliveriesModel {
  bool? status;
  String? message;
  List<Data>? data;

  MyDeliveriesModel({this.status, this.message, this.data});

  MyDeliveriesModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int? id;
  int? userId;
  String? tCode;
  int? cancel;
  String? modeOfPayment;
  int? dId;
  int? discount;
  int? amount;
  int? vat;
  int? total;
  String? paymentNote;
  String? remarks;
  int? noOfItems;
  int? taxable;
  int? nonTaxable;
  String? sId;
  String? delivaryLocation;
  String? lat;
  String? long;
  int? deliveredStatus;
  String? distance;
  int? deliveryCharge;
  int? isPaidOrNot;
  String? createdAt;
  String? updatedAt;
  int? deliveryStatus;
  String? fullname;
  String? logo;
  String? longitude;
  String? latitude;
  String? googleMapLocation;
  String? address;

  Data(
      {this.id,
      this.userId,
      this.tCode,
      this.cancel,
      this.modeOfPayment,
      this.dId,
      this.discount,
      this.amount,
      this.vat,
      this.total,
      this.paymentNote,
      this.remarks,
      this.noOfItems,
      this.taxable,
      this.nonTaxable,
      this.sId,
      this.delivaryLocation,
      this.lat,
      this.long,
      this.deliveredStatus,
      this.distance,
      this.deliveryCharge,
      this.isPaidOrNot,
      this.createdAt,
      this.updatedAt,
      this.deliveryStatus,
      this.fullname,
      this.logo,
      this.longitude,
      this.latitude,
      this.googleMapLocation,
      this.address});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    tCode = json['t_code'];
    cancel = json['cancel'];
    modeOfPayment = json['mode_of_payment'];
    dId = json['d_id'];
    discount = json['discount'];
    amount = json['amount'];
    vat = json['vat'];
    total = json['total'];
    paymentNote = json['payment_note'];
    remarks = json['remarks'];
    noOfItems = json['no_of_items'];
    taxable = json['taxable'];
    nonTaxable = json['non_taxable'];
    sId = json['s_id'];
    delivaryLocation = json['delivary_location'];
    lat = json['lat'];
    long = json['long'];
    deliveredStatus = json['delivered_status'];
    distance = json['distance'];
    deliveryCharge = json['delivery_charge'];
    isPaidOrNot = json['is_paid_or_not'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deliveryStatus = json['delivery_status'];
    fullname = json['fullname'];
    logo = json['logo'];
    longitude = json['longitude'];
    latitude = json['latitude'];
    googleMapLocation = json['google_map_location'];
    address = json['address'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['t_code'] = this.tCode;
    data['cancel'] = this.cancel;
    data['mode_of_payment'] = this.modeOfPayment;
    data['d_id'] = this.dId;
    data['discount'] = this.discount;
    data['amount'] = this.amount;
    data['vat'] = this.vat;
    data['total'] = this.total;
    data['payment_note'] = this.paymentNote;
    data['remarks'] = this.remarks;
    data['no_of_items'] = this.noOfItems;
    data['taxable'] = this.taxable;
    data['non_taxable'] = this.nonTaxable;
    data['s_id'] = this.sId;
    data['delivary_location'] = this.delivaryLocation;
    data['lat'] = this.lat;
    data['long'] = this.long;
    data['delivered_status'] = this.deliveredStatus;
    data['distance'] = this.distance;
    data['delivery_charge'] = this.deliveryCharge;
    data['is_paid_or_not'] = this.isPaidOrNot;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['delivery_status'] = this.deliveryStatus;
    data['fullname'] = this.fullname;
    data['logo'] = this.logo;
    data['longitude'] = this.longitude;
    data['latitude'] = this.latitude;
    data['google_map_location'] = this.googleMapLocation;
    data['address'] = this.address;
    return data;
  }
}
