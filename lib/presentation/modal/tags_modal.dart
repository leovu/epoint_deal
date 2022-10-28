import 'package:epoint_deal_plugin/common/lang_key.dart';
import 'package:epoint_deal_plugin/common/localization/app_localizations.dart';
import 'package:epoint_deal_plugin/model/response/get_tag_model_response.dart';
import 'package:epoint_deal_plugin/widget/custom_button.dart';
import 'package:epoint_deal_plugin/widget/custom_listview.dart';
import 'package:flutter/material.dart';

class TagsModal extends StatefulWidget {
  List<TagData> tagsData;
  TagsModal({Key key, this.tagsData});

  @override
  _TagsModalState createState() => _TagsModalState();
}

class _TagsModalState extends State<TagsModal> {
  final ScrollController _controller = ScrollController();

  List<TagData> tagsSelected;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 10.0, bottom: 50),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10), topRight: Radius.circular(10))),
      height: MediaQuery.of(context).size.height * 0.8,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(),
              Text(
                "Tag",
                style: TextStyle(
                    fontSize: 18.0,
                    color: Colors.black,
                    fontWeight: FontWeight.w400),
              ),
              InkWell(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: Padding(
                  padding: EdgeInsets.only(right: 20),
                  child: Icon(Icons.clear),
                ),
              ),
            ],
          ),
          Expanded(
            child: CustomListView(
              shrinkWrap: true,
              padding: EdgeInsets.only(
                  top: 16.0, bottom: 16.0, left: 8.0, right: 8.0),
              physics: ClampingScrollPhysics(),
              controller: _controller,
              separator: Divider(),
              children: _listWidget(),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8.0,right: 8.0),
            child: CustomButton(
              text: AppLocalizations.text(LangKey.confirm),
              enable: true,
              onTap: () {
                Navigator.of(context).pop(widget.tagsData);
              },
            ),
          )
        ],
      ),
    );
  }

  List<Widget> _listWidget() {
    return List.generate(
        widget.tagsData.length,
        (index) => _buildItem(widget.tagsData[index].name,
                widget.tagsData[index].selected, () {
              selectedItem(widget.tagsData[index]);
            }));
  }

  Widget _buildItem(String title, bool selected, Function ontap) {
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
                      fontSize: 18.0,
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
    List<TagData> models = widget.tagsData;
    var event = models.firstWhere((element) => element.name == item.name);  

    if (event != null) {
      event.selected = !event.selected;
    }

    setState(() {
      widget.tagsData = models;
    });
  }
}
