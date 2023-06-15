import 'package:flutter/material.dart';
import 'package:food_deliverya_pp/utils/dimensions.dart';

import 'app_icon.dart';
import 'big_text.dart';

class AccountWidget extends StatelessWidget {
  AppIcon appIcon;
  BigText bigText;
   AccountWidget({required this.bigText,required this.appIcon, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            offset: Offset(0,2),
            color: Colors.grey.withOpacity(0.2),
            blurRadius: 2
          )
        ]
      ),
      padding: EdgeInsets.only(
          left: Dimensions.width20,
          top: Dimensions.height10,
          bottom: Dimensions.height10),
      child: Row(
        children: [
          appIcon,
          SizedBox(width: Dimensions.width20,) ,
          bigText
        ],
      ),
    );
  }
}
