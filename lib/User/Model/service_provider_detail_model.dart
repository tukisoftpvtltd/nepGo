class ServiceProviderDetailModel {
  String? status;
  List<ServiceProvider>? serviceProvider;
  List<ServiceProviderDetails>? serviceProviderDetails;
  List<ServiceProviderItemsWithCategories>? serviceProviderItemsWithCategories;
  List<ServiceProviderReviews>? serviceProviderReviews;
  List<Favrouite>? favrouite;
  String? serviceProviderId;
  Map<String, dynamic>? itemsPurchaseOrNot;

  ServiceProviderDetailModel(
      {this.status,
      this.serviceProvider,
      this.serviceProviderDetails,
      this.serviceProviderItemsWithCategories,
      this.serviceProviderReviews,
      this.favrouite,
      this.serviceProviderId,
      this.itemsPurchaseOrNot});

  ServiceProviderDetailModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['serviceProvider'] != null) {
      serviceProvider = <ServiceProvider>[];
      json['serviceProvider'].forEach((v) {
        serviceProvider!.add(new ServiceProvider.fromJson(v));
      });
    }
    if (json['serviceProviderDetails'] != null) {
      serviceProviderDetails = <ServiceProviderDetails>[];
      json['serviceProviderDetails'].forEach((v) {
        serviceProviderDetails!.add(new ServiceProviderDetails.fromJson(v));
      });
    }
    if (json['serviceProviderItemsWithCategories'] != null) {
      serviceProviderItemsWithCategories =
          <ServiceProviderItemsWithCategories>[];
      json['serviceProviderItemsWithCategories'].forEach((v) {
        serviceProviderItemsWithCategories!
            .add(new ServiceProviderItemsWithCategories.fromJson(v));
      });
    }
    if (json['serviceProviderReviews'] != null) {
      serviceProviderReviews = <ServiceProviderReviews>[];
      json['serviceProviderReviews'].forEach((v) {
        serviceProviderReviews!.add(new ServiceProviderReviews.fromJson(v));
      });
    }
    if (json['favrouite'] != null) {
      favrouite = <Favrouite>[];
      json['favrouite'].forEach((v) {
        favrouite!.add(new Favrouite.fromJson(v));
      });
    }
    serviceProviderId = json['service_provider_id'];
    itemsPurchaseOrNot = json['itemsPurchaseOrNot'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.serviceProvider != null) {
      data['serviceProvider'] =
          this.serviceProvider!.map((v) => v.toJson()).toList();
    }
    if (this.serviceProviderDetails != null) {
      data['serviceProviderDetails'] =
          this.serviceProviderDetails!.map((v) => v.toJson()).toList();
    }
    if (this.serviceProviderItemsWithCategories != null) {
      data['serviceProviderItemsWithCategories'] = this
          .serviceProviderItemsWithCategories!
          .map((v) => v.toJson())
          .toList();
    }
    if (this.serviceProviderReviews != null) {
      data['serviceProviderReviews'] =
          this.serviceProviderReviews!.map((v) => v.toJson()).toList();
    }
    if (this.favrouite != null) {
      data['favrouite'] = this.favrouite!.map((v) => v.toJson()).toList();
    }
    data['service_provider_id'] = this.serviceProviderId;
    data['itemsPurchaseOrNot'] = this.itemsPurchaseOrNot;
    return data;
  }
}

class ServiceProvider {
  String? fullname;
  String? email;
  int? serviceStatus;
  String? logo;
  String? averageRating;

  ServiceProvider(
      {this.fullname,
      this.email,
      this.serviceStatus,
      this.logo,
      this.averageRating});

  ServiceProvider.fromJson(Map<String, dynamic> json) {
    fullname = json['fullname'];
    email = json['email'];
    serviceStatus = json['service_status'];
    logo = json['logo'];
    averageRating = json['average_rating'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['fullname'] = this.fullname;
    data['email'] = this.email;
    data['service_status'] = this.serviceStatus;
    data['logo'] = this.logo;
    data['average_rating'] = this.averageRating;
    return data;
  }
}

class ServiceProviderDetails {
  String? sId;
  String? address;
  Null? contactUs;
  String? website;
  String? googleMapLocation;
  String? description;
  String? city;
  String? longitude;
  String? latitude;
  String? banner;
  int? isDeleted;
  String? openingTime;
  String? closingTime;
  String? createdAt;
  String? updatedAt;

  ServiceProviderDetails(
      {this.sId,
      this.address,
      this.contactUs,
      this.website,
      this.googleMapLocation,
      this.description,
      this.city,
      this.longitude,
      this.latitude,
      this.banner,
      this.isDeleted,
      this.openingTime,
      this.closingTime,
      this.createdAt,
      this.updatedAt});

  ServiceProviderDetails.fromJson(Map<String, dynamic> json) {
    sId = json['s_id'];
    address = json['address'];
    contactUs = json['contact_us'];
    website = json['website'];
    googleMapLocation = json['google_map_location'];
    description = json['description'];
    city = json['city'];
    longitude = json['longitude'];
    latitude = json['latitude'];
    banner = json['banner'];
    isDeleted = json['is_deleted'];
    openingTime = json['openingTime'];
    closingTime = json['closingTime'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['s_id'] = this.sId;
    data['address'] = this.address;
    data['contact_us'] = this.contactUs;
    data['website'] = this.website;
    data['google_map_location'] = this.googleMapLocation;
    data['description'] = this.description;
    data['city'] = this.city;
    data['longitude'] = this.longitude;
    data['latitude'] = this.latitude;
    data['banner'] = this.banner;
    data['is_deleted'] = this.isDeleted;
    data['openingTime'] = this.openingTime;
    data['closingTime'] = this.closingTime;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
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
    data['id'] = this.id;
    data['cat_name'] = this.catName;
    data['status'] = this.status;
    data['s_id'] = this.sId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.catItems != null) {
      data['Cat_Items'] = this.catItems!.map((v) => v.toJson()).toList();
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
  Null? vatable;
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

class ServiceProviderReviews {
  int? id;
  String? sId;
  String? reviews;
  String? userId;
  int? star;
  int? accept;
  String? title;
  String? createdAt;
  String? updatedAt;
  String? fname;
  String? lname;

  ServiceProviderReviews(
      {this.id,
      this.sId,
      this.reviews,
      this.userId,
      this.star,
      this.accept,
      this.title,
      this.createdAt,
      this.updatedAt,
      this.fname,
      this.lname});

  ServiceProviderReviews.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    sId = json['s_id'];
    reviews = json['reviews'];
    userId = json['user_id'];
    star = json['star'];
    accept = json['accept'];
    title = json['title'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    fname = json['fname'];
    lname = json['lname'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['s_id'] = this.sId;
    data['reviews'] = this.reviews;
    data['user_id'] = this.userId;
    data['star'] = this.star;
    data['accept'] = this.accept;
    data['title'] = this.title;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['fname'] = this.fname;
    data['lname'] = this.lname;
    return data;
  }
}

class Favrouite {
  int? userId;
  String? sId;

  Favrouite({this.userId, this.sId});

  Favrouite.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    sId = json['s_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_id'] = this.userId;
    data['s_id'] = this.sId;
    return data;
  }
}
class ItemsPurchaseOrNot{
   String? sId;
   ItemsPurchaseOrNot({this.sId});

  ItemsPurchaseOrNot.fromJson(Map<String, dynamic> json) {
    sId = json['s_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['s_id'] = this.sId;
    return data;
  }

}