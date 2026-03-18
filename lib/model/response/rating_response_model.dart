class RatingResponseModel {
  int? totalRating;
  double? avgRating;
  int? rating1;
  int? rating2;
  int? rating3;
  int? rating4;
  int? rating5;
  List<ModelRating>? ratings;

  RatingResponseModel(
      {this.totalRating,
        this.avgRating,
        this.rating1,
        this.rating2,
        this.rating3,
        this.rating4,
        this.rating5,
        this.ratings});

  RatingResponseModel.fromJson(Map<String, dynamic> json) {
    totalRating = json['total_rating'];
    avgRating = json['avg_rating'] == null? null: double.tryParse(json['avg_rating'].toString());
    rating1 = json['rating_1'];
    rating2 = json['rating_2'];
    rating3 = json['rating_3'];
    rating4 = json['rating_4'];
    rating5 = json['rating_5'];
    if (json['ratings'] != null) {
      ratings = [];
      json['ratings'].forEach((v) {
        ratings!.add(new ModelRating.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total_rating'] = this.totalRating;
    data['avg_rating'] = this.avgRating;
    data['rating_1'] = this.rating1;
    data['rating_2'] = this.rating2;
    data['rating_3'] = this.rating3;
    data['rating_4'] = this.rating4;
    data['rating_5'] = this.rating5;
    if (this.ratings != null) {
      data['ratings'] = this.ratings!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ModelRating {
  int? id;
  String? object;
  String? objectValue;
  int? ratingBy;
  double? ratingValue;
  String? comment;
  String? createdAt;
  String? updatedAt;
  String? fullName;
  bool? isExpanded;

  ModelRating(
      {this.id,
        this.object,
        this.objectValue,
        this.ratingBy,
        this.ratingValue,
        this.comment,
        this.createdAt,
        this.updatedAt,
        this.fullName});

  ModelRating.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    object = json['object'];
    objectValue = json['object_value'];
    ratingBy = json['rating_by'];
    ratingValue = json['rating_value'] == null? null: double.tryParse(json['rating_value'].toString());
    comment = json['comment'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    fullName = json['full_name'];
    isExpanded = false;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['object'] = this.object;
    data['object_value'] = this.objectValue;
    data['rating_by'] = this.ratingBy;
    data['rating_value'] = this.ratingValue;
    data['comment'] = this.comment;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['full_name'] = this.fullName;
    return data;
  }
}