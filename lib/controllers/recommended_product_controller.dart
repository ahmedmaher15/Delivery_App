import 'package:food_deliverya_pp/models/products_model.dart';
import 'package:get/get.dart';

import '../data/repository/recommended_product_repo.dart';

class RecommendedProdactController extends GetxController{
  final RecommendedProductRepo recommendedProductRepo;

  RecommendedProdactController({required this.recommendedProductRepo});
  List<dynamic> _recommendedProductList=[];
  List<dynamic> get recommendedProductList=>_recommendedProductList;
  bool _isLoded=false;
  bool get isLoded=>_isLoded;

  Future<void> getRecommendedProductList()async{
    Response response=await recommendedProductRepo.getRecommendedProducetList();
    if(response.statusCode==200 ){
      _recommendedProductList=[];
      _recommendedProductList.addAll(Product.fromJson(response.body).products );
      //print(_populerProductList);
      _isLoded=true;
      update();
    }else{
      print("error in recommended Controller");
    }
  }
}