import 'package:flutter/material.dart';
import 'package:food_deliverya_pp/utils/dimensions.dart';


class AppIcon extends StatelessWidget {
   AppIcon({Key? key, required this.icon,  this.size=40,  this.bgColor=const Color(0xfffcf4e4),  this.iconColor=const Color(0xff756d54),  this.iconSize=16,}) : super(key: key);
final IconData icon;
final Color bgColor;
final Color iconColor;
final double size;
final double iconSize;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(size/2),
        color: bgColor,
      ),
      child: Icon(icon,size: iconSize,color: iconColor,),
    );
  }
}
