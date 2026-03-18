import 'package:epoint_deal_plugin/network/api/api.dart';
import 'package:epoint_deal_plugin/network/api/interaction.dart';
import 'package:flutter/widgets.dart';

class ManageWorkResource { 


  workListDepartment(BuildContext? context) => Interaction(
      context: context,
      url: API.workListDepartment()
  ).post();

  
}