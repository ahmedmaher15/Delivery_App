import 'package:food_deliverya_pp/data/api/api_client.dart';
import 'package:food_deliverya_pp/models/signup_body_model.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../utils/app_constans.dart';

class AuthRebo{
  final ApiClinet apiClinet;
  final SharedPreferences sharedPreferences;

  AuthRebo({required this.apiClinet,
    required this.sharedPreferences});

  Future<Response> registration(SignUpBody signUpBody) async {
   return await apiClinet.postData(AppConstants.REGISTRATION_URI, signUpBody.toJson());
  }

  Future<String> getUserToken() async {
    return await sharedPreferences.getString(AppConstants.TOKEN)??"None";
  }

  bool usrLogedIn()  {
    return  sharedPreferences.containsKey(AppConstants.TOKEN);
  }

  Future<Response> login(String email, String password) async {
    return await apiClinet.postData(AppConstants.LOGIN_URI,{"phone":email,"password":password});
  }
  //first we call the user method and save th token in local storage
  Future<bool> saveUSerToken(String token) async {
    apiClinet.token=token;
    apiClinet.updateHeader(token);
    return  await sharedPreferences.setString(AppConstants.TOKEN, token);
  }

  Future<void> saveUserNumberAndPassword(String number,String password) async {
    try{
        await sharedPreferences.setString(AppConstants.PHONE, number);
        await sharedPreferences.setString(AppConstants.PASSWORD, password);
    }catch(e){
      throw e;
    }
  }

  bool cleashardData(){
    sharedPreferences.remove(AppConstants.TOKEN);
    sharedPreferences.remove(AppConstants.PASSWORD);
    sharedPreferences.remove(AppConstants.PHONE);
    apiClinet.token='';
    apiClinet.updateHeader('');
    return true;
  }

}