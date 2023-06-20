import 'package:food_deliverya_pp/controllers/auth_controller.dart';
import 'package:food_deliverya_pp/controllers/location_controller.dart';
import 'package:food_deliverya_pp/controllers/populer_product_controller.dart';
import 'package:food_deliverya_pp/controllers/recommended_product_controller.dart';
import 'package:food_deliverya_pp/controllers/user_controller.dart';
import 'package:food_deliverya_pp/data/api/api_client.dart';
import 'package:food_deliverya_pp/data/repository/auth_repo.dart';
import 'package:food_deliverya_pp/data/repository/cart_repo.dart';
import 'package:food_deliverya_pp/data/repository/location_repo.dart';
import 'package:food_deliverya_pp/data/repository/popular_product_repo.dart';
import 'package:food_deliverya_pp/utils/app_constans.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../controllers/cart_controller.dart';
import '../data/repository/recommended_product_repo.dart';
import '../data/repository/user_repo.dart';

Future<void> init()async{

  final sharedPreferances=await SharedPreferences.getInstance();

  Get.lazyPut(() => sharedPreferances );

//api clint
  Get.lazyPut(() => ApiClinet(appBaseUrl:AppConstants.BASE_URL,sharedPreferences:Get.find() ));
  Get.lazyPut(()=>AuthRebo(apiClinet: Get.find(), sharedPreferences: Get.find()));
  Get.lazyPut(()=>UserRepo(apiClinet: Get.find()));

//repos
  Get.lazyPut(() => PopularProductRepo(apiClinet: Get.find()));
  Get.lazyPut(() => RecommendedProductRepo(apiClinet: Get.find()));
  Get.lazyPut(() => CartRepo( sharedPreferences: Get.find()));
  Get.lazyPut(()=>LocationRepo(apiClinet: Get.find(), sharedPreferences:  Get.find()));
//controllers
  Get.lazyPut(()=>AuthController(authRebo: Get.find()));
  Get.lazyPut(()=>UserController(userRepo: Get.find()));
  Get.lazyPut(() => PopularProductController(popularProductRepo: Get.find()));
  Get.lazyPut(() => RecommendedProdactController(recommendedProductRepo: Get.find()));
  Get.lazyPut(() => CartController(cartRepo: Get.find()));
  Get.lazyPut(() => LocationController(locationRepo: Get.find()));



}