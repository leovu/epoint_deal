

import 'package:epoint_deal_plugin/model/response/voucher_response_model.dart';

class DiscountCartModel {
  double? amount;
  int? percent;
  CheckVoucherResponseModel? model;

  DiscountCartModel({this.amount, this.percent, this.model});
}