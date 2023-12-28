class SearchResultModel {
  String? status;
  List<ServiceProvider>? serviceProvider;
  List<ItemsWithServieProviders>? itemsWithServieProviders;

  SearchResultModel(
      {this.status, this.serviceProvider, this.itemsWithServieProviders});

  SearchResultModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['serviceProvider'] != null) {
      serviceProvider = <ServiceProvider>[];
      json['serviceProvider'].forEach((v) {
        serviceProvider!.add(new ServiceProvider.fromJson(v));
      });
    }
    if (json['itemsWithServieProviders'] != null) {
      itemsWithServieProviders = <ItemsWithServieProviders>[];
      json['itemsWithServieProviders'].forEach((v) {
        itemsWithServieProviders!.add(new ItemsWithServieProviders.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.serviceProvider != null) {
      data['serviceProvider'] =
          this.serviceProvider!.map((v) => v.toJson()).toList();
    }
    if (this.itemsWithServieProviders != null) {
      data['itemsWithServieProviders'] =
          this.itemsWithServieProviders!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ServiceProvider {
  String? address;
  String? sId;
  Null? bId;
  String? fullname;
  String? logo;
  String? averageRating;
  double? distance;
  String? latitude;
  String? longitude;
  List<TopPickItems>? topPickItems;

  ServiceProvider(
      {this.address,
      this.sId,
      this.bId,
      this.fullname,
      this.logo,
      this.averageRating,
      this.distance,
      this.latitude,
      this.longitude,
      this.topPickItems});

  ServiceProvider.fromJson(Map<String, dynamic> json) {
    address = json['address'];
    sId = json['s_id'];
    bId = json['b_id'];
    fullname = json['fullname'];
    logo = json['logo'];
    averageRating = json['average_rating'];
    distance = json['distance'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    if (json['TopPickItems'] != null) {
      topPickItems = <TopPickItems>[];
      json['TopPickItems'].forEach((v) {
        topPickItems!.add(new TopPickItems.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['address'] = this.address;
    data['s_id'] = this.sId;
    data['b_id'] = this.bId;
    data['fullname'] = this.fullname;
    data['logo'] = this.logo;
    data['average_rating'] = this.averageRating;
    data['distance'] = this.distance;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    if (this.topPickItems != null) {
      data['TopPickItems'] = this.topPickItems!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class TopPickItems {
  int? id;
  String? sId;
  String? itemName;
  String? itemDetails;
  int? catId;
  int? normalRate;
  String? unit;
  Null? vatable;
  int? cancel;
  int? discountInPercent;
  int? sellrate;
  String? coverImage;
  int? sellCount;
  String? createdAt;
  String? updatedAt;

  TopPickItems(
      {this.id,
      this.sId,
      this.itemName,
      this.itemDetails,
      this.catId,
      this.normalRate,
      this.unit,
      this.vatable,
      this.cancel,
      this.discountInPercent,
      this.sellrate,
      this.coverImage,
      this.sellCount,
      this.createdAt,
      this.updatedAt});

  TopPickItems.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    sId = json['s_id'];
    itemName = json['item_name'];
    itemDetails = json['item_details'];
    catId = json['cat_id'];
    normalRate = json['normal_rate'];
    unit = json['unit'];
    vatable = json['vatable'];
    cancel = json['cancel'];
    discountInPercent = json['discount_in_percent'];
    sellrate = json['sellrate'];
    coverImage = json['cover_image'];
    sellCount = json['sell_count'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['s_id'] = this.sId;
    data['item_name'] = this.itemName;
    data['item_details'] = this.itemDetails;
    data['cat_id'] = this.catId;
    data['normal_rate'] = this.normalRate;
    data['unit'] = this.unit;
    data['vatable'] = this.vatable;
    data['cancel'] = this.cancel;
    data['discount_in_percent'] = this.discountInPercent;
    data['sellrate'] = this.sellrate;
    data['cover_image'] = this.coverImage;
    data['sell_count'] = this.sellCount;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class ItemsWithServieProviders {
  String? sId;
  String? address;
  String? fullname;
  String? logo;
  String? averageRating;
  double? distance;
  String? latitude;
  String? longitude;
  List<TopPickItems>? topPickItems;

  ItemsWithServieProviders(
      {this.sId,
      this.address,
      this.fullname,
      this.logo,
      this.averageRating,
      this.distance,
      this.latitude,
      this.longitude,
      this.topPickItems});

  ItemsWithServieProviders.fromJson(Map<String, dynamic> json) {
    sId = json['s_id'];
    address = json['address'];
    fullname = json['fullname'];
    logo = json['logo'];
    averageRating = json['average_rating'];
    distance = json['distance'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    if (json['TopPickItems'] != null) {
      topPickItems = <TopPickItems>[];
      json['TopPickItems'].forEach((v) {
        topPickItems!.add(new TopPickItems.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['s_id'] = this.sId;
    data['address'] = this.address;
    data['fullname'] = this.fullname;
    data['logo'] = this.logo;
    data['average_rating'] = this.averageRating;
    data['distance'] = this.distance;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    if (this.topPickItems != null) {
      data['TopPickItems'] = this.topPickItems!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}