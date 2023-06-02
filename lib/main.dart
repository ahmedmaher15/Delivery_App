/*import 'package:flutter/material.dart';



import 'package:http/http.dart'as http;
import 'dart:convert';
Future main() async{

  runApp(const  MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  fatchphoto() async {
    var ris = await http.get(Uri.parse("http://192.168.1.14/shopping-app/public/api/v1/products/popular"));
    if(ris.statusCode==200){
      print("object");
      var obj=  jsonDecode(ris.body);
      print(obj[0].toString());
    }
    else{
      print("eror");
    }
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fatchphoto();

  }
  @override
  Widget build(BuildContext context) {


    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      home:Scaffold(
appBar: AppBar(title: Text("Test"),),
        body: Center(
          child: ListView.builder(
            itemCount: 10,
              itemBuilder: (_,index)=>ListTile(
                leading: Text("title"),
                title: Text("title"),
                subtitle: Text("id"),
              )
          ),
        ),
      ),
    );
  }
}*/

import 'package:flutter/material.dart';
import 'package:food_deliverya_pp/controllers/populer_product_controller.dart';
import 'package:food_deliverya_pp/controllers/recommended_product_controller.dart';
import 'package:food_deliverya_pp/routes/routes_helper.dart';
import 'package:food_deliverya_pp/ui/widget_screen/food/recommend_food_detail.dart';
import 'package:food_deliverya_pp/ui/widget_screen/main_food_screen/food_page_body.dart';
import 'package:food_deliverya_pp/ui/widget_screen/main_food_screen/main_food__page.dart';
import 'package:get/get.dart';
import '../helper/dependencies.dart'as dep;
Future main() async{
 WidgetsFlutterBinding.ensureInitialized();
  await dep.init();

  runApp(const  MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Get.find<PopularProductController>().getPopulerProductList();
    Get.find<RecommendedProdactController>().getRecommendedProductList();
    return  GetMaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      home: const MainFoodPage(),
      initialRoute: RouteHelper.initiol,
      getPages: RouteHelper.routes,
    );
  }
}
