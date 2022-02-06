import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:next_shop_app/constants/strings.dart';

class ApiServices {
  late Dio _dio;

  ApiServices() {
    BaseOptions _options = BaseOptions(
      connectTimeout: 50 * 1000,
      receiveTimeout: 50 * 1000,
      receiveDataWhenStatusError: true,
    );
    _dio = Dio(_options);
  }

  Future<Response> getData({required String url}) async {
    return await _dio.get(url);
  }

  Future<Map<String, dynamic>> auth(
      {required String userName, required String password}) async {
    final response = await _dio.post(baseUrl + authEP,
        data: json.encode({'username': userName, 'password': password}));
    return response.data;
  }

  Future<List> getAllProducts() async {
    final response = await getData(url: baseUrl + productsEP);
    return response.data;
  }

  Future<List> getAllCategories() async {
    final response = await getData(url: baseUrl + allcategoriesEP);
    return response.data;
  }

  Future<List> getSingleCategory(String category) async {
    final response = await getData(url: baseUrl + categoryEP + category);
    return response.data;
  }

  Future<List> getOrders() async {
    final response = await getData(url: baseUrl + ordersEP);
    return response.data;
  }

  Future getUser() async {
    final response = await getData(url: baseUrl + userEP);
    return response.data;
  }

}
