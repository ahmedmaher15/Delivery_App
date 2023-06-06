import 'package:flutter/material.dart';
import 'package:food_deliverya_pp/controllers/cart_controller.dart';
import 'package:food_deliverya_pp/controllers/populer_product_controller.dart';
import 'package:food_deliverya_pp/data/repository/popular_product_repo.dart';
import 'package:food_deliverya_pp/routes/routes_helper.dart';
import 'package:food_deliverya_pp/ui/shares_widget/app_icon.dart';
import 'package:food_deliverya_pp/ui/widget_screen/food/exandable_text_widget.dart';
import 'package:food_deliverya_pp/utils/app_constans.dart';
import 'package:food_deliverya_pp/utils/dimensions.dart';
import 'package:get/get.dart';
import '../utils/colors.dart';
import '../ui/shares_widget/app_column_detail.dart';
import '../ui/shares_widget/big_text.dart';

class PopulerFoodDetail extends StatelessWidget {
  PopulerFoodDetail({Key? key, required this.pageId, required this.page}) : super(key: key);
  int pageId;
  final String page;

  @override
  Widget build(BuildContext context) {
    var product =
        Get.find<PopularProductController>().populerProductList[pageId];
    Get.find<PopularProductController>()
        .initProduct(product, Get.find<CartController>());
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar:
          GetBuilder<PopularProductController>(builder: (popularProduct) {
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
                child: Row(
                  children: [
                    GestureDetector(
                        onTap: () {
                          popularProduct.setQuantity(false);
                        },
                        child: Icon(
                          Icons.remove,
                          color: AppColors.signColor,
                        )),
                    SizedBox(
                      width: Dimensions.width10 / 2,
                    ),
                    BigText(text: "${popularProduct.inCartItems}"),
                    SizedBox(
                      width: Dimensions.width10 / 2,
                    ),
                    GestureDetector(
                        onTap: () {
                          popularProduct.setQuantity(true);
                        },
                        child: Icon(
                          Icons.add,
                          color: AppColors.signColor,
                        )),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                  popularProduct.addItem(product);
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
                    text: '\$${product.price!} | Add to cart',
                    color: Colors.white,
                  ),
                ),
              )
            ],
          ),
        );
      }),
      body: Stack(
        children: [
          //back Ground Image//////////////////////
          Positioned(
              left: 0,
              right: 0,
              child: Container(
                width: double.infinity,
                height: Dimensions.imageSizePopuler,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: NetworkImage(AppConstants.BASE_URL +
                            AppConstants.UPLOADE_URL +
                            product.img!),
                        fit: BoxFit.cover)),
              )),
          //top icons////////////////////
          Positioned(
              top: Dimensions.height45,
              left: Dimensions.width20,
              right: Dimensions.width20,
              child: Row(
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
                      child: AppIcon(icon: Icons.arrow_back_ios)),
                  GetBuilder<PopularProductController>(builder: (controller) {
                    return GestureDetector(
                      onTap: (){
                        if(controller.totalItems>=1)
                        Get.toNamed(RouteHelper.getCartPage());
                      },
                      child: Stack(
                        children: [
                          AppIcon(icon: Icons.shopping_cart_outlined),
                          controller.totalItems>=1?
                          Positioned(
                              right:0,
                              top:0,
                              child: AppIcon(
                                    icon: Icons.circle,
                                    size: Dimensions.height20,
                                    bgColor: AppColors.mainColor,
                                    iconColor: Colors.transparent,
                                  )):Container(),
                          Get.find<PopularProductController>().totalItems>=1?
                          Positioned(
                              right:4,
                              top:3,
                              child: BigText(text: '${Get.find<PopularProductController>().totalItems}',color: Colors.white,size: Dimensions.height25/2,)  ):Container(),

                        ],
                      ),
                    );
                  })
                ],
              )),
          //AppDetailColumn/////////////////
          Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              top: Dimensions.imageSizePopuler - 20,
              child: Container(
                padding: EdgeInsets.only(
                    left: Dimensions.width20,
                    right: Dimensions.width20,
                    top: Dimensions.height20),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(Dimensions.radius20),
                        topRight: Radius.circular(Dimensions.radius20)),
                    color: Colors.white),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppDetailColumn(text: product.name.toString()),
                    SizedBox(
                      height: Dimensions.height20,
                    ),
                    BigText(text: "Introduce"),
                    SizedBox(
                      height: Dimensions.height20,
                    ),
                    Expanded(
                        child: SingleChildScrollView(
                            child: ExpandbleTextWidget(
                      text: product.description!,
                    )))
                  ],
                ),
              )),
        ],
      ),
    );
  }
}
