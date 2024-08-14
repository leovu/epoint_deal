import 'package:epoint_deal_plugin/model/response/district_response_model.dart';
import 'package:epoint_deal_plugin/model/response/province_response_model.dart';
import 'package:epoint_deal_plugin/model/response/ward_response_model.dart';

class CustomerCreateAddressModel {
  ProvinceModel? provinceModel;
  DistrictModel? districtModel;
  WardModel? wardModel;
  String? street;

  CustomerCreateAddressModel(
      {this.provinceModel, this.districtModel, this.wardModel, this.street});
}
