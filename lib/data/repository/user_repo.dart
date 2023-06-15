import 'package:food_deliverya_pp/data/api/api_client.dart';
import 'package:food_deliverya_pp/utils/app_constans.dart';
import 'package:get/get.dart';

class UserRepo{
  final ApiClinet apiClinet;
  UserRepo({required this.apiClinet});
  Future<Response> getUserInfo()async{
    return await apiClinet.getData(AppConstants.USER_INFO_URI);
  }
}