class LoginModel {
  String? message;
  Driver? driver;

  LoginModel({this.message, this.driver});

  LoginModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    driver =
        json['driver'] != null ? new Driver.fromJson(json['driver']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    if (this.driver != null) {
      data['driver'] = this.driver!.toJson();
    }
    return data;
  }
}

class Driver {
  int? dId;
  String? fullname;
  String? email;
  String? password;
  int? mobileNumber;
  String? citizenship;
  int? vehicleType;
  String? address;
  String? vehicleOwner;
  String? license;
  String? licenseExpiryDate;
  String? billBookExpiryDate;
  String? addressTemporary;
  String? city;
  int? approved;
  int? cancel;
  String? playerId;
  String? profileImage;
  int? driverType;
  String? createdAt;
  String? updatedAt;

  Driver(
      {this.dId,
      this.fullname,
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
      this.approved,
      this.cancel,
      this.playerId,
      this.profileImage,
      this.driverType,
      this.createdAt,
      this.updatedAt});

  Driver.fromJson(Map<String, dynamic> json) {
    dId = json['d_id'];
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
    approved = json['approved'];
    cancel = json['cancel'];
    playerId = json['playerId'];
    profileImage = json['profileImage'];
    driverType = json['driver_type'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['d_id'] = this.dId;
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
    data['approved'] = this.approved;
    data['cancel'] = this.cancel;
    data['playerId'] = this.playerId;
    data['profileImage'] = this.profileImage;
    data['driver_type'] = this.driverType;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
