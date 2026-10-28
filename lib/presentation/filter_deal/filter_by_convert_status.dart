import 'package:epoint_deal_plugin/common/theme.dart';
import 'package:epoint_deal_plugin/model/convert_status_model.dart';
import 'package:flutter/material.dart';

class FilterByConvertStatus extends StatefulWidget {
  List<ConvertStatusModel>? convertStatusOptions = <ConvertStatusModel>[];
 FilterByConvertStatus({ Key? key ,this.convertStatusOptions}) : super(key: key);

  @override
  _FilterByConvertStatusState createState() => _FilterByConvertStatusState();
}

class _FilterByConvertStatusState extends State<FilterByConvertStatus> {
  @override
  Widget build(BuildContext context) {
    return (widget.convertStatusOptions != null)
        ? Container(
            margin: EdgeInsets.only(top: 16.0, bottom: 16.0),
            child: Wrap(
              children: List.generate(
                  widget.convertStatusOptions!.length,
                  (index) => _optionItem(
                          widget.convertStatusOptions![index].statusName,
                          widget.convertStatusOptions![index].selected!, () {
                        selectedItem(index);
                      })),
              spacing: 10,
              runSpacing: 10,
            ),
          )
        : Container();
  }

  Widget _optionItem(String? name, bool selected, GestureTapCallback ontap) {
    return InkWell(
      onTap: ontap ,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          selected
              ? Container(
                  padding: EdgeInsets.only(left: 8.0, right: 8.0),
                  height: 40,
                  // width: 100,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(AppRadius.sm),
                      border: Border.all(
                          width: 1.0,
                          color: AppColors.primaryColor,
                          style: BorderStyle.solid)),
                  child: Center(
                    child: Text(
                      name!,
                      style: TextStyle(
                          color: AppColors.secondaryColor,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                )
              : Container(
                  padding: EdgeInsets.only(left: 8.0, right: 8.0),
                  height: 40,
                  // width: 100,
                  decoration: BoxDecoration(
                      color: AppColors.primaryColorMix,
                      borderRadius: BorderRadius.circular(AppRadius.sm)),
                  child: Center(
                    child: Text(
                      name!,
                      style: TextStyle(color: AppColors.textSecondaryColor),
                    ),
                  ),
                ),
        ],
      ),
    );
  }

  selectedItem(int index) async {
    List<ConvertStatusModel> models = widget.convertStatusOptions!;
    for (int i = 0; i < models.length; i++) {
      models[i].selected = false;
    }
    models[index].selected = true;
    setState(() {});
  }
}