import 'package:food_deliverya_pp/screens/address/add_address_page.dart';
import 'package:food_deliverya_pp/screens/address/pick_address_map.dart';
import 'package:food_deliverya_pp/screens/auth/sign_in_page.dart';
import 'package:food_deliverya_pp/screens/auth/sign_up_page.dart';
import 'package:food_deliverya_pp/screens/cart/cart_page.dart';
import 'package:food_deliverya_pp/screens/home/home_page.dart';
import 'package:food_deliverya_pp/screens/food/populer_food_detail.dart';
import 'package:food_deliverya_pp/screens/food/recommend_food_detail.dart';
import 'package:food_deliverya_pp/screens/home/main_food__page.dart';
import 'package:food_deliverya_pp/screens/splash/splash_screen.dart';
import 'package:get/get.dart';

class RouteHelper{
  static const String splashPage="/splash-page";
  static const String initiol="/";
  static const String popularFood="/popular-food";
  static const String recommendedFood="/recommended-food";
  static const String cartPage="/cart-Page";
  static const String signIn="/sign-in";
  static const String signUp="/sign-out";
  static const String addAddress="/add-address";
  static const String pickAddressMap="/pick-address";


  static String getSplashPage()=>"$splashPage";
  static String getInitiol()=>"$initiol";
  static String getPopularFood(int pageId,String page)=>"$popularFood?pageId=$pageId&page=$page";
  static String getRecommendedFood(int pageId,String page)=>"$recommendedFood?pageId=$pageId&page=$page";
  static String getCartPage()=>"$cartPage";
  static String getSignIn()=>"$signIn";
  static String getSignUp()=>"$signUp";
  static String getAddressPage()=>"$addAddress";
  static String getPickAddressPage()=>"$pickAddressMap";
  static List<GetPage> routes=[

    GetPage(name: splashPage, page: ()=>const SplashScreen()),

    GetPage(name: initiol, page: ()=>const HomePage(),transition: Transition.fade),

    GetPage(name: signIn, page: ()=>const SignInPage(),transition: Transition.fade),
    GetPage(name: signUp, page: ()=>const SignUpPage(),transition: Transition.fade),


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


    GetPage(name: cartPage, page: (){return const CartPage(); },transition: Transition.fadeIn),
    GetPage(name: addAddress, page: (){return const AddAddressPage(); },transition: Transition.fadeIn),
    GetPage(name: pickAddressMap, page: (){PickAddressMap _pickAddress=Get.arguments;
      return const PickAddressMap();
      },transition: Transition.fadeIn)

  ];
}