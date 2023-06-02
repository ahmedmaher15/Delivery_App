import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import 'models/products_model.dart';

class DioClient{
  final dio=Dio();
  static const baseURL="http://localhost/shopping-app/public/";
  static const postsEndPoint=baseURL+"api/v1/products/popular";
  Future<Product> fetchPost(int postId)async{
    try{
      final response =await dio.get(postsEndPoint+"this is the post");
      debugPrint(response.toString());
      return Product.fromJson(response.data);
    }on DioError catch (e){
      debugPrint("Status code: ${e.response?.statusCode.toString()}");
      throw Exception("Failed to  load post:");
    }
  }
}