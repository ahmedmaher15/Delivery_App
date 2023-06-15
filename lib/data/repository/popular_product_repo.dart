import 'package:food_deliverya_pp/data/api/api_client.dart';
import 'package:food_deliverya_pp/utils/app_constans.dart';
import 'package:get/get.dart';

class PopularProductRepo extends GetxService{
  final ApiClinet apiClinet;
  PopularProductRepo({required this.apiClinet});
  Future<Response> getPopulerProductList()async{
    return  await apiClinet.getData(AppConstants.POPULAR_PRODUCT_URI);
  }
}