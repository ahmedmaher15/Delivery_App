import 'package:flutter/material.dart';
import 'package:food_deliverya_pp/utils/dimensions.dart';

class NoDataPage extends StatelessWidget {
  final String text;
  final String imgpath;
  const NoDataPage({Key? key, required this.text,  this.imgpath="assets/image/empty_cart.png"}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset( imgpath,

            height: Dimensions.height45*4,
            width: Dimensions.width45*4,
          ),
          SizedBox(height:MediaQuery.of(context).size.height*0.03 ,),
          Text(text,style: TextStyle(
            fontSize: MediaQuery.of(context).size.height*0.0175,color: Theme.of(context).disabledColor
          ),)
        ],
      ),
    );
  }
}