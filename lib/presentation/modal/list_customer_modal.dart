import 'package:epoint_deal_plugin/common/lang_key.dart';
import 'package:epoint_deal_plugin/common/localization/app_localizations.dart';
import 'package:epoint_deal_plugin/common/theme.dart';
import 'package:epoint_deal_plugin/connection/deal_connection.dart';
import 'package:epoint_deal_plugin/model/response/get_customer_model_response.dart';
import 'package:epoint_deal_plugin/model/response/list_deal_model_reponse.dart';
import 'package:epoint_deal_plugin/utils/ultility.dart';
import 'package:epoint_deal_plugin/widget/custom_data_not_found.dart';
import 'package:epoint_deal_plugin/widget/custom_listview.dart';
import 'package:epoint_deal_plugin/widget/custom_shimer.dart';
import 'package:epoint_deal_plugin/widget/custom_skeleton.dart';
import 'package:flutter/material.dart';

class ListCustomerModal extends StatefulWidget {
  DealItems? dealItem = DealItems();
  List<CustomerData>? listCustomer = <CustomerData>[];

  ListCustomerModal({Key? key, this.dealItem, this.listCustomer});

  @override
  _ListCustomerModalState createState() => _ListCustomerModalState();
}

class _ListCustomerModalState extends State<ListCustomerModal> {
  final ScrollController _controller = ScrollController();
  final TextEditingController _searchext = TextEditingController();
  final FocusNode _fonusNode = FocusNode();

  GetCustomerModelResponse? _model;
  int? indexSelected;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      getData(false);
    });
  }

  @override
  void dispose() {
    _controller.removeListener(() {});
    super.dispose();
  }

  getData(bool loadMore, {int? page}) async {
    keyboardDismissOnTap(context);
    FocusScope.of(context).unfocus();
    GetCustomerModelResponse? model = await DealConnection.getCustomer(context);
    if (model != null) {
      widget.listCustomer = model.data;

      _model = GetCustomerModelResponse(
          data: (widget.listCustomer ?? <CustomerData>[])
              .map((e) => CustomerData.fromJson(e.toJson()))
              .toList());

      for (int i = 0; i < _model!.data!.length; i++) {
        if ((widget.dealItem?.customerCode ?? "") ==
            _model!.data![i].customerCode) {
          widget.listCustomer![i].selected = true;
          _model!.data![i].selected = true;
        } else {
          widget.listCustomer![i].selected = false;
          _model!.data![i].selected = false;
        }
      }

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
            AppLocalizations.text(LangKey.listCustomer)!,
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
          (widget.listCustomer != null)
              ? (widget.listCustomer!.length > 0)
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
                  : Container()
              : Container(),
          Container(
            height: 20.0,
          ),
        ],
      ),
    );
  }

  List<Widget> _listWidget() {
    return (_model?.data != null && (_model?.data!.length ?? 0) > 0)
        ? List.generate(
            _model!.data!.length,
            (index) => _buildItemStaff(_model!.data![index], () {
                  selectedCustomer(index);
                }))
        : [CustomDataNotFound()];
  }

  selectedCustomer(int index) async {
    List<CustomerData> models = _model!.data!;
    for (int i = 0; i < models.length; i++) {
      models[i].selected = false;
    }
    models[index].selected = true;

    indexSelected = index;
    setState(() {
      Navigator.of(context).pop(models[index]);
    });
  }

  Widget _buildItemStaff(CustomerData item, Function ontap) {
    return InkWell(
      onTap: ontap as void Function()?,
      child: Container(
        height: 40,
        decoration: BoxDecoration(color: Colors.white),
        child: Row(
          children: [
            Expanded(
              child: Container(
                padding: const EdgeInsets.only(left: 8.0),
                child: Text(
                  item?.fullName ?? "",
                  style: TextStyle(
                      fontSize: 16.0,
                      color:
                          item.selected! ? AppColors.primaryColor : Colors.black,
                      fontWeight:item.selected! ? FontWeight.bold : FontWeight.normal),
                  maxLines: 1,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget dataNotFound() {
    return Expanded(
      child: CustomListView(
                        shrinkWrap: true,
                        padding: EdgeInsets.only(
                            top: 16.0, bottom: 16.0, left: 8.0, right: 8.0),
                        physics: NeverScrollableScrollPhysics(),
                        separator: Divider(),
                        children: List.generate(
                          12,
                          (index) => Container(
                    margin: EdgeInsets.only(top: 15.0),
                    child: CustomShimmer(
                      child: CustomSkeleton(
            height: 35,
            radius: 5.0),
                    ),
                  ),
              )),
    );
  }

  Widget _buildSearch() {
    return TextField(
      enabled: true,
      controller: _searchext,
      focusNode: _fonusNode,
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
        searchModel(_model!.data, event);
        print(event.toLowerCase());
        if (_searchext != null) {
          print(_searchext.text);
        }
      },
    );
  }

  searchModel(List<CustomerData>? model, String value) {
    if (model == null || value.isEmpty) {
      _model!.data = widget.listCustomer;
      setState(() {});
    } else {
      try {
        List<CustomerData> models = model.where((model) {
          List<String> search = value.removeAccents().split(" ");
          bool result = true;
          for (String element in search) {
            if (!((model.fullName ?? "").removeAccents().contains(element))) {
              result = false;
              break;
            }
          }
          return result;
        }).toList();
        _model!.data = models;
        setState(() {});
      } catch (_) {
        setState(() {});
      }
    }
  }
}

extension NumberParsing on String {
  double? tryParseDouble({bool isRound = false}) {
    if (this == null || this == "null") {
      return 0.0;
    }
    String param = this.toString().replaceAll(",", "");
    double? val = double.tryParse(param);
    return val == null
        ? 0.0
        : (isRound ? double.tryParse(val.toStringAsFixed(2)) : val);
  }

  String removeAccents() {
    List<String> chars = this.toLowerCase().split("");
    String a = "áàảạãăắằẳặẵâấầẩẫậ";
    String d = "đ";
    String e = "éèẻẽẹêếềểễệ";
    String i = "íìỉĩị";
    String o = "óòỏõọôốồổỗộơớờởỡợ";
    String u = "úùủũụưứừửữự";
    String y = "ýỳỷỹỵ";
    String result = "";
    chars.forEach((element) {
      if (a.contains(element))
        element = "a";
      else if (d.contains(element)) {
        element = "d";
      } else if (e.contains(element)) {
        element = "e";
      } else if (i.contains(element)) {
        element = "i";
      } else if (o.contains(element)) {
        element = "o";
      } else if (u.contains(element)) {
        element = "u";
      } else if (y.contains(element)) {
        element = "y";
      }
      result += element;
    });
    return result;
  }
}
