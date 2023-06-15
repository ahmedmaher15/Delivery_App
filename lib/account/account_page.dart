import 'package:flutter/material.dart';
import 'package:food_deliverya_pp/base/custon_loder.dart';
import 'package:food_deliverya_pp/base/show_custom_snackbar.dart';
import 'package:food_deliverya_pp/controllers/auth_controller.dart';
import 'package:food_deliverya_pp/controllers/cart_controller.dart';
import 'package:food_deliverya_pp/controllers/user_controller.dart';
import 'package:food_deliverya_pp/routes/routes_helper.dart';
import 'package:food_deliverya_pp/ui/account_widget.dart';
import 'package:food_deliverya_pp/ui/app_icon.dart';
import 'package:food_deliverya_pp/ui/big_text.dart';
import 'package:food_deliverya_pp/utils/colors.dart';
import 'package:food_deliverya_pp/utils/dimensions.dart';
import 'package:get/get.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool _userLogedIn=Get.find<AuthController>().usrLogedIn();
    if(_userLogedIn){
      Get.find<UserController>().getUserinfo();
      print("user hase logedin");
    }
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: AppColors.mainColor,
        centerTitle: true,
        title: BigText(text: "Profile",size: Dimensions.font26,color: Colors.white,),
      ),
      body: GetBuilder<UserController>(
        builder: (userController) {
          return _userLogedIn?(userController.isLoding? Container(
            color: Colors.white,
            width: double.maxFinite,
            margin: EdgeInsets.only(top: Dimensions.height20),
            child: Column(
              children: [
                //Profile Icon bar/////////////
                AppIcon(icon: Icons.person,
                bgColor: AppColors.mainColor,
                  iconColor: Colors.white,
                  iconSize: Dimensions.height25*3,
                  size: Dimensions.height15*10,),
                SizedBox(height: Dimensions.height30,),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        ///Name///////////////
                        AccountWidget(bigText: BigText(text: userController.userModel.name,) , appIcon: AppIcon(icon: Icons.person,
                          bgColor: AppColors.mainColor,
                          iconColor: Colors.white,
                          iconSize: Dimensions.height10*5/2,
                          size: Dimensions.height10*5,)),
                        SizedBox(height: Dimensions.height20,),
                        //Phone
                        AccountWidget(bigText: BigText(text: userController.userModel.phone,) , appIcon: AppIcon(icon: Icons.phone,
                          bgColor: AppColors.yellowColor,
                          iconColor: Colors.white,
                          iconSize: Dimensions.height10*5/2,
                          size: Dimensions.height10*5,)),
                        SizedBox(height: Dimensions.height20,),
                        //Email
                        AccountWidget(bigText: BigText(text: userController.userModel.email,) , appIcon: AppIcon(icon: Icons.email,
                          bgColor: AppColors.yellowColor,
                          iconColor: Colors.white,
                          iconSize: Dimensions.height10*5/2,
                          size: Dimensions.height10*5,)),
                        SizedBox(height: Dimensions.height20,),
                        //address
                        AccountWidget(bigText: BigText(text: "Location",) , appIcon: AppIcon(icon: Icons.location_on,
                          bgColor: AppColors.yellowColor,
                          iconColor: Colors.white,
                          iconSize: Dimensions.height10*5/2,
                          size: Dimensions.height10*5,)),
                        SizedBox(height: Dimensions.height20,),
                        //message
                        AccountWidget(bigText: BigText(text: "Messages",) , appIcon: AppIcon(icon: Icons.message_outlined,
                          bgColor: Colors.redAccent,
                          iconColor: Colors.white,
                          iconSize: Dimensions.height10*5/2,
                          size: Dimensions.height10*5,)),
                        SizedBox(height: Dimensions.height20,),
                        GestureDetector(
                          onTap: (){
                           if( Get.find<AuthController>().usrLogedIn()){
                             Get.find<AuthController>().clearShardData();
                             Get.find<CartController>().clear();
                             Get.find<CartController>().clearCartHistory();
                             Get.offNamed(RouteHelper.getSignIn());
                           }else{
                            showCustomSnackBar("Please login first");
                           }
                          },
                          child: AccountWidget(
                              bigText: BigText(text: "Logout",) ,
                              appIcon: AppIcon(icon: Icons.logout,
                            bgColor: Colors.redAccent,
                            iconColor: Colors.white,
                            iconSize: Dimensions.height10*5/2,
                            size: Dimensions.height10*5,)),
                        ),
                        SizedBox(height: Dimensions.height20,),
                      ],
                    ),
                  ),
                )

              ],
            ),):
          CustomLoader()):Container(child: Center(child:Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: double.maxFinite,
                height: Dimensions.height20*8,
                margin: EdgeInsets.only(left: Dimensions.width20,right: Dimensions.width20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Dimensions.radius30),
                  color: Colors.white,
                  image: DecorationImage(image: AssetImage("assets/image/signintocontinue.png"),fit: BoxFit.cover)
                ),
              ),
              GestureDetector(
                onTap: (){
                  Get.toNamed(RouteHelper.getSignIn());
                },
                child: Container(
                  width: double.maxFinite,
                  height: Dimensions.height20*4,
                  margin: EdgeInsets.only(left: Dimensions.width20,right: Dimensions.width20),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(Dimensions.radius30),
                      color: AppColors.mainColor,
                  ),
                  child: Center(child: BigText(text: "Sign in",color: Colors.white,size: Dimensions.font26,)),
                ),
              ),
            ],
          ),),);
        }
      ),
    );
  }
}
