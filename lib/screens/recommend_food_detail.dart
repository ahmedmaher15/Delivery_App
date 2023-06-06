import 'package:flutter/material.dart';
import 'package:food_deliverya_pp/controllers/populer_product_controller.dart';
import 'package:food_deliverya_pp/controllers/recommended_product_controller.dart';
import 'package:food_deliverya_pp/routes/routes_helper.dart';
import 'package:food_deliverya_pp/ui/shares_widget/app_icon.dart';
import 'package:food_deliverya_pp/ui/shares_widget/big_text.dart';
import 'package:food_deliverya_pp/ui/widget_screen/food/exandable_text_widget.dart';
import 'package:food_deliverya_pp/utils/colors.dart';
import 'package:food_deliverya_pp/utils/dimensions.dart';
import 'package:get/get.dart';

import '../controllers/cart_controller.dart';
import '../utils/app_constans.dart';


class RecommendenFoodDetail extends StatelessWidget {
  const RecommendenFoodDetail({Key? key, required this.pageId, required this.page})
      : super(key: key);
  final int pageId;
  final String page;

  @override
  Widget build(BuildContext context) {
    var product =
        Get.find<RecommendedProdactController>().recommendedProductList[pageId];
    Get.find<PopularProductController>()
        .initProduct(product, Get.find<CartController>());
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            automaticallyImplyLeading: false,
            toolbarHeight: 70,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                    onTap: () {
                      if(page=="cartpage"){
                        Get.toNamed(RouteHelper.cartPage);
                      }else{
                        Get.toNamed(RouteHelper.getInitiol());
                      }
                    },
                    child: AppIcon(icon: Icons.clear)),
               // AppIcon(icon: Icons.shopping_cart_outlined)
              GetBuilder<PopularProductController>(builder: (controller) {
                return GestureDetector(
                  onTap: (){
                    if(controller.totalItems>=1) {
                      Get.toNamed(RouteHelper.getCartPage());
                    }
                  },
                  child: Stack(
                    children: [
                      AppIcon(icon: Icons.shopping_cart_outlined),
                      Get
                          .find<PopularProductController>()
                          .totalItems >= 1 ?
                      Positioned(
                          right: 0,
                          top: 0,
                          child: AppIcon(
                            icon: Icons.circle,
                            size: Dimensions.height20,
                            bgColor: AppColors.mainColor,
                            iconColor: Colors.transparent,
                          )) : Container(),
                      Get
                          .find<PopularProductController>()
                          .totalItems >= 1 ?
                      Positioned(
                          right: 4,
                          top: 3,
                          child: BigText(text: '${Get
                              .find<PopularProductController>()
                              .totalItems}',
                            color: Colors.white,
                            size: Dimensions.height25 / 2,)) : Container(),

                    ],
                  ),
                );
              }),
              ],
            ),
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(30),
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(Dimensions.radius20),
                        topLeft: Radius.circular(Dimensions.radius20))),
                width: double.maxFinite,
                padding: EdgeInsets.only(top: 5, bottom: 10),
                child: Center(
                    child: BigText(
                  text: product.name!,
                  size: Dimensions.font26,
                )),
              ),
            ),
            expandedHeight: 300,
            pinned: true,
            backgroundColor: AppColors.yellowColor,
            flexibleSpace: FlexibleSpaceBar(
              background: Image.network(
                AppConstants.BASE_URL + AppConstants.UPLOADE_URL + product.img!,
                width: double.maxFinite,
                fit: BoxFit.cover,
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Column(
              children: [
                Container(
                  child: ExpandbleTextWidget(
                    text: product.description!,
                  ),
                  margin: EdgeInsets.only(
                      left: Dimensions.width20, right: Dimensions.width20),
                )
              ],
            ),
          )
        ],
      ),
      bottomNavigationBar: GetBuilder<PopularProductController>(
        builder: (controller) {
        return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: EdgeInsets.only(
                left: Dimensions.width20 * 2.5,
                right: Dimensions.width20 * 2.5,
                top: Dimensions.height10,
                bottom: Dimensions.height10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                //remove button////////////////////////////////////////////////
                GestureDetector(
                    onTap: () {
                      controller.setQuantity(false);
                    },
                    child: AppIcon(
                      icon: Icons.remove,
                      bgColor: AppColors.mainColor,
                      iconColor: Colors.white,
                      iconSize: Dimensions.iconSize24,
                    )),
                BigText(
                  text: "\$${product.price} X   ${controller.inCartItems} ",
                  color: AppColors.mainBlackColor,
                  size: Dimensions.font26,
                ),
                //add button////////////////////////////////////////////////
                GestureDetector(
                  onTap: (){
                    controller.setQuantity(true);
                  },
                  child: AppIcon(
                    icon: Icons.add,
                    bgColor: AppColors.mainColor,
                    iconColor: Colors.white,
                    iconSize: Dimensions.iconSize24,
                  ),
                ),
              ],
            ),
          ),
          Container(
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
            child: Row(
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
                  child: Icon(
                    Icons.favorite,
                    color: AppColors.mainColor,
                  ),
                ),
                GestureDetector(
                  onTap: (){
                    controller.addItem(product);
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
                      text: '\$${product.price} | Add to cart',
                      color: Colors.white,
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ); },),
    );
  }
}
