class HomePageModel {
  String? status;
  List<FeaturedRestaurant>? featuredRestaurant;
  List<FeaturedGroceries>? featuredGroceries;
  List<GroceriesTopPick>? groceriesTopPick;
  List<RestaurantItemsTopPick>? restaurantItemsTopPick;

  HomePageModel(
      {this.status,
      this.featuredRestaurant,
      this.featuredGroceries,
      this.groceriesTopPick,
      this.restaurantItemsTopPick});

  HomePageModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['featuredRestaurant'] != null) {
      featuredRestaurant = <FeaturedRestaurant>[];
      json['featuredRestaurant'].forEach((v) {
        featuredRestaurant!.add(new FeaturedRestaurant.fromJson(v));
      });
    }
    if (json['featuredGroceries'] != null) {
      featuredGroceries = <FeaturedGroceries>[];
      json['featuredGroceries'].forEach((v) {
        featuredGroceries!.add(new FeaturedGroceries.fromJson(v));
      });
    }
    if (json['groceriesTopPick'] != null) {
      groceriesTopPick = <GroceriesTopPick>[];
      json['groceriesTopPick'].forEach((v) {
        groceriesTopPick!.add(new GroceriesTopPick.fromJson(v));
      });
    }
    if (json['restaurantItemsTopPick'] != null) {
      restaurantItemsTopPick = <RestaurantItemsTopPick>[];
      json['restaurantItemsTopPick'].forEach((v) {
        restaurantItemsTopPick!.add(new RestaurantItemsTopPick.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.featuredRestaurant != null) {
      data['featuredRestaurant'] =
          this.featuredRestaurant!.map((v) => v.toJson()).toList();
    }
    if (this.featuredGroceries != null) {
      data['featuredGroceries'] =
          this.featuredGroceries!.map((v) => v.toJson()).toList();
    }
    if (this.groceriesTopPick != null) {
      data['groceriesTopPick'] =
          this.groceriesTopPick!.map((v) => v.toJson()).toList();
    }
    if (this.restaurantItemsTopPick != null) {
      data['restaurantItemsTopPick'] =
          this.restaurantItemsTopPick!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class FeaturedRestaurant {
  String? openingTime;
  String? closingTime;
  String? address;
  String? banner;
  String? sId;
  Null? bId;
  String? fullname;
  String? email;
  Null? emailVerified;
  int? mobileNumber;
  Null? otpCode;
  int? serviceStatus;
  String? logo;
  String? averageRating;
  double? distance;
  String? latitude;
  String? longitude;

  FeaturedRestaurant(
      {
      this.openingTime,
      this.closingTime,
      this.address,
      this.banner,
      this.sId,
      this.bId,
      this.fullname,
      this.email,
      this.emailVerified,
      this.mobileNumber,
      this.otpCode,
      this.serviceStatus,
      this.logo,
      this.averageRating,
      this.distance,
      this.latitude,
      this.longitude});

  FeaturedRestaurant.fromJson(Map<String, dynamic> json) {
    openingTime = json['openingTime'];
    closingTime = json['closingTime'];
    address = json['address'];
    banner = json['banner'];
    sId = json['s_id'];
    bId = json['b_id'];
    fullname = json['fullname'];
    email = json['email'];
    emailVerified = json['email_verified'];
    mobileNumber = json['mobile_number'];
    otpCode = json['otp_code'];
    serviceStatus = json['service_status'];
    logo = json['logo'];
    averageRating = json['average_rating'];
    distance = json['distance'];
    latitude = json['latitude'];
    longitude = json['longitude'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['openingTime'] = this.openingTime;
    data['closingTime'] = this.closingTime;
    data['address'] = this.address;
    data['banner'] = this.banner;
    data['s_id'] = this.sId;
    data['b_id'] = this.bId;
    data['fullname'] = this.fullname;
    data['email'] = this.email;
    data['email_verified'] = this.emailVerified;
    data['mobile_number'] = this.mobileNumber;
    data['otp_code'] = this.otpCode;
    data['service_status'] = this.serviceStatus;
    data['logo'] = this.logo;
    data['average_rating'] = this.averageRating;
    data['distance'] = this.distance;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    return data;
  }
}

class FeaturedGroceries {
  String? openingTime;
  String? closingTime;
  String? address;
  String? banner;
  String? sId;
  Null? bId;
  String? fullname;
  String? email;
  Null? emailVerified;
  int? mobileNumber;
  Null? otpCode;
  int? serviceStatus;
  String? logo;
  String? averageRating;
  double? distance;
  String? latitude;
  String? longitude;

  FeaturedGroceries(
      {
      this.openingTime,
      this.closingTime,
      this.address,
      this.banner,
      this.sId,
      this.bId,
      this.fullname,
      this.email,
      this.emailVerified,
      this.mobileNumber,
      this.otpCode,
      this.serviceStatus,
      this.logo,
      this.averageRating,
      this.distance,
      this.latitude,
      this.longitude});

  FeaturedGroceries.fromJson(Map<String, dynamic> json) {
    openingTime = json['openingTime'];
    closingTime = json['closingTime'];
    address = json['address'];
    banner = json['banner'];
    sId = json['s_id'];
    bId = json['b_id'];
    fullname = json['fullname'];
    email = json['email'];
    emailVerified = json['email_verified'];
    mobileNumber = json['mobile_number'];
    otpCode = json['otp_code'];
    serviceStatus = json['service_status'];
    logo = json['logo'];
    averageRating = json['average_rating'];
    distance = json['distance'];
    latitude = json['latitude'];
    longitude = json['longitude'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['openingTime'] = this.openingTime;
    data['closingTime'] = this.closingTime;
    data['address'] = this.address;
    data['banner'] = this.banner;
    data['s_id'] = this.sId;
    data['b_id'] = this.bId;
    data['fullname'] = this.fullname;
    data['email'] = this.email;
    data['email_verified'] = this.emailVerified;
    data['mobile_number'] = this.mobileNumber;
    data['otp_code'] = this.otpCode;
    data['service_status'] = this.serviceStatus;
    data['logo'] = this.logo;
    data['average_rating'] = this.averageRating;
    data['distance'] = this.distance;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    return data;
  }
}

class GroceriesTopPick {
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
  String? fullname;
  String? averageRating;
  double? distance;
  String? latitude;
  String? longitude;

  GroceriesTopPick(
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
      this.updatedAt,
      this.fullname,
      this.averageRating,
      this.distance,
      this.latitude,
      this.longitude});

  GroceriesTopPick.fromJson(Map<String, dynamic> json) {
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
    fullname = json['fullname'];
    averageRating = json['average_rating'];
    distance = json['distance'];
    latitude = json['latitude'];
    longitude = json['longitude'];
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
    data['fullname'] = this.fullname;
    data['average_rating'] = this.averageRating;
    data['distance'] = this.distance;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    return data;
  }
}
class RestaurantItemsTopPick{
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
  String? fullname;
  String? averageRating;
  double? distance;
  String? latitude;
  String? longitude;

  RestaurantItemsTopPick(
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
      this.updatedAt,
      this.fullname,
      this.averageRating,
      this.distance,
      this.latitude,
      this.longitude});

  RestaurantItemsTopPick.fromJson(Map<String, dynamic> json) {
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
    fullname = json['fullname'];
    averageRating = json['average_rating'];
    distance = json['distance'];
    latitude = json['latitude'];
    longitude = json['longitude'];
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
    data['fullname'] = this.fullname;
    data['average_rating'] = this.averageRating;
    data['distance'] = this.distance;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    return data;
  }
}
