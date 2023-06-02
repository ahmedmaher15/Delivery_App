import 'package:flutter/material.dart';
import 'package:food_deliverya_pp/ui/shares_widget/small_text.dart';
import 'package:food_deliverya_pp/utils/dimensions.dart';

class IconAndTextWidget extends StatelessWidget {
  const IconAndTextWidget({Key? key, required this.icon, required this.text,  required this.iconColor}) : super(key: key);
  final IconData icon;
  final String text;

  final Color iconColor;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon,color: iconColor,size: Dimensions.iconSize24,),
        SizedBox(width: Dimensions.width10/2,),
        SmallText(text: text,)
      ],
    );
  }
}
