import 'dart:async';
import 'package:food_deliverya_pp/utils/dimensions.dart';
import 'package:get/get.dart';

import 'package:flutter/material.dart';
import '../../routes/routes_helper.dart';
import '../../controllers/populer_product_controller.dart';
import '../../controllers/recommended_product_controller.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin {

  late Animation<double> animation;
  late AnimationController controller;

  Future<void> _loudResource() async {
  await  Get.find<PopularProductController>().getPopulerProductList();
  await  Get.find<RecommendedProdactController>().getRecommendedProductList();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loudResource();
    controller= AnimationController(
        vsync: this,
        duration:const Duration(seconds: 2))..forward();
    animation= CurvedAnimation(
        parent: controller,
        curve: Curves.linear);
    Timer(
      const Duration(seconds: 3),
        ()=>Get.offNamed(RouteHelper.getInitiol())
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ScaleTransition(
              
              scale: animation,
              child: Center(child: Image.asset("assets/image/logo part 1.png",width: Dimensions.width10*25,))),
          Center(child: Image.asset("assets/image/logo part 2.png",width:  Dimensions.width10*25)),
        ],
      ),
    );
  }
}
