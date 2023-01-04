import 'package:epoint_deal_plugin/common/lang_key.dart';
import 'package:epoint_deal_plugin/common/localization/app_localizations.dart';
import 'package:epoint_deal_plugin/model/response/order_source_model_response.dart';
import 'package:epoint_deal_plugin/utils/ultility.dart';
import 'package:epoint_deal_plugin/widget/custom_data_not_found.dart';
import 'package:epoint_deal_plugin/widget/custom_item_bottom_sheet.dart';
import 'package:epoint_deal_plugin/widget/custom_listview.dart';
import 'package:epoint_deal_plugin/widget/custom_menu_bottom_sheet.dart';
import 'package:flutter/material.dart';

class OrderSourcesModal extends StatefulWidget {
List<OrderSourceData> orderSourceData;
OrderSourceData orderSourceSelected;
   OrderSourcesModal({ Key key ,this.orderSourceData,this.orderSourceSelected}) ;

  @override
  _OrderSourcesModalState createState() => _OrderSourcesModalState();
}

class _OrderSourcesModalState extends State<OrderSourcesModal> {
 final ScrollController _controller = ScrollController();


@override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) { 
        OrderSourceData result = widget.orderSourceData.firstWhereOrNull((element) => element.orderSourceName == widget.orderSourceSelected?.orderSourceName);
      if (result != null) {
         widget.orderSourceSelected = result;
         result.selected = true;
      }
         setState(() {
           
         });
    });

  }
  @override
  Widget build(BuildContext context) {
    return CustomMenuBottomSheet(
      title: AppLocalizations.text(LangKey.orderSource),
      widget: (widget.orderSourceData.length > 0) ? CustomListView(
                    shrinkWrap: true,
                    padding: EdgeInsets.all(0.0),
                    children: (widget.orderSourceData ?? [])
                        .asMap()
                        .map((index, element) => MapEntry(
                        index,
                        CustomItemBottomSheet(
                          element?.orderSourceName ?? "",
                              () => selectedItem( index),
                          isBorder:
                          index < widget.orderSourceData.length - 1,
                          isSelected: element.selected,
                        )))
                        .values
                        .toList(),
                  ) : CustomDataNotFound(),
      haveBnConfirm: false,
      
    );
  }

  // List<Widget> _listWidget() {
  //   return (widget.orderSourceData != null) ? List.generate(
  //       widget.orderSourceData.length,
  //       (index) => _buildItem(
  //               widget.orderSourceData[index].orderSourceName, widget.orderSourceData[index].selected,
  //               () {
  //             selectedItem(index);
  //           })) : [CustomDataNotFound()];
  // }

  // Widget _buildItem(String title, bool selected, Function ontap) {
  //   return InkWell(
  //     onTap: ontap,
  //     child: Container(
  //       height: 40,
  //       child: Row(
  //         children: [
  //           Text(
  //             title,
  //             style: TextStyle(
  //                 fontSize: 17.0,
  //                 color: selected ? Colors.orange : Colors.black,
  //                 fontWeight: FontWeight.normal),
  //           )
  //         ],
  //       ),
  //     ),
  //   );
  // }

  selectedItem(int index) async {
    List<OrderSourceData> models = widget.orderSourceData;
    for (int i = 0; i < models.length; i++) {
      models[i].selected = false;
    }
    models[index].selected = true;
    setState(() {
      Navigator.of(context).pop(models[index]);
    });
  }
}