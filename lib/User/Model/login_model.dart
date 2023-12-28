class LoginModel {
  bool? success;
  String? message;
  String? email;
  String? password;
  Data? data;
  AccessToken? accessToken;

  LoginModel({this.success, this.message, this.data, this.email,this.password,this.accessToken});

  LoginModel.fromJson(Map<String, dynamic> json) {
    success = json['success'] ;
    message = json['message']??'';
    email = json['email']?? '';
    password = json['password']?? '';
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    accessToken = json['access_token'] != null
        ? new AccessToken.fromJson(json['access_token'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    data['email']= this.email;
     data['password']= this.password;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    if (this.accessToken != null) {
      data['access_token'] = this.accessToken!.toJson();
    }
    return data;
  }
}

class Data {
  int? userId;
  String? fname;
  String? lname;
  String? email;
  int? otpCode;
  String? userThumbnail;
  int? status;
  String? password;
  int? mobileNumber;

  Data(
      {this.userId,
      this.fname,
      this.lname,
      this.email,
      this.otpCode,
      this.userThumbnail,
      this.status,
      this.password,
      this.mobileNumber});

  Data.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    fname = json['fname'];
    lname = json['lname'];
    email = json['email'];
    otpCode = json['otp_code'];
    userThumbnail = json['user_thumbnail'];
    status = json['status'];
    password = json['password'];
    mobileNumber = json['mobile_number'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_id'] = this.userId;
    data['fname'] = this.fname;
    data['lname'] = this.lname;
    data['email'] = this.email;
    data['otp_code'] = this.otpCode;
    data['user_thumbnail'] = this.userThumbnail;
    data['status'] = this.status;
    data['password'] = this.password;
    data['mobile_number'] = this.mobileNumber;
    return data;
  }
}

class AccessToken {
  String? name;
  List<String>? abilities;
  Null? expiresAt;
  int? tokenableId;
  String? tokenableType;
  String? updatedAt;
  String? createdAt;
  int? id;

  AccessToken(
      {this.name,
      this.abilities,
      this.expiresAt,
      this.tokenableId,
      this.tokenableType,
      this.updatedAt,
      this.createdAt,
      this.id});

  AccessToken.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    abilities = json['abilities'].cast<String>();
    expiresAt = json['expires_at'];
    tokenableId = json['tokenable_id'];
    tokenableType = json['tokenable_type'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['abilities'] = this.abilities;
    data['expires_at'] = this.expiresAt;
    data['tokenable_id'] = this.tokenableId;
    data['tokenable_type'] = this.tokenableType;
    data['updated_at'] = this.updatedAt;
    data['created_at'] = this.createdAt;
    data['id'] = this.id;
    return data;
  }
}
