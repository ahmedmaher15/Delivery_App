import 'package:flutter/material.dart';
import 'package:food_deliverya_pp/ui/small_text.dart';

import '../utils/colors.dart';
import '../utils/dimensions.dart';
import 'icon_and_text_widget.dart';
import 'big_text.dart';

class AppDetailColumn extends StatelessWidget {
  const AppDetailColumn({Key? key, required this.text}) : super(key: key);
  final String text;


  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BigText(text: text,size: Dimensions.font26,),
        SizedBox(
          height: Dimensions.height10,
        ),
        //comments and  section
        FittedBox(
          child: Row(
            children: [
              Wrap(
                children: List.generate(
                    5,
                        (index) => Icon(
                      Icons.star,
                      color: AppColors.mainColor,
                      size: Dimensions.width15,
                    )),
              ),
              SizedBox(
                width: Dimensions.width10,
              ),
              SmallText(text: "4.5"),
              SizedBox(
                width: Dimensions.width10,
              ),
              SmallText(text: "1287"),
              SizedBox(
                width: Dimensions.width10,
              ),
              SmallText(text: "Comments"),
            ],
          ),
        ),
        SizedBox(
          height: Dimensions.height10,
        ),
        //time and section
        Row(
          children: [
            IconAndTextWidget(
                icon: Icons.circle_sharp,
                text: "Normal",
                iconColor: AppColors.iconColor1),
            const Spacer(),
            IconAndTextWidget(
                icon: Icons.location_on,
                text: "1.7km",
                iconColor: AppColors.mainColor),
            const Spacer(),
            IconAndTextWidget(
                icon: Icons.access_time_filled_rounded,
                text: "32min",
                iconColor: AppColors.iconColor2),
          ],
        ),
      ],
    );
  }
}
