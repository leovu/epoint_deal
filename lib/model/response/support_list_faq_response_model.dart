class SupportListFaqResponseModel {
  List<SupportFaqResponseModel>? data;

  SupportListFaqResponseModel({this.data});

  SupportListFaqResponseModel.fromJson(List<dynamic>? json) {
    if (json != null) {
      data = <SupportFaqResponseModel>[];
      json.forEach((v) {
        data!.add(new SupportFaqResponseModel.fromJson(v));
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

class SupportFaqResponseModel {
  int? faqId;
  String? faqTitleEn;
  String? faqTitleVi;
  String? faqContentEn;
  String? faqContentVi;

  SupportFaqResponseModel({this.faqId, this.faqTitleEn, this.faqTitleVi, this.faqContentEn, this.faqContentVi});

  SupportFaqResponseModel.fromJson(Map<String, dynamic> json) {
    faqId = json['faq_id'];
    faqTitleEn = json['faq_title_en'];
    faqTitleVi = json['faq_title_vi'];
    faqContentEn = json['faq_content_en'];
    faqContentVi = json['faq_content_vi'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['faq_id'] = this.faqId;
    data['faq_title_en'] = this.faqTitleEn;
    data['faq_title_vi'] = this.faqTitleVi;
    data['faq_content_en'] = this.faqContentEn;
    data['faq_content_vi'] = this.faqContentVi;
    return data;
  }
}
