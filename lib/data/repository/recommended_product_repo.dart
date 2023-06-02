import 'package:food_deliverya_pp/data/api/api_client.dart';
import 'package:food_deliverya_pp/utils/app_constans.dart';
import 'package:get/get.dart';

class RecommendedProductRepo extends GetxService{
  final ApiClinet apiClinet;
  RecommendedProductRepo({required this.apiClinet});
  Future<Response> getRecommendedProducetList()async{
    return  await apiClinet.getData(AppConstants.RECOMMENDED_PRODUCT_URI);
  }
}