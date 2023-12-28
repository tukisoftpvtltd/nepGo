class DriverBankDetailModel {
  bool? status;
  BankData? bankData;

  DriverBankDetailModel({this.status, this.bankData});

  DriverBankDetailModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    bankData = json['BankData'] != null
        ? new BankData.fromJson(json['BankData'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.bankData != null) {
      data['BankData'] = this.bankData!.toJson();
    }
    return data;
  }
}

class BankData {
  int? dBId;
  int? dId;
  String? accountName;
  String? accountNumber;
  String? bankName;
  String? bankBranch;
  String? createdAt;
  String? updatedAt;

  BankData(
      {this.dBId,
      this.dId,
      this.accountName,
      this.accountNumber,
      this.bankName,
      this.bankBranch,
      this.createdAt,
      this.updatedAt});

  BankData.fromJson(Map<String, dynamic> json) {
    dBId = json['d_b_id'];
    dId = json['d_id'];
    accountName = json['account_name'];
    accountNumber = json['account_number'];
    bankName = json['bank_name'];
    bankBranch = json['bank_branch'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['d_b_id'] = this.dBId;
    data['d_id'] = this.dId;
    data['account_name'] = this.accountName;
    data['account_number'] = this.accountNumber;
    data['bank_name'] = this.bankName;
    data['bank_branch'] = this.bankBranch;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
