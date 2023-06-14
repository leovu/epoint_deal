import 'package:epoint_deal_plugin/model/response/get_tag_model_response.dart';

class DetailPotentialData {
  int? customerLeadId;
  String? customerLeadCode;
  String? fullName;
  String? phone;
  String? hotline;
  String? taxCode;
  int? customerSource;
  String? customerSourceName;
  String? customerType;
  String? pipelineCode;
  String? pipelineName;
  String? journeyCode;
  String? journeyName;
  String? email;
  String? gender;
  int? provinceId;
  String? provinceType;
  String? provinceName;
  int? districtId;
  String? districtType;
  String? districtName;
  int? wardId;
  String? wardType;
  String? wardName;
  String? address;
  String? zalo;
  String? fanpage;
  int? saleId;
  List<TagData>? tag;
  String? saleName;
  int? isConvert;
  String? representative;
  String? businessClue;
  String? businessClueName;
  int? bussinessId;
  String? businessName;
  int? employees;
  int? timeRevokeLead;
  String? dateRevoke;
  String? allocationDate;
  String? avatar;
  num? amount;
  String? dateLastCare;
  int? diffDay;
  int? relatedWork;
  int? appointment;
  String? birthday;
  String? position;

  DetailPotentialData(
      {this.customerLeadId,
      this.customerLeadCode,
      this.fullName,
      this.phone,
      this.hotline,
      this.taxCode,
      this.customerSource,
      this.customerSourceName,
      this.customerType,
      this.pipelineCode,
      this.pipelineName,
      this.journeyCode,
      this.journeyName,
      this.email,
      this.gender,
      this.provinceId,
      this.provinceType,
      this.provinceName,
      this.districtId,
      this.districtType,
      this.districtName,
      this.wardId,
      this.wardType,
      this.wardName,
      this.address,
      this.zalo,
      this.fanpage,
      this.saleId,
      this.tag,
      this.saleName,
      this.isConvert,
      this.representative,
      this.businessClue,
      this.businessClueName,
      this.bussinessId,
      this.businessName,
      this.employees,
      this.timeRevokeLead,
      this.dateRevoke,
      this.allocationDate,
      this.avatar,
      this.amount,
      this.dateLastCare,
      this.diffDay,
      this.relatedWork,
      this.appointment,
      this.birthday,
      this.position});

  DetailPotentialData.fromJson(Map<String, dynamic> json) {
    customerLeadId = json['customer_lead_id'];
    customerLeadCode = json['customer_lead_code'];
    fullName = json['full_name'];
    phone = json['phone'];
    hotline = json['hotline'];
    taxCode = json['tax_code'];
    customerSource = json['customer_source'];
    customerSourceName = json['customer_source_name'];
    customerType = json['customer_type'];
    pipelineCode = json['pipeline_code'];
    pipelineName = json['pipeline_name'];
    journeyCode = json['journey_code'];
    journeyName = json['journey_name'];
    email = json['email'];
    gender = json['gender'];
    provinceId = json['province_id'];
    provinceType = json['province_type'];
    provinceName = json['province_name'];
    districtId = json['district_id'];
    districtType = json['district_type'];
    districtName = json['district_name'];
    wardId = json['ward_id'];
    wardType = json['ward_type'];
    wardName = json['ward_name'];
    address = json['address'];
    zalo = json['zalo'];
    fanpage = json['fanpage'];
    saleId = json['sale_id'];
    if (json['tag'] != null) {
      tag = <TagData>[];
      json['tag'].forEach((v) {
        tag!.add(new TagData.fromJson(v));
      });
    }
    saleName = json['sale_name'];
    isConvert = json['is_convert'];
    representative = json['representative'];
    businessClue = json['business_clue'];
    businessClueName = json['business_clue_name'];
    bussinessId = json['bussiness_id'];
    businessName = json['business_name'];
    employees = json['employees'];
    timeRevokeLead = json['time_revoke_lead'];
    dateRevoke = json['date_revoke'];
    allocationDate = json['allocation_date'];
    avatar = json['avatar'];
    amount = json['amount'];
    dateLastCare = json['date_last_care'];
    diffDay = json['diff_day'];
    relatedWork = json['related_work'];
    appointment = json['appointment'];
    birthday = json['birthday'];
    position = json['position'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['customer_lead_id'] = this.customerLeadId;
    data['customer_lead_code'] = this.customerLeadCode;
    data['full_name'] = this.fullName;
    data['phone'] = this.phone;
    data['hotline'] = this.hotline;
    data['tax_code'] = this.taxCode;
    data['customer_source'] = this.customerSource;
    data['customer_source_name'] = this.customerSourceName;
    data['customer_type'] = this.customerType;
    data['pipeline_code'] = this.pipelineCode;
    data['pipeline_name'] = this.pipelineName;
    data['journey_code'] = this.journeyCode;
    data['journey_name'] = this.journeyName;
    data['email'] = this.email;
    data['gender'] = this.gender;
    data['province_id'] = this.provinceId;
    data['province_type'] = this.provinceType;
    data['province_name'] = this.provinceName;
    data['district_id'] = this.districtId;
    data['district_type'] = this.districtType;
    data['district_name'] = this.districtName;
    data['ward_id'] = this.wardId;
    data['ward_type'] = this.wardType;
    data['ward_name'] = this.wardName;
    data['address'] = this.address;
    data['zalo'] = this.zalo;
    data['fanpage'] = this.fanpage;
    data['sale_id'] = this.saleId;
    data['tag'] = this.tag;
    data['sale_name'] = this.saleName;
    data['is_convert'] = this.isConvert;
    data['representative'] = this.representative;
    data['business_clue'] = this.businessClue;
    data['business_clue_name'] = this.businessClueName;
    data['bussiness_id'] = this.bussinessId;
    data['business_name'] = this.businessName;
    data['employees'] = this.employees;
    data['time_revoke_lead'] = this.timeRevokeLead;
    data['date_revoke'] = this.dateRevoke;
    data['allocation_date'] = this.allocationDate;
    data['avatar'] = this.avatar;
    data['amount'] = this.amount;
    data['date_last_care'] = this.dateLastCare;
    data['diff_day'] = this.diffDay;
    data['related_work'] = this.relatedWork;
    data['appointment '] = this.appointment;
    data['birthday '] = this.birthday;
    data['position '] = this.position;
    return data;
  }
}