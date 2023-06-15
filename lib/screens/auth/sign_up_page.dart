import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:food_deliverya_pp/base/custon_loder.dart';
import 'package:food_deliverya_pp/base/show_custom_snackbar.dart';
import 'package:food_deliverya_pp/controllers/auth_controller.dart';
import 'package:food_deliverya_pp/models/signup_body_model.dart';
import 'package:food_deliverya_pp/ui/app_text_field.dart';
import 'package:food_deliverya_pp/ui/big_text.dart';
import 'package:food_deliverya_pp/utils/colors.dart';
import 'package:food_deliverya_pp/utils/dimensions.dart';
import 'package:get/get.dart';

import '../../routes/routes_helper.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var emailController = TextEditingController();
    var passwordController = TextEditingController();
    var nameController = TextEditingController();
    var phoneController = TextEditingController();
    var signUpImages = ["t.png", "g.png" ,"f.png"];
    void _registration(AuthController authController){
      String email=emailController.text.trim();
      String password=passwordController.text.trim();
      String name=nameController.text.trim();
      String phone=phoneController.text.trim();

      if(name.isEmpty){
        showCustomSnackBar("Typ in your name",title: "Name");
      }else if(phone.isEmpty){
        showCustomSnackBar("Typ in your phone number",title: "Phone number");
      }else if(email.isEmpty){
        showCustomSnackBar("Typ in your email address",title: "Email address");

      }else if(!GetUtils.isEmail(email)){
        showCustomSnackBar("Typ in a valid email address",title: "Valid email address");
      }else if(password.isEmail){
        showCustomSnackBar("Typ in your password",title: "Password");

      }else if(password.length<6){
        showCustomSnackBar("Password can't be less the six characters",title: "Password");

      }else{
       SignUpBody signUpBody= SignUpBody(name: name,
           phone: phone,
           email: email,
           password: password);
        authController.registration(signUpBody).then((status){
          if(status.isSuccess){
            print("Success registration");
            Get.offNamed(RouteHelper.getInitiol());
          }else{
            showCustomSnackBar(status.message,title: "Error");
          }
        });
       print(signUpBody.toString());
      }
    }
    return Scaffold(
      backgroundColor: Colors.white,
      body: GetBuilder<AuthController>(
        builder: (authController) {
          return !authController.isLoding? SingleChildScrollView(
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
                //Email TextField
                AppTextField(
                    textController: emailController,
                    hentText: "Email",
                    icon: Icons.email),
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
                //Name TextField
                AppTextField(
                    textController: nameController,
                    hentText: "Name",
                    icon: Icons.person),
                SizedBox(
                  height: Dimensions.height20,
                ),
                //Phone TextField
                AppTextField(
                    textController: phoneController,
                    hentText: "Phone",
                    icon: Icons.phone),
                SizedBox(
                  height: Dimensions.height20 * 2,
                ),
                //SignUpButton
                GestureDetector(
                  onTap: (){
                    _registration(authController);
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
                      text: "Sign Up",
                      size: Dimensions.font20 + Dimensions.font20 / 2,
                      color: Colors.white,
                    )),
                  ),
                ),
                SizedBox(
                  height: Dimensions.height10,
                ),
                //Have An account Qestion
                RichText(
                    text: TextSpan(
                        //recognizer to macke the text clickbull
                        recognizer: TapGestureRecognizer()
                          ..onTap = () => Get.back(),
                        text: "Have an account already?",
                        style: TextStyle(
                            color: Colors.grey[500],
                            fontSize: Dimensions.font20 * .9))),
                SizedBox(
                  height: Dimensions.screenHeight * 0.04,
                ),
                //Sign Up options
                RichText(
                    text: TextSpan(
                        text: "Sign up using one of the following methods",
                        style: TextStyle(
                            color: Colors.grey[500], fontSize: Dimensions.font16))),
                //Anther way ti signUp
                Wrap(
                  children: List.generate(
                      3,
                      (index) => Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: CircleAvatar(
                              backgroundImage:
                                  AssetImage("assets/image/${signUpImages[index]}"),
                              radius: Dimensions.radius30,
                              backgroundColor: Colors.white,
                            ),
                          )),
                )
              ],
            ),
          ):CustomLoader();
        }
      ),
    );

  }

}
