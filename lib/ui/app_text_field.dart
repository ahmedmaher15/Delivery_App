import 'package:flutter/material.dart';

import '../utils/colors.dart';
import '../utils/dimensions.dart';

class AppTextField extends StatelessWidget {
   AppTextField({Key? key, required this.textController, required this.hentText, required this.icon,this.obscureText}) : super(key: key);
  final TextEditingController textController;
  final String hentText;
  final IconData icon;
  bool? obscureText;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: Dimensions.width20,right: Dimensions.width20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(Dimensions.radius15),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
              blurRadius: 3,
              spreadRadius: 1,
              offset: const Offset(1,1),
              color: Colors.grey.withOpacity(0.2)
          )
        ],
      ),
      child: TextField(
        obscureText: obscureText==null?false:obscureText!,
        controller: textController,
        decoration: InputDecoration(
          hintText: hentText,
          prefixIcon: Icon(icon,color: AppColors.yellowColor,),
          //FocusBorder
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(Dimensions.radius15),
              borderSide: const BorderSide(
                  width: 1.0,
                  color: Colors.white
              )
          ),
          //enableBorder To delete the line under the TextField
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(Dimensions.radius15),
              borderSide: const BorderSide(
                  width: 1.0,
                  color: Colors.white
              )
          ),
          //border
          border:  OutlineInputBorder(
            borderRadius: BorderRadius.circular(Dimensions.radius15),
          ),
        ),
      ),
    );
  }
}
