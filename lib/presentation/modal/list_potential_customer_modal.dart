import 'package:epoint_deal_plugin/common/lang_key.dart';
import 'package:epoint_deal_plugin/common/localization/app_localizations.dart';
import 'package:epoint_deal_plugin/common/theme.dart';
import 'package:epoint_deal_plugin/connection/deal_connection.dart';
import 'package:epoint_deal_plugin/model/request/list_customer_lead_model_request.dart';
import 'package:epoint_deal_plugin/model/response/list_customer_lead_model_response.dart';
import 'package:epoint_deal_plugin/presentation/detail_deal/allocator_screen.dart';
import 'package:epoint_deal_plugin/utils/ultility.dart';
import 'package:epoint_deal_plugin/widget/custom_data_not_found.dart';
import 'package:epoint_deal_plugin/widget/custom_listview.dart';
import 'package:epoint_deal_plugin/widget/custom_shimer.dart';
import 'package:epoint_deal_plugin/widget/custom_skeleton.dart';
import 'package:flutter/material.dart';

class ListCustomerPotentialModal extends StatefulWidget {
  List<ListCustomLeadItems> items = <ListCustomLeadItems>[];
  ListCustomLeadItems leadItem;

 ListCustomerPotentialModal({ Key key, this.items ,this.leadItem});

  @override
  _ListCustomerPotentialModalState createState() => _ListCustomerPotentialModalState();
}

class _ListCustomerPotentialModalState extends State<ListCustomerPotentialModal> {
  final ScrollController _controller = ScrollController();
  final TextEditingController _searchext = TextEditingController();
  final FocusNode _fonusNode = FocusNode();

ListCustomLeadData _model ;

  ListCustomLeadModelRequest filterModel = ListCustomLeadModelRequest(
      search: "",
          page: 1,
          statusAssign: "",
          customerType: "",
          tagId: [],
          customerSourceId: [],
          staffId: [],
          pipelineId: [],
          journeyId: [],
          careHistory: "",
          isConvert: "",
          createdAt: "",
          allocationDate: "",

      );

  int currentPage = 1;
  int nextPage = 2;

