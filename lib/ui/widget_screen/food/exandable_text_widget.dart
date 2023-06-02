import 'package:flutter/material.dart';
import 'package:food_deliverya_pp/ui/shares_widget/small_text.dart';
import 'package:food_deliverya_pp/utils/colors.dart';
import 'package:food_deliverya_pp/utils/dimensions.dart';

class ExpandbleTextWidget extends StatefulWidget {
  final String text;

  const ExpandbleTextWidget({Key? key, required this.text}) : super(key: key);

  @override
  State<ExpandbleTextWidget> createState() => _ExpandbleTextWidgetState();
}

class _ExpandbleTextWidgetState extends State<ExpandbleTextWidget> {
  late String firstHalf;
  late String secondHalf;

  bool hiddenText = true;

  double textHeight = Dimensions.screenHeight / 5.63;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.text.length > textHeight) {
      firstHalf = widget.text.substring(0, textHeight.toInt());
      secondHalf =
          widget.text.substring(textHeight.toInt() + 1, widget.text.length);
    } else {
      firstHalf = widget.text;
      secondHalf = '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: secondHalf.isEmpty
          ? SmallText(text: firstHalf)
          : Column(
              children: [
                SmallText(
                  text: hiddenText
                      ? (firstHalf + "...")
                      : (firstHalf + secondHalf),
                  size: Dimensions.font16,
                  color: AppColors.paraColor,
                  height: 1.7,
                ),
                InkWell(
                  onTap: () {
                    setState(() {
                      hiddenText = !hiddenText;
                    });
                  },
                  child: Row(
                    children: [
                      SmallText(
                        text: hiddenText ? "Show more" : "Show Less",
                        color: AppColors.mainColor,
                      ),
                      hiddenText
                          ? Icon(
                              Icons.arrow_drop_down,
                              color: AppColors.mainColor,
                            )
                          : Icon(
                              Icons.arrow_drop_up,
                              color: AppColors.mainColor,
                            ),
                    ],
                  ),
                )
              ],
            ),
    );
  }
}
