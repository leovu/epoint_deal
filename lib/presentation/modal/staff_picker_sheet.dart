import 'package:epoint_deal_plugin/common/assets.dart';
import 'package:epoint_deal_plugin/common/lang_key.dart';
import 'package:epoint_deal_plugin/common/localization/app_localizations.dart';
import 'package:epoint_deal_plugin/common/theme.dart';
import 'package:epoint_deal_plugin/model/response/get_list_staff_responese_model.dart';
import 'package:epoint_deal_plugin/presentation/pick_one_staff_screen/bloc/pick_one_staff_lead_bloc.dart';
import 'package:epoint_deal_plugin/widget/custom_image_icon.dart';
import 'package:epoint_deal_plugin/widget/custom_item_bottom_sheet.dart';
import 'package:epoint_deal_plugin/widget/custom_line.dart';
import 'package:epoint_deal_plugin/widget/custom_listview.dart';
import 'package:epoint_deal_plugin/widget/custom_bottom_sheet_widget.dart';
import 'package:epoint_deal_plugin/widget/custom_menu_bottom_sheet.dart';
import 'package:epoint_deal_plugin/widget/custom_navigation.dart';
import 'package:epoint_deal_plugin/widget/custom_search_location.dart';
import 'package:epoint_deal_plugin/widget/custom_skeleton.dart';
import 'package:epoint_deal_plugin/widget/custom_textfield_lead.dart';
import 'package:epoint_deal_plugin/widget/widget.dart';
import 'package:flutter/material.dart';

class StaffPickerSheet extends StatefulWidget {
  final List<WorkListStaffModel>? models;
  final List<WorkListStaffModel>? allStaffs;

  const StaffPickerSheet({Key? key, this.models, this.allStaffs})
      : super(key: key);

  @override
  _StaffPickerSheetState createState() => _StaffPickerSheetState();
}

class _StaffPickerSheetState extends State<StaffPickerSheet> {
  FocusNode _focusSearch = FocusNode();
  TextEditingController _controllerSearch = TextEditingController();

  FocusNode _focusAgency = FocusNode();
  TextEditingController _controllerAgency = TextEditingController();

  FocusNode _focusDepartment = FocusNode();
  TextEditingController _controllerDepartment = TextEditingController();

