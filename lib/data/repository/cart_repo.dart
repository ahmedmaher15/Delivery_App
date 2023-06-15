import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../../models/cart_model.dart';
import '../../utils/app_constans.dart';

class CartRepo{
  final SharedPreferences sharedPreferences;
  CartRepo({required this.sharedPreferences});
  List<String> cart=[];
  List<String> cartHestory=[];
  void addToCartList(List<CartModel> cartList){
  // sharedPreferences.remove(AppConstants.CART_LIST);
   //sharedPreferences.remove(AppConstants.CART_HISTORY);
    //cuz it will called a lot of times so we need to mack sure its empty
    var time=DateTime.now().toString();
    cart=[];
    //convert object to string because shared-preferences only accepts string

   cartList.forEach((element) {
     element.time=time;
    return cart.add(jsonEncode(element));
   });

   sharedPreferences.setStringList(AppConstants.CART_LIST, cart);
    print(sharedPreferences.getStringList(AppConstants.CART_LIST));
   // getCartList();
  }

  List<CartModel> getCartList(){
    List<String> carts=[];
    if(sharedPreferences.containsKey(AppConstants.CART_LIST)){
      cart=  sharedPreferences.getStringList(AppConstants.CART_LIST)!;
     // print("inside getCartList"+carts.toString());
    }
    List<CartModel> cartList=[];
    cart.forEach((element) {
      cartList.add(CartModel.fromJson(jsonDecode(element)));
    });
    return cartList;
  }

  List<CartModel> getCartHistoryList(){

    if(sharedPreferences.containsKey(AppConstants.CART_HISTORY_LIST)){
      cartHestory=[];
      cartHestory=sharedPreferences.getStringList(AppConstants.CART_HISTORY_LIST)!;

    }
    List<CartModel> cartListHistory=[];
    cartHestory.forEach((element) {
      cartListHistory.add(CartModel.fromJson(jsonDecode(element)));
    });
    return cartListHistory;
}

  void addToCartHistoryList(){
    if(sharedPreferences.containsKey(AppConstants.CART_HISTORY_LIST)){
      cartHestory = sharedPreferences.getStringList(AppConstants.CART_HISTORY_LIST)!;
    }
    for(int i=0;i<cart.length;i++){
      print("${cart[i]}");
      cartHestory.add(cart[i]);
    }
    removeCart();
    sharedPreferences.setStringList(AppConstants.CART_HISTORY_LIST, cartHestory);
    print("the length of the history${getCartHistoryList().length}");
   for(int j=0;j<getCartHistoryList().length;j++){
     print("The time is${getCartHistoryList()[j].time}");
   }
  }
  void removeCart(){
    cart=[];
    sharedPreferences.remove(AppConstants.CART_LIST);
  }

  void clearCartHistory(){
    removeCart();
    cartHestory=[];
    sharedPreferences.remove(AppConstants.CART_HISTORY_LIST);
  }

}