import 'package:food_deliverya_pp/screens/cart_page.dart';
import 'package:food_deliverya_pp/screens/home_page.dart';
import 'package:food_deliverya_pp/screens/populer_food_detail.dart';
import 'package:food_deliverya_pp/screens/recommend_food_detail.dart';
import 'package:food_deliverya_pp/ui/widget_screen/main_food_screen/main_food__page.dart';
import 'package:get/get.dart';

class RouteHelper{
  static const String initiol="/";
  static const String popularFood="/popular-food";
  static const String recommendedFood="/recommended-food";
  static const String cartPage="/cart-Page";

  static String getInitiol()=>"$initiol";
  static String getPopularFood(int pageId,String page)=>"$popularFood?pageId=$pageId&page=$page";
  static String getRecommendedFood(int pageId,String page)=>"$recommendedFood?pageId=$pageId&page=$page";
  static String getCartPage()=>"$cartPage";

  static List<GetPage> routes=[
    GetPage(name: "/", page: ()=>HomePage(),transition: Transition.fadeIn),


    GetPage(name: popularFood, page:() {
      var pageId=Get.parameters['pageId'];
      var page=Get.parameters["page"];
      return PopulerFoodDetail(pageId:int.parse( pageId!),page:page!);
    },transition: Transition.fadeIn),


    GetPage(name: recommendedFood, page:() {
      var pageId=Get.parameters['pageId'];
      var page=Get.parameters['page'];
      return RecommendenFoodDetail(pageId:int.parse( pageId!),page:page!);
    },transition: Transition.fadeIn),


    GetPage(name: cartPage, page: (){return CartPage(); },transition: Transition.fadeIn)

  ];
}