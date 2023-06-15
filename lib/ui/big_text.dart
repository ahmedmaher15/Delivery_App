import 'package:flutter/material.dart';
import 'package:food_deliverya_pp/utils/dimensions.dart';

class BigText extends StatelessWidget {
  BigText(
      {Key? key,
      this.color=const Color(0xFF332d2b),
      required this.text,
      this.size = 0,
      this.overFlow = TextOverflow.ellipsis})
      : super(key: key);
   Color color;
  final String text;
  final double size;
  TextOverflow overFlow;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      overflow: overFlow,
      maxLines: 1,
      style: TextStyle(
          color: color,
          fontSize:size==0? Dimensions.font20:size,
          fontWeight: FontWeight.w400,
          fontFamily: 'Roboto'),
    );
  }
}
