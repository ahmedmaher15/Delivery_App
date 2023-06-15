import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:food_deliverya_pp/base/no_data_page.dart';
import 'package:food_deliverya_pp/models/cart_model.dart';
import 'package:food_deliverya_pp/routes/routes_helper.dart';
import 'package:food_deliverya_pp/ui/app_icon.dart';
import 'package:food_deliverya_pp/ui/big_text.dart';
import 'package:food_deliverya_pp/ui/small_text.dart';
import 'package:food_deliverya_pp/utils/app_constans.dart';
import 'package:food_deliverya_pp/utils/colors.dart';
import 'package:food_deliverya_pp/utils/dimensions.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../controllers/cart_controller.dart';

class CartHistory extends StatelessWidget {
  const CartHistory({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var getCartHistoryList =
        Get.find<CartController>().getCartHistoryList().reversed.toList();
    Map<String, int> cartItemsPerOrder = Map();
    for (int i = 0; i < getCartHistoryList.length; i++) {
      if (cartItemsPerOrder.containsKey(getCartHistoryList[i].time)) {
        cartItemsPerOrder.update(
            getCartHistoryList[i].time!, (value) => ++value);
      } else {
        cartItemsPerOrder.putIfAbsent(getCartHistoryList[i].time!, () => 1);
      }
    }

    List<int> cartitemPerOrderTimeToList() {
      return cartItemsPerOrder.entries.map((e) => e.value).toList();
    }
    List<String> cartOrderTimeToList() {
      return cartItemsPerOrder.entries.map((e) => e.key).toList();
    }


    List<int> itemPerOrder = cartitemPerOrderTimeToList();

    //function for rearrange time for the history items
    var listCounter=0;
    Widget timeWidget(intIndex){
      var outPutDate=DateTime.now().toString();
     if(intIndex <getCartHistoryList.length){
       DateTime parsDate =  DateFormat("yyyy-MM-DD HH:mm:ss").parse(getCartHistoryList[listCounter].time!);
       var inputdate =DateTime.parse(parsDate.toString());
       var outPutFormat= DateFormat("MM/dd/yyyy hh:mm a ");
        outPutDate=outPutFormat.format(inputdate);
     }
      return BigText(text:"${outPutDate}");
    }

    return Scaffold(
      body: Column(
        children: [
          //header or app bar/////////////////
          Container(
            color: AppColors.mainColor,
            width: double.maxFinite,
            height: Dimensions.height20*5,
            padding: EdgeInsets.only(top: Dimensions.height45),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                BigText(text: "Cart History",color: Colors.white,),
                AppIcon(icon: Icons.shopping_cart_outlined,iconColor: AppColors.mainColor,bgColor: AppColors.yellowColor,),
              ],
            ),
          ),
          //body.//////////////
          GetBuilder<CartController>(
            builder: (_cartController) {
              if (_cartController.getCartHistoryList().isNotEmpty) {
                return Expanded(
                child: Container(
                  margin: EdgeInsets.only(
                      top: Dimensions.height20,
                      left: Dimensions.width20,
                      right: Dimensions.width20),
                  child: MediaQuery.removePadding(removeTop: true,context: context,
                    child: ListView(
                    children: [
                      for (int i=0;i<itemPerOrder.length;i++)
                        Container(
                          height: Dimensions.height30*4,
                            margin: EdgeInsets.only(bottom: Dimensions.height20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              timeWidget(listCounter),
                              SizedBox(height:Dimensions.height10 ,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Wrap(
                                    direction: Axis.horizontal,
                                    children: List.generate(itemPerOrder[i], (index) {
                                      if(listCounter<getCartHistoryList.length){
                                        listCounter++;
                                      }
                                      return index<=2?Container(
                                        width: Dimensions.width20*4,
                                        height: Dimensions.height20*4,
                                        margin: EdgeInsets.only(right: Dimensions.width10/2),
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(Dimensions.radius15/2),
                                            image: DecorationImage(fit: BoxFit.cover,
                                                image: NetworkImage(AppConstants
                                                    .BASE_URL +
                                                    AppConstants.UPLOADE_URL +
                                                    getCartHistoryList[listCounter-1]
                                                        .img!,))),

                                      ):Container();

                                    }),
                                  ),
                                  Container(
                                   height: Dimensions.height20*4,
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      crossAxisAlignment: CrossAxisAlignment.end,
                                      children: [
                                        SmallText(text: "Total",color: AppColors.titleColor,),
                                        BigText(text:itemPerOrder[i]==1? "${itemPerOrder[i]} Item":"${itemPerOrder[i]} Items",color: AppColors.titleColor,),
                                        GestureDetector(
                                          onTap: (){
                                            var orderTime=cartOrderTimeToList();
                                            //print("Order Time  ${orderTime[i]}");
                                            Map<int,CartModel> moreOrder={};
                                            for(int j=0;j<getCartHistoryList.length;j++){
                                            if(getCartHistoryList[j].time==orderTime[i]){
                                              moreOrder.putIfAbsent(getCartHistoryList[j].id!, () =>
                                              CartModel.fromJson(jsonDecode( jsonEncode(getCartHistoryList[j])))
                                              );
                                              }
                                            }
                                            Get.find<CartController>().setItems=moreOrder;
                                            Get.find<CartController>().addToCartList();
                                            Get.toNamed(RouteHelper.getCartPage());
                                          },
                                          child: Container(
                                            padding: EdgeInsets.symmetric(horizontal: Dimensions.width10,vertical: Dimensions.height10/2),
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(Dimensions.radius15/3),
                                              border: Border.all(width: 1,color: AppColors.mainColor),
                                            ),
                                            child: SmallText(text: 'one more',color: AppColors.mainColor,),
                                          ),
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
                        )
                    ],
                  ),)
                ),
              );
              } else {
                return Container(
                    height: MediaQuery.of(context).size.height/1.5,
                    child: const Center(
                      child: NoDataPage(
                      text: "You didn't buy anything so far !",
                      imgpath: "assets/image/empty_box.png",
                  ),
                    ));
              }
          }
          )
        ],
      ),
    );
  }
}
