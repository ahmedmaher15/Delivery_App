import 'package:food_deliverya_pp/ui/widget_screen/food/populer_food_detail.dart';
import 'package:food_deliverya_pp/ui/widget_screen/food/recommend_food_detail.dart';
import 'package:food_deliverya_pp/ui/widget_screen/main_food_screen/main_food__page.dart';
import 'package:get/get.dart';

class RouteHelper{
  static const initiol="/";
  static const popularFood="/popular-food";
  static const recommendedFood="/recommended-food";

  static String getInitiol()=>"$initiol";
  static String getPopularFood(int pageId)=>"$popularFood?pageId=$pageId";
  static String getRecommendedFood(int pageId)=>"$recommendedFood?pageId=$pageId";

  static List<GetPage> routes=[
    GetPage(name: "/", page: ()=>MainFoodPage(),transition: Transition.fadeIn),
    GetPage(name: popularFood, page:() {
      var pageId=Get.parameters['pageId'];
      return PopulerFoodDetail(pageId:int.parse( pageId!));
    },transition: Transition.fadeIn),
    GetPage(name: recommendedFood, page:() {
      var pageId=Get.parameters['pageId'];
      return RecommendenFoodDetail(pageId:int.parse( pageId!));
    },transition: Transition.fadeIn),
  ];
}