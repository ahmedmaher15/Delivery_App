import 'package:flutter/material.dart';
import 'package:food_deliverya_pp/controllers/cart_controller.dart';
import 'package:food_deliverya_pp/data/repository/popular_product_repo.dart';
import 'package:food_deliverya_pp/models/products_model.dart';
import 'package:food_deliverya_pp/utils/colors.dart';
import 'package:get/get.dart';

import '../models/cart_model.dart';

class PopularProductController extends GetxController{
  final PopularProductRepo popularProductRepo;

  PopularProductController({required this.popularProductRepo});
  List<dynamic> _populerProductList=[];
  List<dynamic> get populerProductList=>_populerProductList;
  late CartController _cart;

  bool _isLoded=false;
  bool get isLoded=>_isLoded;

  int _quantity=0;
  int get quantity=>_quantity;

  int _inCartItems=0;
  int get inCartItems=>_inCartItems+_quantity;





  Future<void> getPopulerProductList()async {
    Response response=await popularProductRepo.getPopulerProducetList();
    if(response.statusCode==200 ){
      _populerProductList=[];
      _populerProductList.addAll(Product.fromJson(response.body).products);
      //print(_populerProductList);
      _isLoded=true;
      update();
    }else{
      print("error in populer Controller ${_populerProductList}");
    }
  }

  void setQuantity(bool isIncrement){
    if(isIncrement==true){
      _quantity=checkQuantity(_quantity+1);
   //   print("number of the items ${_quantity}");
    }else{
      _quantity=checkQuantity(_quantity-1);
   //   print("decrement ${_quantity}");
    }
    update();
  }

  int checkQuantity(int quantity){
    if((_inCartItems+quantity)<0){
      Get.snackbar("Item count", "You can't add more!",backgroundColor: AppColors.mainColor,colorText: Colors.white);
      if(_inCartItems>0){
        _quantity=-_inCartItems;
        print("${_quantity}");
        print("${_inCartItems}");
        return _quantity;
      }
      return 0;
    }
    else  if(((_inCartItems+quantity)>20)){
      Get.snackbar("Item count", "You can't reduce more!",backgroundColor: AppColors.mainColor,colorText: Colors.white);
      print("incr ${inCartItems}");

      return 20;
    }
    else{
      return quantity;
    }
  }
  void initProduct(ProductsModel product,CartController cart){
    _quantity=0;
    _inCartItems=0;
    _cart =cart;
    var exist=false;
    exist=_cart.existInCart(product);
    if(exist){
      _inCartItems=_cart.getQuantity(product);
    }
    print("the quantity in the cart is ${_inCartItems}");
  }
  void addItem(ProductsModel product){
      _cart.addItem(product,_quantity);
      _quantity=0;
      _inCartItems=_cart.getQuantity(product);
      _cart.item.forEach((key, value) { 
        print("the Id is ${value.id}   the quantity is ${value.quantity}");
      });
      update();
  }
  int get totalItems{
    return _cart.totalItems;
  }
  List<CartModel> get getItems {
    return _cart.getItems;
  }
}