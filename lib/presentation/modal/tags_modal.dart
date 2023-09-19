import 'package:epoint_deal_plugin/common/lang_key.dart';
import 'package:epoint_deal_plugin/common/localization/app_localizations.dart';
import 'package:epoint_deal_plugin/common/theme.dart';
import 'package:epoint_deal_plugin/model/response/get_tag_model_response.dart';
import 'package:epoint_deal_plugin/widget/custom_data_not_found.dart';
import 'package:epoint_deal_plugin/widget/custom_item_bottom_sheet.dart';
import 'package:epoint_deal_plugin/widget/custom_listview.dart';
import 'package:epoint_deal_plugin/widget/custom_menu_bottom_sheet.dart';
import 'package:flutter/material.dart';

class TagsModal extends StatefulWidget {
  List<TagData>? tagsData;
  TagsModal({Key? key, this.tagsData});

  @override
  _TagsModalState createState() => _TagsModalState();
}

class _TagsModalState extends State<TagsModal> {
  final ScrollController _controller = ScrollController();

  List<TagData>? tagsSelected;

  @override
  Widget build(BuildContext context) {
    return CustomMenuBottomSheet(
      title: AppLocalizations.text(LangKey.choooseTag),
      widget: (widget.tagsData!.length > 0) ? CustomListView(
                    shrinkWrap: true,
                    padding: EdgeInsets.all(0.0),
                    children: (widget.tagsData ?? [])
                        .asMap()
                        .map((index, element) => MapEntry(
                        index,
                        CustomItemBottomSheet(
                          element?.name ?? "",
                              () => selectedItem( element),
                          isBorder:
                          index < widget.tagsData!.length - 1,
                          isSelected: element.selected,
                          hideIconCheck: true,
                          iconChild: element.selected! ? Icon(Icons.check_box, color:AppColors.primaryColor ,) : Icon(Icons.check_box_outline_blank, color:Color.fromARGB(255, 108, 102, 94) ,),
                        )))
                        .values
                        .toList(),
                  ) : CustomDataNotFound(),
                  onTapConfirm: () {
                    Navigator.of(context).pop(widget.tagsData);
                  },
      haveBnConfirm: true,
      
    );
  }

  List<Widget> _listWidget() {
    return ( widget.tagsData != null) ? List.generate(
        widget.tagsData!.length,
        (index) => _buildItem(widget.tagsData![index].name!,
                widget.tagsData![index].selected!, () {
              selectedItem(widget.tagsData![index]);
            })):[CustomDataNotFound()];
  }

  Widget _buildItem(String title, bool selected, GestureTapCallback ontap) {
    return InkWell(
      onTap: ontap,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
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

          selected ? Icon(Icons.check_box, color:Colors.orange ,) : Icon(Icons.check_box_outline_blank, color:Color.fromARGB(255, 108, 102, 94) ,)
        ],
      ),
    );
  }

  selectedItem(TagData item) async {
    List<TagData> models = widget.tagsData!;
    var event = models.firstWhere((element) => element.name == item.name);  

    if (event != null) {
      event.selected = !event.selected!;
    }

    setState(() {
      widget.tagsData = models;
    });
  }
}
