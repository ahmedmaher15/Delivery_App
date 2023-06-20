import 'package:food_deliverya_pp/data/api/api_client.dart';
import 'package:food_deliverya_pp/models/address_model.dart';
import 'package:food_deliverya_pp/utils/app_constans.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter_platform_interface/src/types/location.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocationRepo{
final ApiClinet apiClinet;
final SharedPreferences sharedPreferences;

  LocationRepo({required this.apiClinet,required this.sharedPreferences});

  Future<Response> getAddressfromGeocode(LatLng latLng) async {
    return await apiClinet.getData("${AppConstants.GEOCODE_URI}?lat=${latLng.latitude}&lng=${latLng.longitude}" );
  }

  String getUserAddress() {
    return sharedPreferences.getString(AppConstants.USER_ADDRESS)??"";

  }

  Future<Response> addAddress(AddressModel addressModel)async{
    return await apiClinet.postData(AppConstants.ADD_USER_ADDRESS, addressModel.toJson());
  }

  Future<Response> getAllAddress() async{
    return await apiClinet.getData(AppConstants.ADDRESS_LIST_URI);
  }

  Future<bool> saveUserAddress(String address) async {
    apiClinet.updateHeader(sharedPreferences.getString(AppConstants.TOKEN)!);
    return await sharedPreferences.setString(AppConstants.USER_ADDRESS, address);
  }



}