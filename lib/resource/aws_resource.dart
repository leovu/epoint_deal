import 'package:epoint_deal_plugin/network/api/aws_interaction.dart';
import 'package:epoint_deal_plugin/network/http/aws_connection.dart';
import 'package:flutter/material.dart';

class AWSResource{
  upload(BuildContext? context, AWSFileModel model, bool showError) => AWSInteraction(
      context: context,
      file: model,
      showError: showError
  ).upload();
}