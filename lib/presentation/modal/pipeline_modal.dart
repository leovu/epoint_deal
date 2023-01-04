import 'package:epoint_deal_plugin/common/lang_key.dart';
import 'package:epoint_deal_plugin/common/localization/app_localizations.dart';
import 'package:epoint_deal_plugin/model/response/pipeline_model_response.dart';
import 'package:epoint_deal_plugin/utils/ultility.dart';
import 'package:epoint_deal_plugin/widget/custom_data_not_found.dart';
import 'package:epoint_deal_plugin/widget/custom_item_bottom_sheet.dart';
import 'package:epoint_deal_plugin/widget/custom_listview.dart';
import 'package:epoint_deal_plugin/widget/custom_menu_bottom_sheet.dart';
import 'package:flutter/material.dart';

class PipelineModal extends StatefulWidget {
  List<PipelineData> pipeLineData = <PipelineData>[];
  PipelineData pipelineSelected;
 PipelineModal({ Key key, this.pipeLineData, this.pipelineSelected });

  @override
  _PipelineModalState createState() => _PipelineModalState();
}

class _PipelineModalState extends State<PipelineModal> {
  final ScrollController _controller = ScrollController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) { 
        PipelineData result = widget.pipeLineData.firstWhereOrNull((element) => element.pipelineCode == widget.pipelineSelected?.pipelineCode);
      if (result != null) {
         widget.pipelineSelected = result;
         result.selected = true;
      }
         setState(() {
           
         });
    });

  }

  @override
  Widget build(BuildContext context) {
    return CustomMenuBottomSheet(
      title: AppLocalizations.text(LangKey.choosePipeline),
      widget: (widget.pipeLineData.length > 0) ? CustomListView(
                    shrinkWrap: true,
                    padding: EdgeInsets.all(0.0),
                    children: (widget.pipeLineData ?? [])
                        .asMap()
                        .map((index, element) => MapEntry(
                        index,
                        CustomItemBottomSheet(
                          element?.pipelineName ?? "",
                              () => selectedItem( index),
                          isBorder:
                          index < widget.pipeLineData.length - 1,
                          isSelected: element.selected,
                        )))
                        .values
                        .toList(),
                  ) : CustomDataNotFound(),
      haveBnConfirm: false,
      
    );
  }

  List<Widget> _listWidget() {
    return (widget.pipeLineData != null) ? List.generate(
        widget.pipeLineData.length,
        (index) => _buildItem(
                widget.pipeLineData[index].pipelineName, widget.pipeLineData[index].selected,
                () {
              selectedItem(index);
            })) : [CustomDataNotFound()];
  }

  Widget _buildItem(String title, bool selected, Function ontap) {
    return InkWell(
      onTap: ontap,
      child: Container(
        height: 40,
        child: Row(
          children: [
            Text(
              title,
              style: TextStyle(
                  fontSize: 17.0,
                  color: selected ? Colors.orange : Colors.black,
                  fontWeight: FontWeight.normal),
            )
          ],
        ),
      ),
    );
  }

  selectedItem(int index) async {
    List<PipelineData> models = widget.pipeLineData;
    for (int i = 0; i < models.length; i++) {
      models[i].selected = false;
    }
    models[index].selected = true;
    setState(() {
      Navigator.of(context).pop(models[index]);
    });
  }
}