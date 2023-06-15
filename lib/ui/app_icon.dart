import 'package:flutter/material.dart';
import 'package:food_deliverya_pp/utils/dimensions.dart';


class AppIcon extends StatelessWidget {
   AppIcon({Key? key, required this.icon,  this.size,  this.bgColor=const Color(0xfffcf4e4),  this.iconColor=const Color(0xff756d54),  this.iconSize,}) : super(key: key);
final IconData icon;
final Color bgColor;
final Color iconColor;
final double? size;
final double? iconSize;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: size??Dimensions.height20*2,
      height: size??Dimensions.height20*2,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(size??Dimensions.height20),
        color: bgColor,
      ),
      child: Icon(icon,size: iconSize??Dimensions.height15,color: iconColor,),
    );
  }
}
