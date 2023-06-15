import 'package:flutter/material.dart';
import 'package:food_deliverya_pp/utils/dimensions.dart';

class SmallText extends StatelessWidget {
  SmallText(
      {Key? key,
        this.color=const Color(0xFFccc7c5),
        required this.text,
        this.size,  this.height=1.2
        })
      : super(key: key);
  Color color;
  final String text;
  final double? size;
  final double height;


  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
          color: color,
          fontSize:size ?? Dimensions.height25/2,
          height: height,
          fontFamily: 'Roboto'),
    );
  }
}
