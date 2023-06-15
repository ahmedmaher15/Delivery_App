import 'package:food_deliverya_pp/utils/app_constans.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
class ApiClinet extends GetConnect implements GetxService{
 late String token;
 final String appBaseUrl;
 late SharedPreferences sharedPreferences;
 late Map<String,String> _mainHeaders;
 ApiClinet({required this.appBaseUrl,required this.sharedPreferences}){
  baseUrl=appBaseUrl;
  timeout=Duration(seconds: 30);
  token=sharedPreferences.getString(AppConstants.TOKEN)??"";
  _mainHeaders={
   'Content-type':'application/json; charset=UTF-8',
   'Authorization':'Bearer $token',
  };
 }

 //repost the token with the new one when u register
 void updateHeader(String token){
  _mainHeaders={
   'Content-type':'application/json; charset=UTF-8',
   'Authorization':'Bearer $token',
  };
 }
//get data from server
 Future<Response> getData(String uri, {Map<String, String>? headers})async{
  try{
   Response response= await get(uri,headers: headers??_mainHeaders);
   return response;

  }catch(e){
   return Response(statusCode: 1,statusText: e.toString());
  }
 }

 //post data to server
 Future<Response> postData(String uri, dynamic body)async{
  print(body.toString());
  try{
   Response response=await post(uri, body,headers: _mainHeaders);
   print(response.toString());
   return response;
  }catch(e){
   print(e.toString());
   return Response(statusCode: 1,statusText: e.toString());
  }
 }

}