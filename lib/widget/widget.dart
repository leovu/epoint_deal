library widget;

import 'dart:io';
import 'dart:math';
import 'dart:ui';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:badges/badges.dart' as bgd;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:epoint_deal_plugin/common/assets.dart';
import 'package:epoint_deal_plugin/common/constant.dart';
import 'package:epoint_deal_plugin/common/globals.dart';
import 'package:epoint_deal_plugin/common/lang_key.dart';
import 'package:epoint_deal_plugin/common/localization/app_localizations.dart';
import 'package:epoint_deal_plugin/common/localization/global.dart';
import 'package:epoint_deal_plugin/common/theme.dart';
import 'package:epoint_deal_plugin/model/customer_order_photo_model.dart';
import 'package:epoint_deal_plugin/model/discount_cart_model.dart';
import 'package:epoint_deal_plugin/model/filter_model.dart';
import 'package:epoint_deal_plugin/model/response/booking_list_response_model.dart';
import 'package:epoint_deal_plugin/model/response/booking_staff_response_model.dart';
import 'package:epoint_deal_plugin/model/response/customer_contact_response_model.dart';
import 'package:epoint_deal_plugin/model/response/customer_deal_response_model.dart';
import 'package:epoint_deal_plugin/model/response/customer_debt_response_model.dart';
import 'package:epoint_deal_plugin/model/response/customer_detail_response_model.dart';
import 'package:epoint_deal_plugin/model/response/customer_file_response_model.dart';
import 'package:epoint_deal_plugin/model/response/customer_note_response_model.dart';
import 'package:epoint_deal_plugin/model/response/customer_receipt_response_model.dart';
import 'package:epoint_deal_plugin/model/response/customer_response_model.dart';
import 'package:epoint_deal_plugin/model/response/customer_service_card_response_model.dart';
import 'package:epoint_deal_plugin/model/response/customer_staff_response_model.dart';
import 'package:epoint_deal_plugin/model/response/customer_work_response_model.dart';
import 'package:epoint_deal_plugin/model/response/order_response_model.dart';
import 'package:epoint_deal_plugin/model/response/order_service_card_response_model.dart';
import 'package:epoint_deal_plugin/model/response/product_new_response_model.dart';
import 'package:epoint_deal_plugin/model/response/project_list_response_model.dart';
import 'package:epoint_deal_plugin/model/response/service_card_response_model.dart';
import 'package:epoint_deal_plugin/model/response/service_new_response_model.dart';
import 'package:epoint_deal_plugin/model/response/survey_process_start_response_model.dart';
import 'package:epoint_deal_plugin/model/response/transport_method_response_model.dart';
import 'package:epoint_deal_plugin/model/response/work_job_overview_response_model.dart';
import 'package:epoint_deal_plugin/presentation/interface/base_bloc.dart';
import 'package:epoint_deal_plugin/presentation/order_module/src/ui/customer_order_photo_screen.dart';
import 'package:epoint_deal_plugin/utils/custom_image_picker.dart';
import 'package:epoint_deal_plugin/utils/custom_permission_request.dart';
import 'package:epoint_deal_plugin/utils/ultility.dart';
import 'package:epoint_deal_plugin/utils/visibility_api_widget_name.dart';
import 'package:epoint_deal_plugin/widget/container_data_builder.dart';
import 'package:epoint_deal_plugin/widget/custom_bottom.dart';
import 'package:epoint_deal_plugin/widget/custom_bottom_sheet.dart';
import 'package:epoint_deal_plugin/widget/custom_button.dart';
import 'package:epoint_deal_plugin/widget/custom_checkbox.dart';
import 'package:epoint_deal_plugin/widget/custom_empty.dart';
import 'package:epoint_deal_plugin/widget/custom_html.dart';
import 'package:epoint_deal_plugin/widget/custom_icon_button.dart';
import 'package:epoint_deal_plugin/widget/custom_image_icon.dart';
import 'package:epoint_deal_plugin/widget/custom_indicator.dart';
import 'package:epoint_deal_plugin/widget/custom_line.dart';
import 'package:epoint_deal_plugin/widget/custom_listview.dart';
import 'package:epoint_deal_plugin/widget/custom_navigation.dart';
import 'package:epoint_deal_plugin/widget/custom_radio_button.dart';
import 'package:epoint_deal_plugin/widget/custom_scaffold.dart';
import 'package:epoint_deal_plugin/widget/custom_size_transaction.dart';
import 'package:epoint_deal_plugin/widget/custom_skeleton.dart';
import 'package:epoint_deal_plugin/widget/custom_textfield.dart';
import 'package:epoint_deal_plugin/widget/decimal_number_input_formatter.dart';
import 'package:epoint_deal_plugin/widget/format_number_input_formatter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shimmer/shimmer.dart';
import 'package:smooth_star_rating_null_safety/smooth_star_rating_null_safety.dart';
import 'package:webview_flutter/webview_flutter.dart';



part 'custom_popup_dialog.dart';
part 'custom_network_image.dart';
part 'custom_placeholder.dart';
part 'custom_shimmer.dart';
part 'custom_cupertino_tab_bar.dart';
part 'custom_cupertino_tab_scaffold.dart';
part 'custom_row_information.dart';
// part 'container_ticket.dart';
part 'custom_column_information.dart';
part 'custom_combobox.dart';
part 'custom_rotate_transaction.dart';
part 'custom_menu.dart';
part 'container_supplies.dart';
part 'custom_dashline.dart';
// part 'custom_attach.dart';
// part 'custom_pie_chart.dart';
part 'custom_avatars.dart';
part 'custom_floating_action_button.dart';
// part 'custom_job.dart';
part 'custom_text_dropdown.dart';
part 'custom_badge.dart';
part 'custom_tabbar_item.dart';
// part 'custom_survey.dart';
part 'custom_dot.dart';
part 'custom_survey_progress.dart';
part 'custom_survey_conduct.dart';
// part 'custom_application.dart';
// part 'custom_approve_staff.dart';
part 'custom_approve_avatar.dart';
part 'custom_activity.dart';
part 'custom_error_text.dart';
// part 'custom_appointment.dart';
// part 'container_booking.dart';
part 'custom_container_list.dart';
part 'custom_search_box.dart';
part 'container_more_information.dart';
// part 'container_warranty.dart';
part 'custom_scan_screen.dart';
part 'scan_animation.dart';
// part 'container_maintenance.dart';
part 'custom_image_list.dart';
// part 'custom_location.dart';
part 'custom_pagination.dart';
part 'qr_scanner_overlay_shape.dart';
part 'custom_project.dart';
part 'custom_tag.dart';
part 'custom_bottom_radio.dart';
part 'custom_picker_color.dart';
part 'custom_icon_text.dart';
part 'custom_member_avatar.dart';
part 'container_customer.dart';
part 'container_order.dart';
part 'container_product.dart';
part 'container_service.dart';
part 'custom_bottom_cart.dart';
part 'custom_quantity.dart';
part 'custom_switch.dart';
part 'custom_star_rating.dart';
part 'custom_category.dart';
part 'custom_avatar_with_url.dart';
part 'custom_chip.dart';
part 'custom_container_project_item.dart';
part 'custom_file_view.dart';
part 'custom_bottom_option.dart';
part 'container_booking.dart';
part 'custom_dropdown.dart';