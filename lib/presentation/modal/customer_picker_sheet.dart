import 'package:epoint_deal_plugin/common/lang_key.dart';
import 'package:epoint_deal_plugin/common/localization/app_localizations.dart';
import 'package:epoint_deal_plugin/common/theme.dart';
import 'package:epoint_deal_plugin/connection/deal_connection.dart';
import 'package:epoint_deal_plugin/model/request/list_customer_lead_model_request.dart';
import 'package:epoint_deal_plugin/model/response/get_customer_model_response.dart';
import 'package:epoint_deal_plugin/model/response/list_customer_lead_model_response.dart';
import 'package:epoint_deal_plugin/model/response/list_deal_model_reponse.dart';
import 'package:epoint_deal_plugin/widget/custom_data_not_found.dart';
import 'package:epoint_deal_plugin/widget/custom_listview.dart';
import 'package:flutter/material.dart';

String _removeAccents(String input) {
  final a = "áàảạãăắằẳặẵâấầẩẫậ";
  final d = "đ";
  final e = "éèẻẽẹêếềểễệ";
  final i = "íìỉĩị";
  final o = "óòỏõọôốồổỗộơớờởỡợ";
  final u = "úùủũụưứừửữự";
  final y = "ýỳỷỹỵ";
  return input.toLowerCase().split("").map((c) {
    if (a.contains(c)) return "a";
    if (d.contains(c)) return "d";
    if (e.contains(c)) return "e";
    if (i.contains(c)) return "i";
    if (o.contains(c)) return "o";
    if (u.contains(c)) return "u";
    if (y.contains(c)) return "y";
    return c;
  }).join();
}

class CustomerPickerSheet extends StatefulWidget {
  final List<CustomerData>? listCustomer;
  final DealItems? dealItem;

  const CustomerPickerSheet({Key? key, this.listCustomer, this.dealItem})
      : super(key: key);

  @override
  _CustomerPickerSheetState createState() => _CustomerPickerSheetState();
}

class _CustomerPickerSheetState extends State<CustomerPickerSheet> {
  final ScrollController _controller = ScrollController();
  final TextEditingController _searchText = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  GetCustomerModelResponse? _model;
  List<CustomerData>? _allData;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _getData());
  }

  @override
  void dispose() {
    _controller.dispose();
    _searchText.dispose();
    super.dispose();
  }

  Future<void> _getData() async {
    GetCustomerModelResponse? model = await DealConnection.getCustomer(context);
    if (model != null) {
      _allData = model.data;
      _model = GetCustomerModelResponse(
        data: (_allData ?? [])
            .map((e) => CustomerData.fromJson(e.toJson()))
            .toList(),
      );
      for (int i = 0; i < _model!.data!.length; i++) {
        _model!.data![i].selected = (widget.dealItem?.customerCode ?? "") ==
            _model!.data![i].customerCode;
      }
      if (mounted) setState(() {});
    }
  }

  void _selectCustomer(int index) {
    final models = _model!.data!;
    for (var e in models) {
      e.selected = false;
    }
    models[index].selected = true;
    Navigator.of(context).pop(models[index]);
  }

  void _searchModel(String value) {
    if (_allData == null) return;
    if (value.isEmpty) {
      _model!.data = _allData;
    } else {
      _model!.data = _allData!.where((m) {
        return _removeAccents(m.fullName ?? "").contains(_removeAccents(value));
      }).toList();
    }
    setState(() {});
  }

  Widget _buildItem(CustomerData item, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 44.0,
        padding: EdgeInsets.symmetric(horizontal: 8.0),
        alignment: Alignment.centerLeft,
        child: Text(
          item.fullName ?? "",
          style: TextStyle(
            fontSize: 15.0,
            color: (item.selected ?? false)
                ? AppColors.primaryColor
                : Colors.black,
            fontWeight:
                (item.selected ?? false) ? FontWeight.bold : FontWeight.normal,
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () => Navigator.of(context).pop(),
        child: Align(
          alignment: Alignment.bottomCenter,
          child: GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () {},
            child: Container(
      height: MediaQuery.of(context).size.height * 0.85,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(16.0)),
      ),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
            decoration: BoxDecoration(
              color: AppColors.primaryColor,
              borderRadius: BorderRadius.vertical(top: Radius.circular(16.0)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  AppLocalizations.text(LangKey.listCustomer)!,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.0,
                      fontWeight: FontWeight.w600),
                ),
                GestureDetector(
                  onTap: () => Navigator.of(context).pop(),
                  child: Icon(Icons.close, color: Colors.white),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.all(12.0),
            child: TextField(
              controller: _searchText,
              focusNode: _focusNode,
              decoration: InputDecoration(
                isCollapsed: true,
                contentPadding: EdgeInsets.all(12.0),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(width: 1, color: Color(0xFFB8BFC9)),
                ),
                hintText: AppLocalizations.text(LangKey.inputSearch),
                isDense: true,
              ),
              onChanged: _searchModel,
            ),
          ),
          Expanded(
            child: (_model == null)
                ? Center(child: CircularProgressIndicator())
                : ((_model!.data?.isEmpty ?? true))
                    ? CustomDataNotFound()
                    : CustomListView(
                        padding: EdgeInsets.only(
                            left: 8.0, right: 8.0, bottom: 16.0),
                        physics: AlwaysScrollableScrollPhysics(),
                        controller: _controller,
                        separator: Divider(height: 1),
                        children: List.generate(
                          _model!.data!.length,
                          (i) => _buildItem(
                              _model!.data![i], () => _selectCustomer(i)),
                        ),
                      ),
          ),
        ],
      ),
            ),
          ),
        ),
      ),
    );
  }
}

