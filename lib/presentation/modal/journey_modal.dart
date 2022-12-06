import 'package:epoint_deal_plugin/common/lang_key.dart';
import 'package:epoint_deal_plugin/common/localization/app_localizations.dart';
import 'package:epoint_deal_plugin/model/response/journey_model_response.dart';
import 'package:epoint_deal_plugin/utils/ultility.dart';
import 'package:epoint_deal_plugin/widget/custom_data_not_found.dart';
import 'package:epoint_deal_plugin/widget/custom_listview.dart';
import 'package:flutter/material.dart';

class JourneyModal extends StatefulWidget {
  List<JourneyData> journeys = <JourneyData>[];
  JourneyData journeySelected;
 JourneyModal({ Key key , this.journeys, this.journeySelected});

  @override
  _JourneyModalState createState() => _JourneyModalState();
}

class _JourneyModalState extends State<JourneyModal> {
  final ScrollController _controller = ScrollController();

    @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) { 
        JourneyData result = widget.journeys.firstWhereOrNull((element) => element.journeyCode == widget.journeySelected?.journeyCode);
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
    return Container(
      padding: EdgeInsets.only(top: 10.0,bottom: 50),
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
              Container(width: 30),
              Text(AppLocalizations.text(LangKey.chooseItinerary),style: TextStyle(
                  fontSize: 18.0,
                  color: Colors.black,
                  fontWeight: FontWeight.w500),),
              InkWell(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: Padding(padding: EdgeInsets.only(right: 20),
                child: Icon(Icons.clear),
                ),
              ),
            
            ],
          ),
          Expanded(
            child: CustomListView(
                  shrinkWrap: true,
                  padding:
                      EdgeInsets.only(top: 16.0, bottom: 16.0, left: 8.0, right: 8.0),
                  physics: ClampingScrollPhysics(),
                  controller: _controller,
                  separator: Divider(),
                  children: _listWidget(),
                ),
          ),
        ],
      ),
    );
  }

  List<Widget> _listWidget() {
    return (widget.journeys != null) ? List.generate(
        widget.journeys.length,
        (index) => _buildItem(
                widget.journeys[index].journeyName, widget.journeys[index].selected,
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
    List<JourneyData> models = widget.journeys;
    for (int i = 0; i < models.length; i++) {
      models[i].selected = false;
    }
    models[index].selected = true;
    setState(() {
      Navigator.of(context).pop(models[index]);
    });
  }
}