class DriverDetailModel {
  bool? status;
  DriverDetails? driverDetails;

  DriverDetailModel({this.status, this.driverDetails});

  DriverDetailModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    driverDetails = json['driverDetails'] != null
        ? new DriverDetails.fromJson(json['driverDetails'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.driverDetails != null) {
      data['driverDetails'] = this.driverDetails!.toJson();
    }
    return data;
  }
}

class DriverDetails {
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
  String? driverLicenseNumber;
  String? vehicleBrand;
  String? vehicleColor;
  String? vechicleNumber;
  String? vechiclePhotos;
  String? billbook;

  DriverDetails(
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
      this.updatedAt,
      this.driverLicenseNumber,
      this.vehicleBrand,
      this.vehicleColor,
      this.vechicleNumber,
      this.vechiclePhotos,
      this.billbook});

  DriverDetails.fromJson(Map<String, dynamic> json) {
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
    driverLicenseNumber = json['driver_license_number'];
    vehicleBrand = json['vehicle_brand'];
    vehicleColor = json['vehicle_color'];
    vechicleNumber = json['vechicle_number'];
    vechiclePhotos = json['vechicle_photos'];
    billbook = json['billbook'];
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
    data['driver_license_number'] = this.driverLicenseNumber;
    data['vehicle_brand'] = this.vehicleBrand;
    data['vehicle_color'] = this.vehicleColor;
    data['vechicle_number'] = this.vechicleNumber;
    data['vechicle_photos'] = this.vechiclePhotos;
    data['billbook'] = this.billbook;
    return data;
  }
}