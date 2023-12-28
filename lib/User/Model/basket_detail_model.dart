class BasketDetail {
  String? status;
  List<ServiceProviderItemsWithCategories>? serviceProviderItemsWithCategories;

  BasketDetail({this.status, this.serviceProviderItemsWithCategories});

  BasketDetail.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['serviceProviderItemsWithCategories'] != null) {
      serviceProviderItemsWithCategories =
          <ServiceProviderItemsWithCategories>[];
      json['serviceProviderItemsWithCategories'].forEach((v) {
        serviceProviderItemsWithCategories!
            .add(new ServiceProviderItemsWithCategories.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.serviceProviderItemsWithCategories != null) {
      data['serviceProviderItemsWithCategories'] = this
          .serviceProviderItemsWithCategories!
          .map((v) => v.toJson())
          .toList();
    }
    return data;
  }
}

class ServiceProviderItemsWithCategories {
  int? id;
  String? catName;
  int? status;
  String? sId;
  String? createdAt;
  String? updatedAt;
  List<CatItems>? catItems;

  ServiceProviderItemsWithCategories(
      {this.id,
      this.catName,
      this.status,
      this.sId,
      this.createdAt,
      this.updatedAt,
      this.catItems});

  ServiceProviderItemsWithCategories.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    catName = json['cat_name'];
    status = json['status'];
    sId = json['s_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    if (json['Cat_Items'] != null) {
      catItems = <CatItems>[];
      json['Cat_Items'].forEach((v) {
        catItems!.add(new CatItems.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['cat_name'] = catName;
    data['status'] = status;
    data['s_id'] = sId;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    if (catItems != null) {
      data['Cat_Items'] = catItems!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CatItems {
  int? id;
  String? sId;
  String? itemName;
  String? itemDetails;
  int? catId;
  int? normalRate;
  String? unit;
  Null vatable;
  int? cancel;
  int? discountInPercent;
  int? sellrate;
  String? coverImage;
  int? sellCount;
  String? createdAt;
  String? updatedAt;

  CatItems(
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

  CatItems.fromJson(Map<String, dynamic> json) {
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
