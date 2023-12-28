class PostDriverModel {
  String? status;
  String? message;
  Data? data;

  PostDriverModel({this.status, this.message, this.data});

  PostDriverModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  String? fullname;
  String? email;
  String? password;
  String? mobileNumber;
  Null? citizenship;
  String? vehicleType;
  String? address;
  Null? vehicleOwner;
  Null? license;
  Null? licenseExpiryDate;
  Null? billBookExpiryDate;
  Null? addressTemporary;
  String? city;
  String? updatedAt;
  String? createdAt;
  int? dId;

  Data(
      {this.fullname,
      this.email,
      this.password,
      this.mobileNumber,
      this.citizenship,
      this.vehicleType,
      this.address,
      this.vehicleOwner,
      this.license,
      this.licenseExpiryDate,
      this.billBookExpiryDate,
      this.addressTemporary,
      this.city,
      this.updatedAt,
      this.createdAt,
      this.dId});

  Data.fromJson(Map<String, dynamic> json) {
    fullname = json['fullname'];
    email = json['email'];
    password = json['password'];
    mobileNumber = json['mobile_number'];
    citizenship = json['citizenship'];
    vehicleType = json['vehicle_type'];
    address = json['address'];
    vehicleOwner = json['vehicle_owner'];
    license = json['license'];
    licenseExpiryDate = json['license_expiry_date'];
    billBookExpiryDate = json['bill_book_expiry_date'];
    addressTemporary = json['address_temporary'];
    city = json['city'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    dId = json['d_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['fullname'] = this.fullname;
    data['email'] = this.email;
    data['password'] = this.password;
    data['mobile_number'] = this.mobileNumber;
    data['citizenship'] = this.citizenship;
    data['vehicle_type'] = this.vehicleType;
    data['address'] = this.address;
    data['vehicle_owner'] = this.vehicleOwner;
    data['license'] = this.license;
    data['license_expiry_date'] = this.licenseExpiryDate;
    data['bill_book_expiry_date'] = this.billBookExpiryDate;
    data['address_temporary'] = this.addressTemporary;
    data['city'] = this.city;
    data['updated_at'] = this.updatedAt;
    data['created_at'] = this.createdAt;
    data['d_id'] = this.dId;
    return data;
  }
}