  @override
  void initState() {
    super.initState();
    _controller.addListener(_scrollListener);
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      getData(false);
    });
  }

  _scrollListener() async {
    if (_controller.offset >= _controller.position.maxScrollExtent &&
        !_controller.position.outOfRange) {
      if (this.currentPage < this.nextPage) {
        filterModel.page = currentPage + 1;
        getData(true);
      }
    }
  }

  @override
  void dispose() {
    _controller.removeListener(() {});
    super.dispose();
  }

  getData(bool loadMore, {int page}) async {
    keyboardDismissOnTap(context);
    FocusScope.of(context).unfocus();
    ListCustomLeadModelReponse model = await DealConnection.getListPotentialCustomer(
        context,
        ListCustomLeadModelRequest(
            search: _searchext.text,
            page: filterModel.page,
            statusAssign: "",
          customerType: "",
          tagId: [],
          customerSourceId: [],
          staffId: [],
          pipelineId: [],
          journeyId: [],
          careHistory: "",
          isConvert: "",
          createdAt: "",
          allocationDate: "",));
    if (model != null) {
      if (!loadMore) {
        widget.items = [];
        widget.items = model.data?.items;
        // ignore: null_aware_before_operator
        (model.data?.items?.length > 0) ??
            _controller.animateTo(
              _controller.position.minScrollExtent,
              duration: Duration(seconds: 2),
              curve: Curves.fastOutSlowIn,
            );
      } else {
        widget.items.addAll(model.data?.items);
      }


      for (int i = 0; i < widget.items.length ; i++) {
        if ((widget.leadItem?.customerLeadCode ?? "") == widget.items[i].customerLeadCode ) {
          widget.items[i].selected = true;
        } else {
          widget.items[i].selected = false;
        }
      }

      _model = ListCustomLeadData(
        items: (widget.items ?? <ListCustomLeadItems>[])
            .map((e) => ListCustomLeadItems.fromJson(e.toJson()))
            .toList());



      currentPage = model.data?.pageInfo?.currentPage;
      nextPage = model.data?.pageInfo?.nextPage;
      setState(() {});
    } else {
      widget.items = [];
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          iconTheme: const IconThemeData(
            color: Colors.white,
          ),
          backgroundColor: Color(0xFF0067AC),
          title: Text(
            AppLocalizations.text(LangKey.listLead),
            style: const TextStyle(color: Colors.white, fontSize: 18.0),
          ),
          // leadingWidth: 20.0,
        ),
        body: Container(
            decoration: const BoxDecoration(color: Colors.white),
            child: _buildBody()));
  }

  Widget _buildBody() {
    return Container(
      padding: EdgeInsets.only(top: 16.0, bottom: 16.0, left: 8.0, right: 8.0),
      child: Column(
        children: [
          _buildSearch(),
          (widget.items != null)
              ? Expanded(
                  child: CustomListView(
                  shrinkWrap: true,
                  padding: EdgeInsets.only(
                      top: 16.0, bottom: 16.0, left: 8.0, right: 8.0),
                  physics: AlwaysScrollableScrollPhysics(),
                  controller: _controller,
                  separator: Divider(),
                  children: _listWidget(),
                ))
              : Container(),
          Container(
            height: 20.0,
          )
        ],
      ),
    );
  }

  List<Widget> _listWidget() {
    return (_model?.items != null && _model.items.length > 0) ? List.generate(
        _model.items.length,
        (index) => _buildItemStaff(_model.items[index], () {
              selectedStaff(index);
            })) : [Container()];
  }

   Widget dataNotFound() {
    return CustomListView(
                      shrinkWrap: true,
                      padding: EdgeInsets.only(
                          top: 16.0, bottom: 16.0, left: 8.0, right: 8.0),
                      physics: NeverScrollableScrollPhysics(),
                      separator: Divider(),
                      children: List.generate(
                        5,
                        (index) => Container(
                  margin: EdgeInsets.only(top: 15.0),
                  child: CustomShimmer(
                    child: CustomSkeleton(
          height: 50,
          radius: 5.0),
                  ),
                ),
            ));
  }

  selectedStaff(int index) async {
    List<ListCustomLeadItems> models = _model.items;
    for (int i = 0; i < models.length; i++) {
      models[i].selected = false;
    }
    models[index].selected = true;
    setState(() {
      Navigator.of(context).pop(models[index]);
    });
  }

  Widget _buildItemStaff(ListCustomLeadItems item, Function ontap) {
    return InkWell(
      onTap: ontap,
      child: Container(
        height: 40,
        decoration: BoxDecoration(color: Colors.white),
        child: Row(
          children: [
            Expanded(
              child: Container(
                padding: const EdgeInsets.only(left: 8.0),
                child: Text(
                  item.leadFullName,
                  style: TextStyle(
                      fontSize: 16.0,
                      color: item.selected ? AppColors.primaryColor : Colors.black,
                      fontWeight: FontWeight.normal),
                  maxLines: 1,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSearch() {
    return TextField(
      enabled: true,
      controller: _searchext,
      focusNode: _fonusNode,
      // focusNode: _focusNode,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        isCollapsed: true,
        contentPadding: EdgeInsets.all(12.0),
        border: OutlineInputBorder(
          // borderSide:
          //     BorderSide(width: 1, color: Color.fromARGB(255, 21, 230, 129)),
          borderRadius: BorderRadius.circular(10.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(width: 1, color: Color(0xFFB8BFC9)),
        ),
        // hintText: AppLocalizations.text(LangKey.filterNameCodePhone),
        hintText: AppLocalizations.text(LangKey.inputSearch),
        isDense: true,
      ),
      onChanged: (event) {
        searchModel(widget.items,event);
        print(event.toLowerCase());
        if (_searchext != null) {
          print(_searchext.text);
          
        }
      },
    );
  }

   searchModel(List<ListCustomLeadItems> model, String value) {
    if (model == null || value.isEmpty) {
      _model.items = widget.items;
      setState(() {
      });
    } else {
      try {
        List<ListCustomLeadItems> models = model.where((model) {
          List<String> search = value.removeAccents().split(" ");
          bool result = true;
          for (String element in search) {
            if (!((model.leadFullName ?? "").removeAccents().contains(element))) {
              result = false;
              break;
            }
          }
          return result;
        }).toList();
        _model.items = models;
        setState(() {
      });
      } catch (_) {
        setState(() {
        
      });
      }
    }
  }
}
