import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:food_deliverya_pp/base/custon_loder.dart';
import 'package:food_deliverya_pp/routes/routes_helper.dart';
import 'package:food_deliverya_pp/screens/auth/sign_up_page.dart';
import 'package:food_deliverya_pp/ui/app_text_field.dart';
import 'package:food_deliverya_pp/ui/big_text.dart';
import 'package:food_deliverya_pp/utils/colors.dart';
import 'package:food_deliverya_pp/utils/dimensions.dart';
import 'package:get/get.dart';

import '../../base/show_custom_snackbar.dart';
import '../../controllers/auth_controller.dart';
import '../../models/signup_body_model.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var phoneController = TextEditingController();
    var passwordController = TextEditingController();

    void _login(AuthController authController){
      String phone=phoneController.text.trim();
      String password=passwordController.text.trim();
     if(phone.isEmpty){
        showCustomSnackBar("Typ in your phone ",title: "Your phone");

      }else if(password.length<6){
        showCustomSnackBar("Password can't be less the six characters",title: "Password");

      }else{
        authController.login(phone,password).then((status){
          if(status.isSuccess){
            print("Success Login");
            Get.toNamed(RouteHelper.getInitiol());
          }else{
            showCustomSnackBar(status.message,title: "Error");
          }
        });
      }
    }
    return Scaffold(
      backgroundColor: Colors.white,
      body: GetBuilder<AuthController>(
        builder: (authController) {
          return authController.isLoding==false? SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: Dimensions.screenHeight * 0.05,
                ),
                //Sign Up Icon////////////////
                Container(
                  height: Dimensions.screenHeight * 0.25,
                  child: Center(
                    child: CircleAvatar(
                      backgroundColor: Colors.white,
                      backgroundImage: AssetImage("assets/image/logo part 1.png"),
                      radius: 80,
                    ),
                  ),
                ),
                //Hello Text
                Container(
                  margin: EdgeInsets.only(left: Dimensions.width20),
                  width: double.maxFinite,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      BigText(
                        text: "Hello",
                        size: Dimensions.font26 * 3 + Dimensions.font20 / 2,
                      ),
                      BigText(
                        text: "Sign into your account",
                        color: Colors.grey[600]!,
                      ),
                      SizedBox(
                        height: Dimensions.height20 * 2,
                      )
                    ],
                  ),
                ),
                //Email TextField
                AppTextField(
                    textController: phoneController,
                    hentText: "Phone",
                    icon: Icons.phone),
                SizedBox(
                  height: Dimensions.height20,
                ),
                //Password TextField
                AppTextField(
                    obscureText: true,
                    textController: passwordController,
                    hentText: "Password",
                    icon: Icons.password_sharp),
                SizedBox(
                  height: Dimensions.height20,
                ),
                //Sign Into Your Account Text
                Container(
                  margin: EdgeInsets.only(
                      left: Dimensions.width20, right: Dimensions.width20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      RichText(
                          text: TextSpan(
                              text: "Sign into your account",
                              style: TextStyle(
                                  color: Colors.grey[500],
                                  fontSize: Dimensions.font20 * .9))),
                    ],
                  ),
                ),
                SizedBox(
                  height: Dimensions.screenHeight * 0.04,
                ),
                //SignIpButton
                GestureDetector(
                  onTap: (){
                    _login(authController);
                  },
                  child: Container(
                    width: Dimensions.screenWidth / 2,
                    height: Dimensions.screenHeight / 13,
                    decoration: BoxDecoration(
                      color: AppColors.mainColor,
                      borderRadius: BorderRadius.circular(Dimensions.radius30),
                    ),
                    child: Center(
                        child: BigText(
                      text: "Sign in",
                      size: Dimensions.font20 + Dimensions.font20 / 2,
                      color: Colors.white,
                    )),
                  ),
                ),
                SizedBox(
                  height: Dimensions.screenHeight * 0.04,
                ),
                //Sign Up options
                RichText(
                  text: TextSpan(
                      text: "Don't have and account?",
                      style: TextStyle(
                          color: Colors.grey[500], fontSize: Dimensions.font20),
                      children: [
                        TextSpan(
                          recognizer: TapGestureRecognizer()
                            ..onTap = () => Get.to(() => SignUpPage(),transition: Transition.fade),
                          text: "Create",
                          style: TextStyle(
                              color: AppColors.mainBlackColor,
                              fontSize: Dimensions.font20,
                              fontWeight: FontWeight.bold),
                        )
                      ]),
                ),
              ],
            ),
          ):CustomLoader();
        }
      ),
    );
  }
}
