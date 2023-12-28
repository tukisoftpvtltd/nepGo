class signupmodel {
  bool? success;
  String? message;
  Data? data;
  String? accessToken;
  int? otp;
  OTPResponse? oTPResponse;
  int? oTPStatusCode;

  signupmodel(
      {this.success,
      this.message,
      this.data,
      this.accessToken,
      this.otp,
      this.oTPResponse,
      this.oTPStatusCode});

  signupmodel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    accessToken = json['access_token'];
    otp = json['otp'];
    oTPResponse = json['OTPResponse'] != null
        ? new OTPResponse.fromJson(json['OTPResponse'])
        : null;
    oTPStatusCode = json['OTP Status Code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['access_token'] = this.accessToken;
    data['otp'] = this.otp;
    if (this.oTPResponse != null) {
      data['OTPResponse'] = this.oTPResponse!.toJson();
    }
    data['OTP Status Code'] = this.oTPStatusCode;
    return data;
  }
}

class Data {
  String? fname;
  String? lname;
  String? email;
  String? mobileNumber;
  int? emailVerified;
  Null? gender;
  Null? userCountry;
  Null? userProfession;
  Null? userThumbnail;
  int? userCatagory;
  int? otpCode;
  int? isDeleted;
  int? blog;
  String? password;
  String? updatedAt;
  String? createdAt;
  int? userId;

  Data(
      {this.fname,
      this.lname,
      this.email,
      this.mobileNumber,
      this.emailVerified,
      this.gender,
      this.userCountry,
      this.userProfession,
      this.userThumbnail,
      this.userCatagory,
      this.otpCode,
      this.isDeleted,
      this.blog,
      this.password,
      this.updatedAt,
      this.createdAt,
      this.userId});

  Data.fromJson(Map<String, dynamic> json) {
    fname = json['fname'];
    lname = json['lname'];
    email = json['email'];
    mobileNumber = json['mobile_number'];
    emailVerified = json['email_verified'];
    gender = json['gender'];
    userCountry = json['user_country'];
    userProfession = json['user_profession'];
    userThumbnail = json['user_thumbnail'];
    userCatagory = json['user_catagory'];
    otpCode = json['otp_code'];
    isDeleted = json['is_deleted'];
    blog = json['blog'];
    password = json['password'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    userId = json['user_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['fname'] = this.fname;
    data['lname'] = this.lname;
    data['email'] = this.email;
    data['mobile_number'] = this.mobileNumber;
    data['email_verified'] = this.emailVerified;
    data['gender'] = this.gender;
    data['user_country'] = this.userCountry;
    data['user_profession'] = this.userProfession;
    data['user_thumbnail'] = this.userThumbnail;
    data['user_catagory'] = this.userCatagory;
    data['otp_code'] = this.otpCode;
    data['is_deleted'] = this.isDeleted;
    data['blog'] = this.blog;
    data['password'] = this.password;
    data['updated_at'] = this.updatedAt;
    data['created_at'] = this.createdAt;
    data['user_id'] = this.userId;
    return data;
  }
}

class OTPResponse {
  int? count;
  int? responseCode;
  String? response;
  int? messageId;
  int? creditConsumed;
  double? creditAvailable;

  OTPResponse(
      {this.count,
      this.responseCode,
      this.response,
      this.messageId,
      this.creditConsumed,
      this.creditAvailable});

  OTPResponse.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    responseCode = json['response_code'];
    response = json['response'];
    messageId = json['message_id'];
    creditConsumed = json['credit_consumed'];
    creditAvailable = json['credit_available'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['count'] = this.count;
    data['response_code'] = this.responseCode;
    data['response'] = this.response;
    data['message_id'] = this.messageId;
    data['credit_consumed'] = this.creditConsumed;
    data['credit_available'] = this.creditAvailable;
    return data;
  }
}
