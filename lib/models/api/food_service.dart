import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:kalorieda/models/food_model.dart';

class ApiService {
  final Dio _dio = Dio();

  final String _baseUrl = 'https://trackapi.nutritionix.com/v2/natural/nutrients';

  Future<List<Foods>?> getallFood(String params) async {
    List<Foods>? food = [];

    try {
      var response = await _dio.post(_baseUrl,
          options: Options(
            headers: {
              HttpHeaders.contentTypeHeader: "application/json",
              "x-app-id": "32ced87f",
              "x-app-key": "a5337e0399e8ce1f52f1c5c33f7e4678",
              "x-remote-user-id": "0"
            },
          ),
          data: {"query": params});
      if (response.statusCode == 200) {
        Map<String, dynamic> data = response.data;
        List listData = data["foods"];
        food = listData.map((e) => Foods.fromJson(e)).toList();
      } else {
        print('gagal cok');
      }
    } on DioError catch (e) {
      if (e.response != null) {
        debugPrint('Dio error!');
        debugPrint('STATUS: ${e.response?.statusCode}');
        debugPrint('DATA: ${e.response?.data}');
        debugPrint('HEADERS: ${e.response?.headers}');
      } else {
        debugPrint('Error sending request!');
        debugPrint(e.message);
      }
    }
    return food;
  }
}
