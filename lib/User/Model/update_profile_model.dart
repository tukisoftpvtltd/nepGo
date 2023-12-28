class UpdateProfileModel {
  bool? success;
  String? message;
  Data? data;

  UpdateProfileModel({this.success, this.message, this.data});

  UpdateProfileModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  int? userId;
  String? fname;
  String? lname;
  String? email;
  int? emailVerified;
  String? mobileNumber;
  int? otpCode;
  Null? gender;
  String? blog;
  String? password;
  Null? rememberToken;
  String? userThumbnail;
  Null? userCountry;
  Null? userProfession;
  String? userCatagory;
  int? isDeleted;
  int? status;
  String? createdAt;
  String? updatedAt;

  Data(
      {this.userId,
      this.fname,
      this.lname,
      this.email,
      this.emailVerified,
      this.mobileNumber,
      this.otpCode,
      this.gender,
      this.blog,
      this.password,
      this.rememberToken,
      this.userThumbnail,
      this.userCountry,
      this.userProfession,
      this.userCatagory,
      this.isDeleted,
      this.status,
      this.createdAt,
      this.updatedAt});

  Data.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    fname = json['fname'];
    lname = json['lname'];
    email = json['email'];
    emailVerified = json['email_verified'];
    mobileNumber = json['mobile_number'];
    otpCode = json['otp_code'];
    gender = json['gender'];
    blog = json['blog'];
    password = json['password'];
    rememberToken = json['remember_token'];
    userThumbnail = json['user_thumbnail'];
    userCountry = json['user_country'];
    userProfession = json['user_profession'];
    userCatagory = json['user_catagory'];
    isDeleted = json['is_deleted'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_id'] = this.userId;
    data['fname'] = this.fname;
    data['lname'] = this.lname;
    data['email'] = this.email;
    data['email_verified'] = this.emailVerified;
    data['mobile_number'] = this.mobileNumber;
    data['otp_code'] = this.otpCode;
    data['gender'] = this.gender;
    data['blog'] = this.blog;
    data['password'] = this.password;
    data['remember_token'] = this.rememberToken;
    data['user_thumbnail'] = this.userThumbnail;
    data['user_country'] = this.userCountry;
    data['user_profession'] = this.userProfession;
    data['user_catagory'] = this.userCatagory;
    data['is_deleted'] = this.isDeleted;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
