import 'dart:convert';

import 'package:dio/dio.dart';

class CallAPI {
  static Future<dynamic> fetchData(String url) async {
    Dio dio = Dio();
    try {
      Response response = await dio.get(url);
      int? statusCode = response.statusCode;
      if (statusCode == 200) {
        return response.data;
      } else {
        return null;
      }
    } catch (e) {
      throw Exception(e);
    }
  }
}
