class MemberDiscountResponseModel {
  String? discountMember;

  MemberDiscountResponseModel({this.discountMember});

  MemberDiscountResponseModel.fromJson(Map<String, dynamic> json) {
    discountMember = json['discount_member'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['discount_member'] = this.discountMember;
    return data;
  }
}
