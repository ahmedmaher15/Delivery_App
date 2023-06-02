import 'package:food_deliverya_pp/controllers/populer_product_controller.dart';
import 'package:food_deliverya_pp/controllers/recommended_product_controller.dart';
import 'package:food_deliverya_pp/data/api/api_client.dart';
import 'package:food_deliverya_pp/data/repository/cart_repo.dart';
import 'package:food_deliverya_pp/data/repository/popular_product_repo.dart';
import 'package:food_deliverya_pp/utils/app_constans.dart';
import 'package:get/get.dart';

import '../controllers/cart_controller.dart';
import '../data/repository/recommended_product_repo.dart';

Future<void> init()async{
//api clint
  Get.lazyPut(() => ApiClinet(appBaseUrl:AppConstants.BASE_URL ));

//repos
  Get.lazyPut(() => PopularProductRepo(apiClinet: Get.find()));
  Get.lazyPut(() => RecommendedProductRepo(apiClinet: Get.find()));
  Get.lazyPut(() => CartRepo());

//controllers
  Get.lazyPut(() => PopularProductController(popularProductRepo: Get.find()));
  Get.lazyPut(() => RecommendedProdactController(recommendedProductRepo: Get.find()));
  Get.lazyPut(() => CartController(cartRepo: Get.find()));



}