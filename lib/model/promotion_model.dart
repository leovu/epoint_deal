class PromotionModel {
  String price;
  String gift;

  PromotionModel({this.price, this.gift});

  PromotionModel.fromJson(Map<String, dynamic> json) {
    price = json['price'];
    gift = json['gift'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['price'] = this.price;
    data['gift'] = this.gift;
    return data;
  }
}