  late PickOneStaffBloc _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = PickOneStaffBloc(context, widget.models, widget.allStaffs);
    _controllerSearch.addListener(_listener);
    WidgetsBinding.instance.addPostFrameCallback((_) => _onRefresh());
  }

  @override
  void dispose() {
    _controllerSearch.removeListener(_listener);
    _bloc.dispose();
    super.dispose();
  }

  Future _onRefresh() {
    final group = <Future>[];
    if (widget.allStaffs == null) {
      group.add(
          _bloc.workListStaff(widget.models, _controllerSearch.text, null));
    }
    group.add(_bloc.workListBranch());
    group.add(_bloc.workListDepartment());
    return Future.wait(group);
  }

  _listener() {
    _bloc.search(_controllerSearch.text);
  }

  Widget _buildSearch(List<WorkListStaffModel>? models) {
    return Container(
      padding: EdgeInsets.only(top: 16.0, left: 20.0, right: 20.0),
      child: Column(
        children: [
          CustomTextField(
            focusNode: _focusSearch,
            controller: _controllerSearch,
            hintText: AppLocalizations.text(LangKey.inputSearch),
            backgroundColor: Colors.transparent,
            borderColor: AppColors.borderColor,
          ),
          Padding(
            padding: EdgeInsets.only(top: 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AppLocalizations.text(LangKey.agency)!,
                  style: AppTextStyles.style14BlackBold,
                ),
                SizedBox(height: 10.0),
                Row(
                  children: [
                    Expanded(
                      child: StreamBuilder(
                        stream: _bloc.outputBranchModel,
                        initialData: null,
                        builder: (_, snapshot) {
                          if (snapshot.data == null) {
                            return CustomShimmer(
                                child: CustomSkeleton(height: 40.0, radius: 5.0));
                          }
                          return InkWell(
                            onTap: _showAgency,
                            child: Container(
                              padding: EdgeInsets.only(left: 8.0),
                              height: 50,
                              decoration: BoxDecoration(
                                border: Border.all(
                                    width: 1.0, color: Color(0xFFE5E5E5)),
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Text(
                                      (snapshot.data as CustomDropdownModel)
                                              .text ??
                                          "",
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(right: 15.0),
                                    child: CustomImageIcon(
                                      color: AppColors.grey500Color,
                                      icon: Assets.iconDropDown,
                                      size: 10.0,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    SizedBox(width: 10.0),
                    Expanded(
                      child: StreamBuilder(
                        stream: _bloc.outputDepartmentModel,
                        initialData: null,
                        builder: (_, snapshot) {
                          if (snapshot.data == null) {
                            return CustomShimmer(
                                child: CustomSkeleton(height: 40.0, radius: 5.0));
                          }
                          return InkWell(
                            onTap: _showDepartment,
                            child: Container(
                              padding: EdgeInsets.only(left: 8.0),
                              height: 50,
                              decoration: BoxDecoration(
                                border: Border.all(
                                    width: 1.0, color: Color(0xFFE5E5E5)),
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Text(
                                      (snapshot.data as CustomDropdownModel)
                                              .text ??
                                          "",
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(right: 15.0),
                                    child: CustomImageIcon(
                                      color: AppColors.grey500Color,
                                      icon: Assets.iconDropDown,
                                      size: 10.0,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showAgency() {
    CustomNavigator.showCustomBottomDialog(
      context,
      CustomMenuBottomSheet(
        title: AppLocalizations.text(LangKey.agency),
        widget: StreamBuilder(
          stream: _bloc.outputBranchModels,
          initialData: null,
          builder: (_, snapshot) {
            List<CustomDropdownModel>? menus =
                snapshot.data as List<CustomDropdownModel>?;
            return Column(
              children: [
                CustomSearchLocation(_focusAgency, _controllerAgency, (event) {
                  _bloc.searchAgency(event);
                }),
                Expanded(
                  child: CustomListView(
                    shrinkWrap: true,
                    padding: EdgeInsets.zero,
                    children: menus
                            ?.map((e) => CustomItemBottomSheet(e.text ?? "", () {
                                  _bloc.branchModel = e;
                                  _bloc.setBranchModel(e);
                                  _bloc.search(_controllerSearch.text);
                                  CustomNavigator.pop(context);
                                }))
                            .toList() ??
                        [],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  void _showDepartment() {
    CustomNavigator.showCustomBottomDialog(
      context,
      CustomMenuBottomSheet(
        title: AppLocalizations.text(LangKey.department),
        widget: StreamBuilder(
          stream: _bloc.outputDepartmentModels,
          initialData: null,
          builder: (_, snapshot) {
            List<CustomDropdownModel>? menus =
                snapshot.data as List<CustomDropdownModel>?;
            return Column(
              children: [
                CustomSearchLocation(
                    _focusDepartment, _controllerDepartment, (event) {
                  _bloc.searchDepartment(event);
                }),
                Expanded(
                  child: CustomListView(
                    shrinkWrap: true,
                    padding: EdgeInsets.zero,
                    children: menus
                            ?.map((e) => CustomItemBottomSheet(e.text ?? "", () {
                                  _bloc.departmentModel = e;
                                  _bloc.setDepartmentModel(e);
                                  _bloc.search(_controllerSearch.text);
                                  CustomNavigator.pop(context);
                                }))
                            .toList() ??
                        [],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildItem(
      List<WorkListStaffModel>? models, WorkListStaffModel? model) {
    return InkWell(
      onTap: model == null
          ? null
          : () {
              _bloc.selected(models!, model);
              Navigator.of(context).pop([model]);
            },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        alignment: Alignment.centerLeft,
        child: model == null
            ? CustomShimmer(
                child: CustomSkeleton(
                    width: MediaQuery.of(context).size.width / 2))
            : Row(
                children: [
                  CustomAvatarWithURL(
                    url: model.staffAvatar,
                    name: model.staffName,
                    size: 50.0,
                  ),
                  SizedBox(width: 10.0),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          model.staffName ?? "",
                          style: TextStyle(
                              fontSize: 16.0,
                              color: AppColors.black,
                              fontWeight: FontWeight.normal),
                        ),
                        Text(
                          model.departmentName ?? "",
                          style: TextStyle(
                              fontSize: 14.0,
                              color: Color(0XFF8E8E8E),
                              fontWeight: FontWeight.normal),
                        ),
                      ],
                    ),
                  ),
                  (model.isSelected ?? false)
                      ? Padding(
                          padding: EdgeInsets.only(left: 10.0),
                          child: Icon(Icons.radio_button_checked,
                              color: AppColors.primaryColor),
                        )
                      : Padding(
                          padding: EdgeInsets.only(left: 10.0),
                          child: Icon(Icons.radio_button_unchecked,
                              color: Color.fromARGB(255, 108, 102, 94)),
                        ),
                ],
              ),
      ),
    );
  }

  Widget _buildContent(List<WorkListStaffModel>? models) {
    return CustomListView(
      padding: EdgeInsets.zero,
      physics: AlwaysScrollableScrollPhysics(),
      separator: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        child: CustomLine(),
      ),
      children: models == null
          ? List.generate(4, (i) => _buildItem(models, null))
          : models.map((e) => _buildItem(models, e)).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final bodyHeight = MediaQuery.of(context).size.height * 0.75;
    return CustomBottomSheet(
      title: AppLocalizations.text(LangKey.chooseAllottedPerson),
      body: SizedBox(
        height: bodyHeight,
        child: StreamBuilder(
          stream: _bloc.outputModels,
          initialData: null,
          builder: (_, snapshot) {
            List<WorkListStaffModel>? models =
                snapshot.data as List<WorkListStaffModel>?;
            return Column(
              children: [
                _buildSearch(models),
                Expanded(child: _buildContent(models)),
              ],
            );
          },
        ),
      ),
    );
  }
}
