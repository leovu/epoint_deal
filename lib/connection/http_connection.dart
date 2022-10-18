import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class HTTPConnection {
  // static String domain = 'https://staff-api.stag.epoints.vn';
  // static String brandCode = 'qc';
  // static String asscessToken = '';

  static String domain = '';
  static String brandCode = '';
  static String asscessToken = '';

  Future<ResponseData>post(String path, Map<String, dynamic> body) async {
    final uri = Uri.parse('$domain$path');
    final headers = {'Content-Type': 'application/json','brand-code':brandCode, 'lang': LeadConnection.locale.languageCode};
    // if(LeadConnection.account != null) {
      // headers['Authorization'] = 'Bearer ${LeadConnection.account.accessToken}';
      headers['Authorization'] = 'Bearer ${asscessToken}';
    // }
    String jsonBody = json.encode(body);
    if (kDebugMode) {
      print('***** POST *****');
      print(uri);
      print(headers);
      print(jsonBody);
      print('***** POST *****');
    }
    final encoding = Encoding.getByName('utf-8');
    http.Response response = await http.post(
      uri,
      headers: headers,
      body: jsonBody,
      encoding: encoding,
    );
    int statusCode = response.statusCode;
    print(response);
    if(statusCode == 200) {
      ResponseData data = ResponseData();
      data.isSuccess = true;
      try {
        String responseBody = response.body;
        data.data = jsonDecode(responseBody);
      }catch(_) {}
      return data;
    }
    else if( 201 <= statusCode && statusCode < 300) {
      ResponseData data = ResponseData();
      data.isSuccess = true;
      return data;
    }
    else {
      ResponseData data = ResponseData();
      data.isSuccess = false;
      try {
        String responseBody = response.body;
        data.data = jsonDecode(responseBody);
      }catch(_) {}
      return data;
     
    }
  }
  Future<ResponseData>delete(String path, Map<String, dynamic> body) async {
    final uri = Uri.parse('$domain$path');
    final headers = {'Content-Type': 'application/json','brand-code':brandCode, 'lang': LeadConnection.locale.languageCode};
    if(LeadConnection.account != null) {
      headers['Authorization'] = 'Bearer ${LeadConnection.account.accessToken}';
    }
    String jsonBody = json.encode(body);
    if (kDebugMode) {
      print('***** DELETE *****');
      print(uri);
      print(headers);
      print(jsonBody);
      print('***** DELETE *****');
    }
    final encoding = Encoding.getByName('utf-8');
    http.Response response = await http.delete(
      uri,
      headers: headers,
      body: jsonBody,
      encoding: encoding,
    );
    int statusCode = response.statusCode;
    if(statusCode == 200) {
      String responseBody = response.body;
      ResponseData data = ResponseData();
      data.isSuccess = true;
      data.data = jsonDecode(responseBody);
      return data;
    }
    else if( 201 <= statusCode && statusCode < 300) {
      ResponseData data = ResponseData();
      data.isSuccess = true;
      return data;
    }
    else {
      ResponseData data = ResponseData();
      data.isSuccess = false;
      try {
        String responseBody = response.body;
        data.data = jsonDecode(responseBody);
      }catch(_) {}
      return data;
    }
  }
  Future<ResponseData>get(String path) async {
    final uri = Uri.parse('$domain$path');
    final headers = {'brand-code':brandCode, 'lang': LeadConnection.locale.languageCode};
    if(LeadConnection.account != null) {
      headers['Authorization'] = 'Bearer ${LeadConnection.account.accessToken}';
    }
    if (kDebugMode) {
      print('***** GET *****');
      print(uri);
      print(headers);
      print('***** GET *****');
    }
    http.Response response = await http.get(
      uri,
      headers: headers,
    );
    int statusCode = response.statusCode;
    if(statusCode == 200) {
      String responseBody = response.body;
      ResponseData data = ResponseData();
      data.isSuccess = true;
      data.data = jsonDecode(responseBody);
      return data;
    }
    else {
      ResponseData data = ResponseData();
      data.isSuccess = false;
      try {
        String responseBody = response.body;
        data.data = jsonDecode(responseBody);
      }catch(_) {}
      return data;
    }
  }
}

class ResponseData {
   bool isSuccess;
   Map<String,dynamic> data;
}

