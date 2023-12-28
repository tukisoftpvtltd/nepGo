class BasketListModel {
  String? status;
  List<ServiceProviderWithItemsCount>? serviceProviderWithItemsCount;

  BasketListModel({this.status, this.serviceProviderWithItemsCount});

  BasketListModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['serviceProviderWithItemsCount'] != null) {
      serviceProviderWithItemsCount = <ServiceProviderWithItemsCount>[];
      json['serviceProviderWithItemsCount'].forEach((v) {
        serviceProviderWithItemsCount!
            .add(new ServiceProviderWithItemsCount.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.serviceProviderWithItemsCount != null) {
      data['serviceProviderWithItemsCount'] =
          this.serviceProviderWithItemsCount!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ServiceProviderWithItemsCount {
  String? sId;
  Null bId;
  String? fullname;
  String? logo;
  String? address;
  String? latitude;
  String? longitude;
  String? openingTime;
  String? closingTime;
  String? averageRate;
  List<BasketItems>? basketItems;
  List<Null>? reviews;

  ServiceProviderWithItemsCount(
      {this.sId,
      this.bId,
      this.fullname,
      this.logo,
      this.address,
      this.latitude,
      this.longitude,
      this.openingTime,
      this.closingTime,
      this.averageRate,
      this.basketItems,
      this.reviews});

  ServiceProviderWithItemsCount.fromJson(Map<String, dynamic> json) {
    sId = json['s_id'];
    bId = json['b_id'];
    fullname = json['fullname'];
    logo = json['logo'];
    address = json['address'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    openingTime = json['openingTime'];
    closingTime = json['closingTime'];
    averageRate = json['average_rating'];
    if (json['Basket_Items'] != null) {
      basketItems = <BasketItems>[];
      json['Basket_Items'].forEach((v) {
        basketItems!.add(new BasketItems.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['s_id'] = this.sId;
    data['b_id'] = this.bId;
    data['fullname'] = this.fullname;
    data['logo'] = this.logo;
    data['address'] = this.address;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['openingTime'] = this.openingTime;
    data['closingTime'] = this.closingTime;
    data['average_rating'] = this.averageRate;

    if (this.basketItems != null) {
      data['Basket_Items'] = this.basketItems!.map((v) => v.toJson()).toList();
    }

    return data;
  }
}

class BasketItems {
  int? itemId;
  int? quantity;
  int? rate;
  String? itemName;

  BasketItems({this.itemId, this.quantity, this.rate});

  BasketItems.fromJson(Map<String, dynamic> json) {
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
