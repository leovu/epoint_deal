import 'package:auto_size_text/auto_size_text.dart';
import 'package:epoint_deal_plugin/common/lang_key.dart';
import 'package:epoint_deal_plugin/common/localization/app_localizations.dart';
import 'package:epoint_deal_plugin/common/theme.dart';
import 'package:epoint_deal_plugin/presentation/order_category/ui/product_tab_screen.dart';
import 'package:epoint_deal_plugin/presentation/order_category/ui/service_tab_screen.dart';
import 'package:epoint_deal_plugin/utils/global_cart.dart';
import 'package:epoint_deal_plugin/widget/custom_scaffold.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class OrderCategoryScreen extends StatefulWidget {
  final bool isViewOnly;
  final bool isProduct;
  final bool isBooking;
  final bool isSelected;

  OrderCategoryScreen(
      {this.isViewOnly = false,
      this.isProduct = true,
      this.isBooking = false,
      this.isSelected = false});
  @override
  _OrderCategoryScreenState createState() => _OrderCategoryScreenState();
}

class _OrderCategoryScreenState extends State<OrderCategoryScreen>
    with SingleTickerProviderStateMixin {
  TabController? _tabController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controllerSearch = TextEditingController();

    _tabController = TabController(
        length: 2, vsync: this, initialIndex: widget.isProduct ? 0 : 1);
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      body: CupertinoPageScaffold(
        navigationBar: _navigationBar() as ObstructingPreferredSizeWidget?,
        child: Column(
          children: [
            Expanded(
                child: widget.isBooking
                    ? ServiceTabScreen(
                        searchController,
                        _controllerSearch,
                        isViewOnly: widget.isViewOnly,
                        isBooking: true,
                      )
                    : DefaultTabController(
                        length: 2,
                        child: Scaffold(
                          appBar: AppBar(
                            leading: Container(),
                            backgroundColor:
                                CupertinoTheme.of(context).barBackgroundColor,
                            flexibleSpace: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                TabBar(
                                  controller: _tabController,
                                  labelColor: AppColors.primaryColor,
                                  unselectedLabelColor:
                                      AppColors.black.withAlpha(40),
                                  tabs: [
                                    Tab(
                                        text: AppLocalizations.text(
                                            LangKey.product)),
                                    Tab(
                                        text: AppLocalizations.text(
                                            LangKey.service)),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          body: TabBarView(
                            controller: _tabController,
                            children: [
                              ProductTabScreen(
                                searchController,
                                _controllerSearch,
                                isViewOnly: widget.isViewOnly,
                                isSelected: widget.isSelected,
                              ),
                              ServiceTabScreen(
                                searchController,
                                _controllerSearch,
                                isViewOnly: widget.isViewOnly,
                                isSelected: widget.isSelected,
                              ),
                            ],
                          ),
                        ),
                      )),
            Container(
              decoration: BoxDecoration(
                  color: Color.fromARGB(255, 145, 143, 192).withAlpha(20),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey.withAlpha(30),
                        offset: Offset(1.0, 1.0))
                  ]),
              height: 1.0,
            ),
            StreamBuilder(
              initialData: 0.0,
              stream: GlobalCart.shared.bloc.outputValue,
              builder: (_, snapshot) {
                if (snapshot.hasData && (snapshot.data as double) > 0) {
                  double? value = snapshot.data as double?;
                  return Container(
                    margin:
                        EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                    child: Row(
                      children: [
                        AutoSizeText(
                          '${AppLocalizations.text(LangKey.total_money)}:',
                          style: TextStyle(
                              color: AppColors.primaryColor,
                              fontWeight: FontWeight.w600),
                        ),
                        SizedBox(width: 5.0,),
                        Expanded(
                            child: AutoSizeText(
                          value.getMoneyFormat(),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              color: Color.fromRGBO(145, 143, 192, 1),
                              fontWeight: FontWeight.w600),
                        )),
                        InkWell(
                          onTap: () {
                            List<Map<String, dynamic>> arr = [];
                            GlobalCart.shared.products.forEach((e) {
                              arr.add(e.toJsonOrderDetail());
                            });
                            GlobalCart.shared.services.forEach((e) {
                              arr.add(e.toJsonOrderDetail());
                            });
                            Navigator.of(context).pop(arr);
                          },
                          child: Container(
                            width: 100.0,
                            height: 40.0,
                            decoration: BoxDecoration(
                                color: AppColors.primaryColor,
                                gradient: RadialGradient(
                                    center: Alignment.centerRight,
                                    radius: 0.75,
                                    colors: <Color>[
                                      AppColors.primaryColor,
                                      Color(0xFF5faee3),
                                    ],
                                    tileMode: TileMode.clamp),
                                borderRadius: BorderRadius.circular(20.0)),
                            child: Center(
                              child: AutoSizeText(
                                AppLocalizations.text(LangKey.done)!,
                                textScaleFactor: 1.05,
                                style: TextStyle(
                                    color: AppColors.white,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  );
                } else {
                  return Container();
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  final OrderCategoryScreenController searchController =
      OrderCategoryScreenController();

  TextEditingController? _controllerSearch;
  Widget _navigationBar() {
    return CupertinoNavigationBar(
      middle: CupertinoSearchTextField(
        placeholder: AppLocalizations.text(widget.isBooking
            ? LangKey.search_for_services
            : LangKey.search_for_products_and_services),
        style: TextStyle(fontSize: 12.0),
        controller: _controllerSearch,
        onChanged: (value) {
          searchController.search(value);
        },
        onSubmitted: (value) {
          searchController.search(value);
        },
      ),
    );
  }
}

class OrderCategoryScreenController {
  late void Function(String value) search;
}
