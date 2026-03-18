import 'dart:math';
import 'dart:ui';

class BrandResponseModel {
  List<BrandModel>? data;

  BrandResponseModel({this.data});

  BrandResponseModel.fromJson(List<dynamic>? json) {
    if (json != null) {
      data = <BrandModel>[];
      json.forEach((v) {
        data!.add(new BrandModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['Data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class BrandModel {
  int? brandId;
  int? parentId;
  String? tenantId;
  String? brandName;
  String? brandCode;
  String? brandUrl;
  String? brandAvatar;
  String? brandBanner;
  String? brandAbout;
  String? brandContr;
  String? hotline;
  String? companyName;
  String? companyCode;
  int? position;
  String? displayName;
  int? isPublished;
  int? isActivated;
  int? isDeleted;
  String? createdAt;
  String? updatedAt;
  int? createdBy;
  int? updatedBy;
  int? isDemo;
  int? isUsed;
  String? snsFirebaseKey;
  String? snsP12;
  int? snsSuccess;
  String? brandS3Contr;
  String? brandApiUrl;
  String? brandNotiUrl;
  String? brandFavicon;
  String? clientKey;
  Color? color;

  BrandModel(
      {this.brandId,
      this.parentId,
      this.tenantId,
      this.brandName,
      this.brandCode,
      this.brandUrl,
      this.brandAvatar,
      this.brandBanner,
      this.brandAbout,
      this.brandContr,
      this.hotline,
      this.companyName,
      this.companyCode,
      this.position,
      this.displayName,
      this.isPublished,
      this.isActivated,
      this.isDeleted,
      this.createdAt,
      this.updatedAt,
      this.createdBy,
      this.updatedBy,
      this.isDemo,
      this.isUsed,
      this.snsFirebaseKey,
      this.snsP12,
      this.snsSuccess,
      this.brandS3Contr,
      this.brandApiUrl,
      this.brandNotiUrl,
      this.brandFavicon,
      this.clientKey,
      this.color});

  BrandModel.fromJson(Map<String, dynamic> json) {
    brandId = json['brand_id'];
    parentId = json['parent_id'];
    tenantId = json['tenant_id'];
    brandName = json['brand_name'];
    brandCode = json['brand_code'];
    brandUrl = json['brand_url'];
    brandAvatar = json['brand_avatar'];
    brandBanner = json['brand_banner'];
    brandAbout = json['brand_about'];
    brandContr = json['brand_contr'];
    hotline = json['hotline'];
    companyName = json['company_name'];
    companyCode = json['company_code'];
    position = json['position'];
    displayName = json['display_name'];
    isPublished = json['is_published'];
    isActivated = json['is_activated'];
    isDeleted = json['is_deleted'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    createdBy = json['created_by'];
    updatedBy = json['updated_by'];
    isDemo = json['is_demo'];
    isUsed = json['is_used'];
    snsFirebaseKey = json['sns_firebase_key'];
    snsP12 = json['sns_p12'];
    snsSuccess = json['sns_success'];
    brandS3Contr = json['brand_s3_contr'];
    brandApiUrl = json['brand_api_url'];
    brandNotiUrl = json['brand_noti_url'];
    brandFavicon = json['brand_favicon'];
    clientKey = json['client_key'];
    color = Color(Random().nextInt(0xffffffff))
        .withAlpha(0xff);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['brand_id'] = this.brandId;
    data['parent_id'] = this.parentId;
    data['tenant_id'] = this.tenantId;
    data['brand_name'] = this.brandName;
    data['brand_code'] = this.brandCode;
    data['brand_url'] = this.brandUrl;
    data['brand_avatar'] = this.brandAvatar;
    data['brand_banner'] = this.brandBanner;
    data['brand_about'] = this.brandAbout;
    data['brand_contr'] = this.brandContr;
    data['hotline'] = this.hotline;
    data['company_name'] = this.companyName;
    data['company_code'] = this.companyCode;
    data['position'] = this.position;
    data['display_name'] = this.displayName;
    data['is_published'] = this.isPublished;
    data['is_activated'] = this.isActivated;
    data['is_deleted'] = this.isDeleted;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['created_by'] = this.createdBy;
    data['updated_by'] = this.updatedBy;
    data['is_demo'] = this.isDemo;
    data['is_used'] = this.isUsed;
    data['sns_firebase_key'] = this.snsFirebaseKey;
    data['sns_p12'] = this.snsP12;
    data['sns_success'] = this.snsSuccess;
    data['brand_s3_contr'] = this.brandS3Contr;
    data['brand_api_url'] = this.brandApiUrl;
    data['brand_noti_url'] = this.brandNotiUrl;
    data['brand_favicon'] = this.brandFavicon;
    data['client_key'] = this.clientKey;
    return data;
  }
}