class LeadPickerSheet extends StatefulWidget {
  final List<ListCustomLeadItems>? items;
  final ListCustomLeadItems? leadItem;

  const LeadPickerSheet({Key? key, this.items, this.leadItem})
      : super(key: key);

  @override
  _LeadPickerSheetState createState() => _LeadPickerSheetState();
}

class _LeadPickerSheetState extends State<LeadPickerSheet> {
  final ScrollController _controller = ScrollController();
  final TextEditingController _searchText = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  ListCustomLeadData? _model;
  List<ListCustomLeadItems>? _allItems;

  int _currentPage = 1;
  int _nextPage = 2;

  @override
  void initState() {
    super.initState();
    _controller.addListener(_scrollListener);
    WidgetsBinding.instance.addPostFrameCallback((_) => _getData(false));
  }

  @override
  void dispose() {
    _controller.removeListener(_scrollListener);
    _controller.dispose();
    _searchText.dispose();
    super.dispose();
  }

  void _scrollListener() {
    if (_controller.offset >= _controller.position.maxScrollExtent &&
        !_controller.position.outOfRange) {
      if (_currentPage < _nextPage) {
        _getData(true, page: _currentPage + 1);
      }
    }
  }

  Future<void> _getData(bool loadMore, {int? page}) async {
    ListCustomLeadModelReponse? response =
        await DealConnection.getListPotentialCustomer(
      context,
      ListCustomLeadModelRequest(
        search: _searchText.text,
        page: page ?? _currentPage,
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
      ),
    );
    if (response != null) {
      if (!loadMore) {
        _allItems = response.data?.items ?? [];
      } else {
        _allItems!.addAll(response.data?.items ?? <ListCustomLeadItems>[]);
      }

      for (var item in _allItems!) {
        item.selected =
            (widget.leadItem?.customerLeadCode ?? "") == item.customerLeadCode;
      }

      _model = ListCustomLeadData(
        items: _allItems!
            .map((e) => ListCustomLeadItems.fromJson(e.toJson()))
            .toList(),
      );
      _currentPage = response.data?.pageInfo?.currentPage ?? 1;
      _nextPage = response.data?.pageInfo?.nextPage ?? 1;
      if (mounted) setState(() {});
    } else {
      _allItems = [];
      if (mounted) setState(() {});
    }
  }

  void _selectLead(int index) {
    final items = _model!.items!;
    for (var e in items) {
      e.selected = false;
    }
    items[index].selected = true;
    Navigator.of(context).pop(items[index]);
  }

  void _searchModel(String value) {
    if (_allItems == null) return;
    if (value.isEmpty) {
      _model!.items = _allItems;
    } else {
      _model!.items = _allItems!.where((m) {
        return _removeAccents(m.leadFullName ?? "")
            .contains(_removeAccents(value));
      }).toList();
    }
    setState(() {});
  }

  Widget _buildItem(ListCustomLeadItems item, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 44.0,
        padding: EdgeInsets.symmetric(horizontal: 8.0),
        alignment: Alignment.centerLeft,
        child: Text(
          item.leadFullName ?? "",
          style: TextStyle(
            fontSize: 15.0,
            color: (item.selected ?? false)
                ? AppColors.primaryColor
                : Colors.black,
            fontWeight:
                (item.selected ?? false) ? FontWeight.bold : FontWeight.normal,
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () => Navigator.of(context).pop(),
        child: Align(
          alignment: Alignment.bottomCenter,
          child: GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () {},
            child: Container(
              height: MediaQuery.of(context).size.height * 0.85,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius:
                    BorderRadius.vertical(top: Radius.circular(16.0)),
              ),
              child: Column(
                children: [
                  Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(16.0)),
                    ),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Center(
                          child: Text(
                            AppLocalizations.text(LangKey.listLead)!,
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 16.0,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: GestureDetector(
                            onTap: () => Navigator.of(context).pop(),
                            child: const Icon(Icons.close, color: Colors.black),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(12.0),
                    child: TextField(
                      controller: _searchText,
                      focusNode: _focusNode,
                      decoration: InputDecoration(
                        isCollapsed: true,
                        contentPadding: EdgeInsets.all(12.0),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(width: 1, color: Color(0xFFB8BFC9)),
                        ),
                        hintText: AppLocalizations.text(LangKey.inputSearch),
                        isDense: true,
                      ),
                      onChanged: _searchModel,
                    ),
                  ),
                  Expanded(
                    child: (_model == null)
                        ? Center(child: CircularProgressIndicator())
                        : ((_model!.items?.isEmpty ?? true))
                            ? Center(child: Text("Không có dữ liệu"))
                            : CustomListView(
                                padding: EdgeInsets.only(
                                    left: 8.0, right: 8.0, bottom: 16.0),
                                physics: AlwaysScrollableScrollPhysics(),
                                controller: _controller,
                                separator: Divider(height: 1),
                                children: List.generate(
                                  _model!.items!.length,
                                  (i) => _buildItem(
                                      _model!.items![i], () => _selectLead(i)),
                                ),
                              ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
