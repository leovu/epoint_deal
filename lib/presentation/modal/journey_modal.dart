import 'package:epoint_deal_plugin/common/lang_key.dart';
import 'package:epoint_deal_plugin/common/localization/app_localizations.dart';
import 'package:epoint_deal_plugin/model/response/journey_model_response.dart';
import 'package:epoint_deal_plugin/utils/ultility.dart';
import 'package:epoint_deal_plugin/widget/custom_data_not_found.dart';
import 'package:epoint_deal_plugin/widget/custom_item_bottom_sheet.dart';
import 'package:epoint_deal_plugin/widget/custom_listview.dart';
import 'package:epoint_deal_plugin/widget/custom_menu_bottom_sheet.dart';
import 'package:flutter/material.dart';

class JourneyModal extends StatefulWidget {
  List<JourneyData>? journeys = <JourneyData>[];
  JourneyData? journeySelected;
 JourneyModal({ Key? key , this.journeys, this.journeySelected});

  @override
  _JourneyModalState createState() => _JourneyModalState();
}

class _JourneyModalState extends State<JourneyModal> {
  final ScrollController _controller = ScrollController();

    @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) { 
        JourneyData? result = widget.journeys!.firstWhereOrNull((element) => element.journeyCode == widget.journeySelected?.journeyCode);
      if (result != null) {
         widget.journeySelected = result;
         result.selected = true;
      }
         setState(() {
           
         });
    });
  }

  @override
  Widget build(BuildContext context) {
    return  CustomMenuBottomSheet(
      title: AppLocalizations.text(LangKey.chooseItinerary),
      widget: (widget.journeys!.length > 0) ? CustomListView(
                    shrinkWrap: true,
                    padding: EdgeInsets.all(0.0),
                    children: (widget.journeys ?? [])
                        .asMap()
                        .map((index, element) => MapEntry(
                        index,
                        CustomItemBottomSheet(
                          element?.journeyName ?? "",
                              () => selectedItem( index),
                          isBorder:
                          index < widget.journeys!.length - 1,
                          isSelected: element.selected,
                        )))
                        .values
                        .toList(),
                  ) : CustomDataNotFound(),
      haveBnConfirm: false,
      
    );
  }

  // List<Widget> _listWidget() {
  //   return (widget.journeys != null) ? List.generate(
  //       widget.journeys.length,
  //       (index) => _buildItem(
  //               widget.journeys[index].journeyName, widget.journeys[index].selected,
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
    List<JourneyData> models = widget.journeys!;
    for (int i = 0; i < models.length; i++) {
      models[i].selected = false;
    }
    models[index].selected = true;
    setState(() {
      Navigator.of(context).pop(models[index]);
    });
  }
}