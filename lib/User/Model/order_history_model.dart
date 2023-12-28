class OrderHistoryModel {
  String? status;
  List<Salesledger>? salesledger;

  OrderHistoryModel({this.status, this.salesledger});

  OrderHistoryModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['salesledger'] != null) {
      salesledger = <Salesledger>[];
      json['salesledger'].forEach((v) {
        salesledger!.add(new Salesledger.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.salesledger != null) {
      data['salesledger'] = this.salesledger!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Salesledger {
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
  int? bId;
  String? fullname;
  String? logo;
  String? address;
  String? latitude;
  String? longitude;
  List<BillingItems>? billingItems;

  Salesledger(
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
      this.bId,
      this.fullname,
      this.logo,
      this.address,
      this.latitude,
      this.longitude,
      this.billingItems});

  Salesledger.fromJson(Map<String, dynamic> json) {
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
    bId = json['b_id'];
    fullname = json['fullname'];
    logo = json['logo'];
    address = json['address'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    if (json['Billing_items'] != null) {
      billingItems = <BillingItems>[];
      json['Billing_items'].forEach((v) {
        billingItems!.add(new BillingItems.fromJson(v));
      });
    }
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
    data['b_id'] = this.bId;
    data['fullname'] = this.fullname;
    data['logo'] = this.logo;
    data['address'] = this.address;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    if (this.billingItems != null) {
      data['Billing_items'] =
          this.billingItems!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
class BillingItems {
  int? itemId;
  int? quantity;
  int? rate;
  String? itemName;

  BillingItems({this.itemId, this.quantity, this.rate, this.itemName});

  BillingItems.fromJson(Map<String, dynamic> json) {
    itemId = json['item_id'];
    quantity = json['quantity'];
    rate = json['rate'];
    itemName = json['item_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['item_id'] = this.itemId;
    data['quantity'] = this.quantity;
    data['rate'] = this.rate;
    data['item_name'] = this.itemName;
    return data;
  }
}