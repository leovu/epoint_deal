
// import 'package:epoint_deal_plugin/connection/deal_connection.dart';
// import 'package:epoint_deal_plugin/model/request/service_detail_request_model.dart';
// import 'package:epoint_deal_plugin/model/response/service_detail_response_model.dart';
// import 'package:epoint_deal_plugin/presentation/interface/base_bloc.dart';
// import 'package:rxdart/rxdart.dart';
// import 'package:flutter/material.dart';

// class ServiceDetailBloc extends BaseBloc {

//   ServiceDetailBloc(BuildContext context){
//     setContext(context);
//   }

//   @override
//   void dispose() {
//     // TODO: implement dispose
//     _streamImage.close();
//     _streamModel.close();
//     _streamQuantity.close();
//     super.dispose();
//   }

//   final _streamImage = BehaviorSubject<String?>();
//   ValueStream<String?> get outputImage => _streamImage.stream;
//   setImage(String? event) => set(_streamImage, event);

//   final _streamModel = BehaviorSubject<ServiceDetailResponseModel?>();
//   ValueStream<ServiceDetailResponseModel?> get outputModel => _streamModel.stream;
//   setModel(ServiceDetailResponseModel event) => set(_streamModel, event);

//   final _streamQuantity = BehaviorSubject<int?>();
//   ValueStream<int?> get outputQuantity => _streamQuantity.stream;
//   setQuantity(int event) => set(_streamQuantity, event);

//   serviceDetail(ServiceDetailRequestModel model, bool isRefresh) async {
//     ServiceDetailModel? result = await DealConnection.serviceDetail(context, model);
//     if(result != null){
//       ServiceDetailResponseModel? responseModel = result.data;

//       setModel(responseModel ?? ServiceDetailResponseModel());
//     }
//     else{
//       if(!isRefresh){
//         setModel(ServiceDetailResponseModel());
//       }
//     }
//   }
// }