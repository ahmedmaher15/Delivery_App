import 'package:flutter/material.dart';
import 'package:food_deliverya_pp/base/no_data_page.dart';
import 'package:food_deliverya_pp/controllers/auth_controller.dart';
import 'package:food_deliverya_pp/controllers/cart_controller.dart';
import 'package:food_deliverya_pp/controllers/populer_product_controller.dart';
import 'package:food_deliverya_pp/controllers/recommended_product_controller.dart';
import 'package:food_deliverya_pp/routes/routes_helper.dart';
import 'package:food_deliverya_pp/ui/app_icon.dart';
import 'package:food_deliverya_pp/ui/big_text.dart';
import 'package:food_deliverya_pp/ui/small_text.dart';
import 'package:food_deliverya_pp/screens/home/main_food__page.dart';
import 'package:food_deliverya_pp/utils/app_constans.dart';
import 'package:food_deliverya_pp/utils/colors.dart';
import 'package:food_deliverya_pp/utils/dimensions.dart';
import 'package:get/get.dart';

class CartPage extends StatelessWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          //header
          Positioned(
            right: Dimensions.width20,
            left: Dimensions.width20,
            top: Dimensions.height20 * 3,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AppIcon(
                  icon: Icons.arrow_back_ios,
                  iconColor: Colors.white,
                  bgColor: AppColors.mainColor,
                  iconSize: Dimensions.iconSize24,
                ),
                SizedBox(width: Dimensions.width20*5,),
                GestureDetector(
                  onTap: (){
                    Get.toNamed(RouteHelper.getInitiol());
                  },
                  child: AppIcon(
                    icon: Icons.home_outlined,
                    iconColor: Colors.white,
                    bgColor: AppColors.mainColor,
                    iconSize: Dimensions.iconSize24,
                  ),
                ),
                AppIcon(
                  icon: Icons.shopping_cart,
                  iconColor: Colors.white,
                  bgColor: AppColors.mainColor,
                  iconSize: Dimensions.iconSize24,
                ),
              ],
            ),
          ),
          //body
          GetBuilder<CartController>(
            builder: (_cartController) {
              return _cartController.getItems.length>0?Positioned(
                top: Dimensions.height20*5,
                left: Dimensions.width20,
                right: Dimensions.width20,
                bottom: 0,
                child: Container(
                  margin: EdgeInsets.only(top: Dimensions.height15),
                  decoration: const BoxDecoration(

                  ),
                  child: MediaQuery.removePadding(
                    context: context,
                    removeTop: true,
                    child: GetBuilder<CartController>(builder:(cartController){
                      var _cartList=cartController.getItems;
                      return ListView.builder(
                          itemCount:_cartList.length,
                          itemBuilder: (_,index){
                            return Container(
                              height: Dimensions.height20*5,
                              width: double.maxFinite,
                              margin: EdgeInsets.only(bottom: Dimensions.height10),
                              child: Row(
                                children: [
                                  //show image of product////////////////////////////////
                                  GestureDetector(
                                    onTap:(){
                                      var popularIndex =Get.find<PopularProductController>()
                                          .populerProductList
                                          .indexOf(_cartList[index].product!);
                                      if(popularIndex>=0){
                                        Get.toNamed(RouteHelper.getPopularFood(popularIndex,"cartpage"));
                                      }else{
                                        var  recommendedIndex =Get.find<RecommendedProdactController>()
                                            .recommendedProductList
                                            .indexOf(_cartList[index].product!);
                                        if(recommendedIndex<0){
                                          Get.snackbar(
                                              "History Product", "Product review is not availble for history products!",
                                              backgroundColor: AppColors.mainColor, colorText: Colors.white);
                                        }else{
                                          Get.toNamed(RouteHelper.getRecommendedFood(recommendedIndex,"cartpage"));
                                        }
                                      }
                                    },
                                    child: Container(
                                      width: Dimensions.width20*5,
                                      height: Dimensions.height20*5,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(Dimensions.radius20),
                                          color: Colors.white,
                                          image: DecorationImage(
                                              image: NetworkImage(AppConstants
                                                  .BASE_URL +
                                                  AppConstants.UPLOADE_URL +
                                                  "${cartController.getItems[index].img}"))),
                                    ),
                                  ),
                                  SizedBox(width: Dimensions.width10,),
                                  //Show the details of the produst ///////////////////
                                  Expanded(child: Container(
                                    height: Dimensions.height20*5,

                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: [
                                        BigText(text: "${cartController.getItems[index].name}",color: Colors.black54,),
                                        SmallText(text: "Spicy"),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            BigText(text: "${cartController.getItems[index].price}",color: Colors.redAccent,),
                                            Container(
                                              padding: EdgeInsets.only(
                                                  top: Dimensions.height10,
                                                  bottom: Dimensions.height10,
                                                  left: Dimensions.width10,
                                                  right: Dimensions.width10),
                                              decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(Dimensions.radius20),
                                                  color: Colors.white),
                                              child: Row(
                                                children: [
                                                  GestureDetector(
                                                      onTap: () {
                                                        cartController.addItem(_cartList[index].product!, -1);
                                                      },
                                                      child: Icon(
                                                        Icons.remove,
                                                        color: AppColors.signColor,
                                                        size: Dimensions.height30,
                                                      )),
                                                  SizedBox(
                                                    width: Dimensions.width10 / 2,
                                                  ),
                                                  BigText(text: "${_cartList[index].quantity}"),
                                                  SizedBox(
                                                    width: Dimensions.width10 / 2,
                                                  ),
                                                  GestureDetector(
                                                      onTap: () {
                                                        cartController.addItem(_cartList[index].product!, 1);
                                                      },
                                                      child: Icon(
                                                        Icons.add,
                                                        color: AppColors.signColor,
                                                        size: Dimensions.height30,
                                                      )),
                                                ],
                                              ),
                                            ),

                                          ],
                                        )
                                      ],
                                    ),
                                  ))
                                ],
                              ),
                            );
                          });
                    }),
                  ),
                ),
              ):const NoDataPage(text: "Your Cart is empty!");
            }
          ),

        ],
      ),
      bottomNavigationBar:
      GetBuilder<CartController>(builder: (carProduct) {
        return Container(
          height: Dimensions.height45 * 2 + Dimensions.height30,
          padding: EdgeInsets.only(
              top: Dimensions.height30,
              bottom: Dimensions.height30,
              left: Dimensions.width20,
              right: Dimensions.width20),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(Dimensions.radius20 * 2),
                  topLeft: Radius.circular(Dimensions.radius20 * 2)),
              color: AppColors.buttonBackgroundColor),
          child: carProduct.getItems.length>0?Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: EdgeInsets.only(
                    top: Dimensions.height20,
                    bottom: Dimensions.height20,
                    left: Dimensions.width20,
                    right: Dimensions.width20),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(Dimensions.radius20),
                    color: Colors.white),
                child: Row(
                  children: [
                    SizedBox(
                      width: Dimensions.width10 / 2,
                    ),
                    BigText(text: "\$ ${carProduct.totalAmout}"),
                    SizedBox(
                      width: Dimensions.width10 / 2,
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                  if(Get.find<AuthController>().usrLogedIn()) {
                          carProduct.addToHestory();
                        }else{
                    Get.toNamed(RouteHelper.getSignIn());
                  }

                      },
                child: Container(
                  padding: EdgeInsets.only(
                      top: Dimensions.height20,
                      bottom: Dimensions.height20,
                      left: Dimensions.width20,
                      right: Dimensions.width20),
                  decoration: BoxDecoration(
                    color: AppColors.mainColor,
                    borderRadius: BorderRadius.circular(Dimensions.radius20),
                  ),
                  child: BigText(
                    text: 'Check Out',
                    color: Colors.white,
                  ),
                ),
              )
            ],
          ):Container(),
        );
      }),
    );
  }
}
