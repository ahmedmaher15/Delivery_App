import 'package:flutter/material.dart';
import 'package:food_deliverya_pp/data/repository/cart_repo.dart';
import 'package:food_deliverya_pp/models/products_model.dart';
import 'package:get/get.dart';

import '../models/cart_model.dart';
import '../utils/colors.dart';

class CartController extends GetxController {
  final CartRepo cartRepo;

  CartController({required this.cartRepo});

  Map<int, CartModel> _items = {};
  Map<int,CartModel> get item=>_items;

  void addItem(ProductsModel product, int quantity) {
    var totalQuantity=0;
    if (_items.containsKey(product.id!)){
      _items.update(product.id!, (value) {
        totalQuantity=value.quantity!+quantity;
        return CartModel(
        id: value.id,
        name: value.name,
        price: value.price,
        img: value.img,
        quantity:value.quantity!+quantity,
        isExist: true,
        time: DateTime.now().toString(),
      );
      });
      if(totalQuantity<=0){
        _items.remove(product.id);
      }
    }else{
      if(quantity>0){
        _items.putIfAbsent(product.id!, () {
          return CartModel(
            id: product.id,
            name: product.name,
            price: product.price,
            img: product.img,
            quantity: quantity,
            isExist: true,
            time: DateTime.now().toString(),
          );
        });
      }else{
        Get.snackbar("Item count", "Your should  at least add an item in the cart!",
            backgroundColor: AppColors.mainColor,
            colorText: Colors.white);
      }
    }

  }
  existInCart(ProductsModel product){
    if(_items.containsKey(product.id)){
      return true;
    }
    return false;
  }
  int getQuantity(ProductsModel product){
    var quantity=0;
    if(_items.containsKey(product.id)){
      _items.forEach((key, value) {
        if(key==product.id){
          quantity=value.quantity!;
        }
      });
    }
    return quantity;
  }
}
